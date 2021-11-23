//
//  Kingfisher.swift
//  SwiftUI TEST
//
//  Created by Anna Delova on 11/9/21.
//

import SwiftUI
import struct Kingfisher.KFImage

@ViewBuilder
func KingfisferImageView(url: String) -> KFImage {
    KFImage(
        URL(string: url))

}

