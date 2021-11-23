//
//  GalleryCollectionViewCellPrototype.swift
//  Cell Prototype
//
//  Created by Anna Delova on 10/31/21.
//

import SwiftUI

struct GalleryCollectionViewCellPrototype: View {

    @State private var isLiked = false
    @State private var count = 0


    var likesCount: Int
    var url: String
    @State var taps = 0

    var body: some View {
        VStack(alignment: .center) {
            Button(action: {
                withAnimation(Animation.easeInOut(duration: 1)) {
                    taps += 1
                }
            }, label: {
                KingfisferImageView(url: url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150, alignment: .center)
                    .cornerRadius(10)
                    .bounce(animCount: taps)

            })
            HStack {
                Text(String(likesCount + count))
                LIkeButton(isLiked: $isLiked, count: $count)
            }
        }
    }
}
extension View {
    func bounce(animCount: Int,
                amplitude: CGFloat = 10,
                bouncingTimes: Int = 3) -> some View {
        self.modifier(Bounce(animCount: animCount,
                             amplitude: amplitude,
                             bouncingTimes: bouncingTimes))
    }
}

struct GalleryCollectionViewCellPrototype_Previews: PreviewProvider {
    static var previews: some View {
        GalleryCollectionViewCellPrototype(likesCount: 0, url: "")

    }
}
