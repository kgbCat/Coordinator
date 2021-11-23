//
//  Friend.swift
//  SwiftUI TEST
//
//  Created by Anna Delova on 11/9/21.
//

import Foundation

struct Response: Codable {
    let response: Friends
}

struct Friends: Codable {
    let items: [Friend]
}

struct Friend: Codable, Identifiable, Hashable {
    let id: Int
    let first_name: String
    let last_name: String
    let photo_200_orig: String
    var fullName: String { "\(first_name) \(last_name)" }

}


