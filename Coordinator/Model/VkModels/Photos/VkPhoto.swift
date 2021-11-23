//
//  VkPhoto.swift
//  SwiftUI TEST
//
//  Created by Anna Delova on 11/16/21.
//

import Foundation
import SwiftyJSON



struct AlbumPhoto: Codable, Identifiable, Hashable {
    var id: Int

    static func == (lhs: AlbumPhoto, rhs: AlbumPhoto) -> Bool {
//        lhs.sizes == rhs.sizes
//        lhs.likes == rhs.likes
        lhs.id == rhs.id

    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var sizes: [VkPhotoSize]
    var likes: VkPhotoLikes

//    var photo: VkPhotoSize! {
//        sizes.first(where: { ("y").contains($0.type) })
//    }
//    var owner_id: Int

}
extension AlbumPhoto {
    init(_ json: JSON) {
        self.id = json["owner_id"].intValue
        let sizes = json["sizes"].arrayValue
        self.sizes = sizes.map { VkPhotoSize($0) }
        self.likes = VkPhotoLikes(json["likes"])
    }

}

struct VkPhotoSize: Codable {
//    var height: Int
    var url: String
    var type: String
//    var width: Int
}


extension VkPhotoSize {
    init(_ json: JSON) {
        self.url = json["url"].stringValue
        self.type = json["type"].stringValue
    }
}

struct VkPhotoLikes: Codable {
    var count: Int

    init(_ json: JSON) {
        self.count = json["count"].intValue
    }
}




//
//
//struct PhotoResponse: Decodable {
//
//    let response: Photos
//}
//struct Photos: Decodable {
//    let items: [AlbumPhoto]
//}
//
//struct AlbumPhoto: Decodable, Identifiable {
//
//    let id: Int
//    let sizes: [PhotoSize]
//
//    enum CodingKeys: String, CodingKey {
//        case id = "owner_id"
//    }
//
//}
//struct PhotoSize: Decodable {
//    let url: String
//    let type: String
//}

//
//"response": {
//"count": 239,
//"items": [{
//"album_id": -7,
//"date": 1525187973,
//"id": 456316241,
//"owner_id": 1,
//"has_tags": false,
//"sizes": [{
//"height": 97,
//"url": "https://sun5-4.us...LlMU&type=album",
//"type": "m",
//"width": 130
//},
