

import Foundation
import SwiftyJSON

struct VkItem: Identifiable, Hashable {

    var id: Int
    var text:String
    var attachments: [Attachments]
    var likes: VkPhotoLikes
    static func == (lhs: VkItem, rhs: VkItem) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
extension VkItem {
    init(_ json: JSON) {
        self.id = json["source_id"].intValue
        self.text = json["text"].stringValue
        self.attachments = [Attachments]()
        let attachmentsArray = json["attachments"].arrayValue
        for attachmentsJson in attachmentsArray{
            let value = Attachments(attachmentsJson)
                attachments.append(value)
            }
        self.likes = VkPhotoLikes(json["likes"])

    }
}

struct Attachments {
    var photo: VkPhoto

    init(_ json: JSON) {
        self.photo = VkPhoto(json["photo"])
    }

}


struct VkPhoto {
    var sizes: [Sizes]
    let owner_id: Int

    init(_ json: JSON) {
        self.sizes = [Sizes]()
        let sizesArray = json["sizes"].arrayValue
        for sizesJson in sizesArray{
            let value = Sizes(sizesJson)
                 sizes.append(value)
             }
        self.owner_id = json["owner_id"].intValue
    }
}
struct Sizes {
    let url: String?
    let type: String

    init(_ json: JSON) {
        self.url = json["url"].stringValue
        self.type =  json["type"].stringValue
    }
}

struct VkProfile: Identifiable, Hashable {

    let firstName: String
    let lastName: String
    let id: Int
    let photo100: String
    var fullName: String { "\(firstName) \(lastName)" }

    static func == (lhs: VkProfile, rhs: VkProfile) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
extension VkProfile {
    init(_ json: JSON) {
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.id = json["id"].intValue
        self.photo100 = json["photo_100"].stringValue
    }
}
