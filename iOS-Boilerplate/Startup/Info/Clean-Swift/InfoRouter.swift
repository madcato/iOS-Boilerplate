import UIKit

@objc protocol InfoRoutingLogic {
    func dismiss()
}

class InfoRouter: NSObject, InfoRoutingLogic {
    weak var viewController: InfoViewController?
    var dataStore: LoginDataStore?

    // MARK: Routing

    static func showInfo(over viewController: UIViewController) {
        let storyboard = UIStoryboard(name: "Info", bundle: nil)
        if let destinationVC = storyboard.instantiateInitialViewController() {
            destinationVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            destinationVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
            viewController.present(destinationVC, animated: true, completion: nil)
        }
    }

    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
