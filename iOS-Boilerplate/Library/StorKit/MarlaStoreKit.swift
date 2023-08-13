//
//  StoreKit.swift
//  lishop-swift-uikit
//
//  Created by Daniel Vela on 2/3/23.
//

import Foundation
import StoreKit

protocol StoreKitDelegate: class {
    func productsDownloaded(_ availableProducts: [String: SKProduct])
    func paymentStarted()
    func restoreStarted()
    func paymentCompleted()
    func paymentCanceled(_ error: Error)
}

class StoreKit: NSObject {
  static let baseTip = "org.veladan.PracticeEnglishApp.basetip"
  static let generousTip = "org.veladan.PracticeEnglishApp.generoustip"

  var delegate: StoreKitDelegate?
  var isAuthorizedForPayments: Bool {
    SKPaymentQueue.canMakePayments()
  }

  private var productRequest: SKProductsRequest!
  // Use a ProductId as index
  private var availableProducts: [String: SKProduct] = [:]

  static func canMAkePayments() -> Bool {
      SKPaymentQueue.canMakePayments()
  }
  func configureObserver(with delegate: StoreKitDelegate?, productIds: [String]) {
      self.delegate = delegate
      SKPaymentQueue.default().add(self)

      fetchProducts(matchingIdentifiers: productIds)
  }

  func removeObserver() {
      SKPaymentQueue.default().remove(self)
  }

  func restorePurchases() {
      delegate?.restoreStarted()
      SKPaymentQueue.default().restoreCompletedTransactions()
  }

  func buy(product: SKProduct) {
      guard isAuthorizedForPayments else {
          UIViewController.showAlertOnTopController(NSLocalizedString("You don't have permission to buy.",
                                                                      comment: ""))
          return
      }
      delegate?.paymentStarted()
      let payment = SKPayment(product: product)
      SKPaymentQueue.default().add(payment)
  }

  private func fetchProducts(matchingIdentifiers identifiers: [String]) {
      // Create a set for the product identifiers.
      let productIdentifiers = Set(identifiers)

      // Initialize the product request with the above identifiers.
      productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
      productRequest.delegate = self

      // Send the request to the App Store.
      productRequest.start()
  }
}

extension StoreKit: SKPaymentTransactionObserver {
    // Sent when the transaction array has changed (additions or state changes).
    // Client should check state of transactions and finish as appropriate.
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        DispatchQueue.main.async {
            for transaction in transactions {
                switch transaction.transactionState {
                case .purchasing:
                    break
                    // Do not block the UI. Allow the user to continue using the app.
                case .deferred:
                    print("Messages.deferred")
                    // The purchase was successful.
                case .purchased:
                    self.handlePurchased(transaction)
                    // The transaction failed.
                case .failed:
                    self.handleFailed(transaction)
                    // There're restored products.
                case .restored:
                    self.handleRestored(transaction)
                @unknown default:
                    fatalError("Messages.unknownPaymentTransaction")
                }
            }
        }
    }

    // Sent when all transactions from the user's purchase history have successfully been added back to the queue.
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        delegate?.paymentCompleted()
    }

    // Sent when an error is encountered while adding transactions from the user's purchase history back to the queue.
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        delegate?.paymentCanceled(error)
    }

    private func handlePurchased(_ transaction: SKPaymentTransaction) {
        recordTransaction(transaction)
        SKPaymentQueue.default().finishTransaction(transaction)
        delegate?.paymentCompleted()
    }

    private func handleFailed(_ transaction: SKPaymentTransaction) {
        delegate?.paymentCanceled(transaction.error ?? GenericError())
        SKPaymentQueue.default().finishTransaction(transaction)
    }

    private func handleRestored(_ transaction: SKPaymentTransaction) {
        recordTransaction(transaction)
        SKPaymentQueue.default().finishTransaction(transaction)
    }

    private func recordTransaction(_ transaction: SKPaymentTransaction) {
        let transactionId = transaction.transactionIdentifier ?? "transactionId no found"
        let transactionDate = transaction.transactionDate?.description ?? "transaction date not found"
        print("StoreKit transaction: \(transactionId) at \(transactionDate)")
    }
}

extension StoreKit: SKProductsRequestDelegate, SKRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        // products contains products whose identifiers have been recognized by the App Store.
        // As such, they can be purchased.
        if !response.products.isEmpty {
            response.products.forEach { product in
                availableProducts[product.productIdentifier] = product
            }
            delegate?.productsDownloaded(availableProducts)
        }

        // invalidProductIdentifiers contains all product identifiers not recognized by the App Store.
        if !response.invalidProductIdentifiers.isEmpty {
            print("invalidProductIdentifiers: \(response.invalidProductIdentifiers)")
        }
    }

    func requestDidFinish(_ request: SKRequest) {
        print("requestDidFinish")
    }

    func request(_ request: SKRequest, didFailWithError error: Error) {
        fatalError("requestDidFinish \(error.localizedDescription)")
    }
}

extension SKProduct {
    /// - returns: The cost of the product formatted in the local currency.
    var regularPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)
    }
}

class GenericError: Error {
}
