// Generated using Sourcery 0.15.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif













class FakeProtocolMock: FakeProtocol {

//MARK: - run

var runCallsCount = 0
var runCalled: Bool {
return runCallsCount > 0
}
var runClosure: (() -> Void)?

func run() {
runCallsCount += 1
runClosure?()
}

//MARK: - show

var showResultCallsCount = 0
var showResultCalled: Bool {
return showResultCallsCount > 0
}
var showResultReceivedResult: String?
var showResultClosure: ((String) -> Void)?

func show(result: String) {
showResultCallsCount += 1
showResultReceivedResult = result
showResultClosure?(result)
}

}
