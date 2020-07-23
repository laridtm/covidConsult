
import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = CountriesListViewController(nibName: "CountriesListViewController", bundle: nil)
        let nav = UINavigationController(rootViewController: controller)
        window?.rootViewController = nav
        let dataProvider = CountriesListDataProvider(config: Realm.Configuration())
        let worker = CountriesListWorker(dataProvider: dataProvider)
        let presenter = CountriesListPresenter(view: controller)
        let interactor = CountriesListInteractor(presenter: presenter, worker: worker)
        controller.interactor = interactor
        window?.makeKeyAndVisible()
        return true
    }
}
