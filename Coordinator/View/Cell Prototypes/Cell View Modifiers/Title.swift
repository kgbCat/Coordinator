//  Title.swift
//  Cell Prototype
//
//  Created by Anna Delova on 10/27/21.
//

import Foundation
import SwiftUI

struct Title: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(color)
            .multilineTextAlignment(.leading)
    }
}
