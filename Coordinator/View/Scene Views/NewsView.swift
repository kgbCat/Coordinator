//
//  NewsView.swift
//  Cell Prototype
//
//  Created by Anna Delova on 10/29/21.
//

import SwiftUI

struct NewsView: View {

    @ObservedObject var viewModel: NewsViewModel

    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.sortedProfiles, id:\.self) { profile in
                        ProfileCellPrototype(profile: profile)
                        ForEach(viewModel.dictionary.keys.sorted(), id:\.self) { key in
                            if profile.id == key {
                                if let item = viewModel.dictionary[key]?.first {
                                    if item.attachments.contains(where: { attach in
                                        attach.photo.owner_id != 0
                                    }) {
                                        ItemCellPrototype(item: item)

                                    }
                                }
                            }
                        }
                    }
                }
                .onAppear{
                    viewModel.getNews()
                }
            }
            .navigationTitle("Whats New Today")
        }
    }
}

