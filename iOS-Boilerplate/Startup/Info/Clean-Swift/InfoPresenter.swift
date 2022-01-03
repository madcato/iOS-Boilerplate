import UIKit

protocol InfoPresentationLogic {
    func presentInfo()
}

class InfoPresenter: InfoPresentationLogic {
    weak var viewController: InfoDisplayLogic?

    // MARK: Do something

    func presentInfo() {
        viewController?.displayInfo()
    }
}
