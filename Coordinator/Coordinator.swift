//
//  Coordinator.swift
//  Coordinator
//
//  Created by Anna Delova on 11/22/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController{ get set}

    func start()
}
