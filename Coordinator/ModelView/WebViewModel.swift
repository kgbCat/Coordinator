//
//  WebViewModel.swift
//  SwiftUI TEST
//
//  Created by Anna Delova on 11/6/21.
//

import SwiftUI

class WebViewModel: ObservableObject {
    @Published var isAuthorised: Bool = false
    @Published var shouldGoBack: Bool = false

}
