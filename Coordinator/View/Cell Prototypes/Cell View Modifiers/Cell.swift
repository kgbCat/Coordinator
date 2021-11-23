//
//  Cell.swift
//  Cell Prototype
//
//  Created by Anna Delova on 10/27/21.
//

import Foundation
import SwiftUI

struct Cell: ViewModifier {
    func body(content:Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 80, alignment: .leading)
            .background(Color(.systemGray6))
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .padding(.leading)
//            .padding(.trailing)

    }
}
