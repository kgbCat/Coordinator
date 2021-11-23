//
//  NewsCellPrototype.swift
//  Cell Prototype
//
//  Created by Anna Delova on 10/31/21.
//

import SwiftUI

struct ItemCellPrototype: View {

    var item: VkItem

    @State private var isLiked = false
    @State private var count = 0

    var body: some View {

        VStack {
            KingfisferImageView(url: item.attachments.first?.photo.sizes.first(where: {
                "x".contains($0.type)})?.url ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300)
            Text(item.text)
                .modifier(SubTitle(color: .black))
            Spacer()
            HStack {
                Text(String(item.likes.count + count))
                LIkeButton(isLiked: $isLiked, count: $count)
            }
        }
    }
}
struct ProfileCellPrototype: View {

    var profile: VkProfile

    var body: some View {

        VStack {
            HStack {
                KingfisferImageView(url: profile.photo100)
                    .resizable()
                    .modifier(Photo())
                Text(profile.fullName)
                    .profifeStyle()
            }
            .background(Color(.clear))
            .cornerRadius(30)
        }

    }
}
extension View {
    func profifeStyle() -> some View {
        modifier(Title(color: Color(.systemRed )))
    }
}
