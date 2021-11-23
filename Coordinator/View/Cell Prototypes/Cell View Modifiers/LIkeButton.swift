//
//  LIkeButton.swift
//  SwiftUI TEST
//
//  Created by Anna Delova on 11/17/21.
//

import SwiftUI

struct LIkeButton: View {
    @Binding var isLiked: Bool
    @Binding var count: Int

    private let animationDuration: Double = 0.1
    private var animationScale: CGFloat {
        isLiked ? 0.7 : 1.3
    }
    @State private var animate = false

    var body: some View {

        Button(action: {
            self.animate = true

            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration, execute: {
                self.animate = false
                self.isLiked.toggle()
                if count == 0 {
                    count = 1
                } else {
                    count = 0
                }

            })

        }, label: {
            Image(systemName: isLiked ? "heart.fill" : "heart" )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
                .foregroundColor(isLiked ? .red : .gray)
        })
        .scaleEffect(animate ? animationScale : 1)
        .animation(.easeIn(duration: animationDuration))
    }
}
