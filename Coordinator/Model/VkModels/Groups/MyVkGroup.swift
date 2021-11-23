//
//  Group.swift
//  SwiftUI TEST
//
//  Created by Anna Delova on 11/9/21.
//

import Foundation

struct GroupResponse: Codable {
    let response: MyVkGroups
}

struct MyVkGroups: Codable {
    let items: [MyVkGroup]
}

struct MyVkGroup: Codable, Identifiable {
    var id: Int
    var name: String
    var photo_200: String
}
