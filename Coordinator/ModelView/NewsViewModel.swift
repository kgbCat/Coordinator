//
//  NewsViewModel.swift
//  Coordinator
//
//  Created by Anna Delova on 11/23/21.
//

import SwiftUI

class NewsViewModel: ObservableObject {
    @Published var isLoaded: Bool = false
    @Published var newsItems = [VkItem]()
    @Published var sortedProfiles = [VkProfile]()

    @Published var dictionary : Dictionary <Int , [VkItem]> = [:]


    private func clean(profiles: [VkProfile], items: [VkItem]) -> [VkItem] {
        var myItems:[VkItem] = []
        for profile in profiles {
            for item in items {
                if  profile.id == item.id && !item.attachments.isEmpty {
                    myItems.append(item)
                }
            }
        }
        return myItems
    }

        public func getNews() {
            NetworkService().getNews { [weak self] (items, profiles) in
                guard
                    let items = items,
                    let profiles = profiles
                else { return }

                let myProfiles = profiles.filter {
                    $0.firstName != "DELETED"
                }
                guard let myItems  = self?.clean(profiles: myProfiles, items: items) else { return }
                self?.newsItems = myItems
                let myDictionary = Dictionary(grouping: myItems) { item in
                    return item.id
                }
                self?.sortedProfiles = myProfiles
                self?.dictionary = myDictionary
            }
        }
}

