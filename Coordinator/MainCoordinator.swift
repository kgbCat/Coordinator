//
//  MainCoordinator.swift
//  Coordinator
//
//  Created by Anna Delova on 11/18/21.
//

import UIKit
import Combine
import SwiftUI

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    var navigationController: UINavigationController

    private let loginViewModel: WebViewModel = WebViewModel()
    private var cancellables: [AnyCancellable] = []

    init(navigationController: UINavigationController) {
        let loginWebView = VkLoginWebView(webViewModel: loginViewModel)
        let loginView = UIHostingController(rootView: loginWebView)
        self.navigationController = UINavigationController(rootViewController: loginView)

    }
    func start() {
        loginViewModel.$isAuthorised.subscribe(on: RunLoop.main).sink { [weak self] isUserLoggedIn in
            guard let self = self else { return }
            if !isUserLoggedIn {
                self.navigationController.popViewController(animated: true)
            } else {
                let tapBarView = self.createTabBarView()
                self.navigationController.pushViewController(tapBarView, animated: true)
            }
        }.store(in: &cancellables)
    }

    private func createTabBarView() -> UIViewController {
        let tapBarView = TabBarView()
        return UIHostingController(rootView: tapBarView)
    }


}
//
//class MainCoordinator {
//
//    let navigationController: UINavigationController
//    private let webViewModel = WebViewModel()
//    private let loginViewModel: VkLoginWebView = VkLoginWebView()
//    private var cancellables: Set<AnyCancellable> = []
//
//    init(navigationController: UINavigationController) {
//        let loginView = VkLoginWebView(webViewModel: webViewModel)
//        let loginViewController = UIHostingController(rootView: loginView)
//        self.navigationController = UINavigationController(rootViewController: loginViewController)
//    }
//
//    public func start() {
//        loginViewModel.$isUserLoggedIn.subscribe(on: RunLoop.main).sink { [weak self] isUserLoggedIn in
//            guard let self = self else { return }
//            if !isUserLoggedIn {
//                self.navigationController.popToRootViewController(animated: true)
//            } else {
//                let citiesViewController = self.createCitiesController()
//                self.navigationController.pushViewController(citiesViewController, animated: true)
//            }
//        }.store(in: &cancellables)
//    }
//
//    private func createCitiesController() -> UIViewController {
//        let context = coreDataService.context
//        let citiesView = CitiesView().environment(\.managedObjectContext, context)
//        return UIHostingController(rootView: citiesView)
//    }
//}
