//
//  ContentView.swift
//  Cell Prototype
//
//  Created by Anna Delova on 10/27/21.
//

import SwiftUI

struct MainView: View {
    @State var loaded = false
    @ObservedObject var webViewModel = WebViewModel()

// set NavBarTitle color

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.init(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))]
    }
    var body: some View {

        NavigationView {
            VStack {
                VkLoginWebView(webViewModel: webViewModel)
                NavigationLink(destination: TabBarView(), isActive: $webViewModel.isAuthorised, label: {
                    EmptyView()
                })
            }
        }
    }
}


