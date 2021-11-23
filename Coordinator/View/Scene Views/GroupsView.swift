//
//  GroupsView.swift
//  Cell Prototype
//
//  Created by Anna Delova on 10/29/21.
//

import SwiftUI

struct GroupsView: View {
    
    @ObservedObject var viewModel: GroupsViewModel

    init(viewModel:GroupsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {

        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear

        return NavigationView {
            VStack {
                Divider()
                List(viewModel.groups) {group in
                    GroupCellPrototype(group: group)
                }
                .listStyle(GroupedListStyle())
                .onAppear{
                    viewModel.getGroups()
                }
                .navigationBarTitle("List of my Groups")
                .navigationBarItems(trailing:
                                        NavigationLink(
                                            destination: SearchGroupsView(),
                                            label: {
                                                Text("Explore New Groups")
                                                    .foregroundColor(.gray)
                                                    .imageScale(.large)
                                                Image(systemName: "chevron.right.circle.fill")
                                                    .accentColor(Color(.systemTeal))
                                            }))
            }
        }
    }
}


