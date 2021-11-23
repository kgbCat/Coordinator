//
//  GalleryView.swift
//  Cell Prototype
//
//  Created by Anna Delova on 10/31/21.
//

import SwiftUI
import QGrid

struct GalleryView: View {

    @State var photos: [AlbumPhoto] = []
    let userId:Int
    var sorted: [String] = []


    var body: some View {
        NavigationView {

            QGrid(photos, columns: 2) { photo in
                
                GalleryCollectionViewCellPrototype(likesCount: photo.likes.count, url: photo.sizes.first(where: { ("x").contains($0.type) })?.url ?? "")
            }
            .onAppear {
                NetworkService().getPhotos(userID: userId, completion: { (photos) in
                    guard let photos = photos else { return }
                    self.photos = photos
                })
            }
        }
        .navigationBarTitle("Photo Gallery", displayMode: .inline)
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(userId: 0)
    }
}
