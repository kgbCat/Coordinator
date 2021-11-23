//
//  UserCellPrototype.swift
//  Cell Prototype
//
//  Created by Anna Delova on 10/27/21.
//

import SwiftUI

struct UserCellPrototype: View {

    var friend: Friend

    var body: some View {

        HStack {
            KingfisferImageView(url: friend.photo_200_orig)
                .resizable()
                .photoStyle()

            VStack(alignment: .leading) {
                Text(friend.fullName)
                    .titleStyle()
                Text(friend.first_name)
                    .subtitleStyle()
            }
            Spacer()
            goToGalleryViewButton()

                
        }
    }
}

struct UserCellPrototype_Previews: PreviewProvider {
    static var previews: some View {
        UserCellPrototype(friend: Friend(id: 0, first_name: "", last_name: "", photo_200_orig: ""))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title(color: Color(.systemGreen)))
    }
}
extension View {
    func subtitleStyle() -> some View {
        modifier(SubTitle(color: Color(.systemGray)))
    }
}
extension View {
    func photoStyle() -> some View {
        modifier(Photo())
    }
}
extension View {
    func cellStyle() -> some View {
        modifier(Cell())
    }
}



struct goToGalleryViewButton: View {
    var body: some View {
        Image(systemName: "square.grid.3x3")
            .resizable()
            .frame(width: 30, height: 30, alignment: .center)
            .padding(.trailing, 10)
            .padding(.leading, 5)
            .foregroundColor(Color(#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)))
    }
}
