//
//  FriendsViewModel.swift
//  Coordinator
//
//  Created by Anna Delova on 11/22/21.
//


import SwiftUI

class FriendsViewModel: ObservableObject {
    @Published var isLoaded: Bool = false
    @Published var sectionDictionary : Dictionary <String , [Friend]> = [:]

    var friends : [Friend] = []


    //MARK:- sectioned dictionary
     func getSectionedDictionary() -> Dictionary <String , [Friend]> {
        let sectionDictionary: Dictionary<String, [Friend]> = {
            return Dictionary(grouping: friends, by: {
                let name = $0.first_name
                let normalizedName = name.folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
                let firstChar = String(normalizedName.first!).uppercased()
                return firstChar
            })
        }()
        return sectionDictionary
    }

        public func getFriends() {
            NetworkService().getFriends { [weak self] friends in
                guard
                    let self = self else { return }
                self.friends = friends.filter { $0.first_name != "DELETED" }
                self.sectionDictionary = self.getSectionedDictionary()
            }
        }
}
