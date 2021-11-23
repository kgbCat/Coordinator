//
//  SubTitle.swift
//  Cell Prototype
//
//  Created by Anna Delova on 10/27/21.
//

import Foundation
import SwiftUI

struct SubTitle: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
    }
}

