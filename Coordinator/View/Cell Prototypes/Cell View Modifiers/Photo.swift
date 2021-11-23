//
//  Photo.swift
//  Cell Prototype
//
//  Created by Anna Delova on 10/27/21.
//

import Foundation
import SwiftUI

struct Photo: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 60.0, height: 60.0)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .aspectRatio(contentMode: .fit)
            .padding()
    }
}
