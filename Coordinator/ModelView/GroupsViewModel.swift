//
//  GroupsViewModel.swift
//  Coordinator
//
//  Created by Anna Delova on 11/23/21.
//


import SwiftUI

class GroupsViewModel: ObservableObject {

    @Published var isLoaded: Bool = false
    @Published var groups = [MyVkGroup]()




        public func getGroups() {
            NetworkService().getGroups { (groups) in
                self.groups = groups
            }
        }
}
