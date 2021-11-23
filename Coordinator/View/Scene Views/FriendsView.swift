//
//  FriendsView.swift
//  SwiftUI TEST
//
//  Created by Anna Delova on 11/9/21.
//

import SwiftUI

struct FriendsView: View {

    @ObservedObject var viewModel: FriendsViewModel

    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
    }
    @State var searchTerm = ""


    var body: some View {
        NavigationView {
            VStack {
                Divider()
                SearchBar(searchTerm: $searchTerm)
                List {
                    ForEach(
                        viewModel.sectionDictionary.keys.sorted(),id:\.self) { key in
                            if let friends = viewModel.sectionDictionary[key]!.filter(
                            {
                                (friend) in
                                self.searchTerm.isEmpty ? true: "\(friend)".lowercased().contains(self.searchTerm.lowercased())}),
                           !friends.isEmpty
                        {
                            Section(header:
                                        Text("\(key)")) {
                                ForEach (friends) { friend in
                                    ZStack {
                                        NavigationLink(
                                            destination:GalleryView(userId: friend.id)) {
                                            EmptyView()
                                        }
                                        .opacity(0)
                                        UserCellPrototype(friend: friend)
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .onAppear{
                    viewModel.getFriends()
                }

            }
            .navigationTitle("List of my friends")
        }
    }
}
