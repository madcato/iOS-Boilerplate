import UIKit

protocol InfoDisplayLogic: AnyObject {
    func displayInfo()
}

class InfoViewController: UIViewController, InfoDisplayLogic {
    var router: (NSObjectProtocol & InfoRoutingLogic)?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Outlets
    @IBOutlet private weak var appInfoLabel: UILabel!

    // MARK: Actions
    @IBAction private func closeButtonTapped(_ sender: UIBarButtonItem) {
        router?.dismiss()
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let presenter = InfoPresenter()
        let router = InfoRouter()
        viewController.router = router
        presenter.viewController = viewController
        router.viewController = viewController
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        displayInfo()
    }

    func displayInfo() {
        appInfoLabel.text = AppInfo.appInfo
    }
}
