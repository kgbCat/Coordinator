//
//  TabBarView.swift
//  SwiftUI TEST
//
//  Created by Anna Delova on 11/5/21.
//

import SwiftUI

struct TabBarView: View {

    let mainCoordinator = MainCoordinator(navigationController: UINavigationController())

    @ObservedObject var webViewModel = WebViewModel()
    @ObservedObject var friendViewModel = FriendsViewModel()
    @ObservedObject var newsViewModel = NewsViewModel()
    @ObservedObject var groupsViewModel = GroupsViewModel()

    var body: some View {

            TabView {
                FriendsView(viewModel: friendViewModel)
                    .tabItem {
                        Image(systemName: "person")
                        Text( "friends")
                    }
                GroupsView(viewModel: groupsViewModel)
                    .tabItem {
                        Image(systemName:"person.2")
                        Text("groups")
                    }
                NewsView(viewModel: newsViewModel)
                    .tabItem {
                        Image(systemName:"newspaper")
                        Text("news")
                    }
            }
            .accentColor(Color(#colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)))
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {

                webViewModel.isAuthorised = false
                Session.instance.token =  ""
                Session.instance.userId = 0
                mainCoordinator.start()

                }) {
                    Image(systemName: "lock").foregroundColor(.gray).imageScale(.large)
                })
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
