//
//  VKLoginWebView.swift
//  SwiftUI-Course
//
//  Created by andrey.antropov on 14.10.2021.
//

import SwiftUI
import WebKit

struct VkLoginWebView: UIViewRepresentable {

    @ObservedObject var webViewModel: WebViewModel

    func makeCoordinator() -> VkLoginWebView.Coordinator {
        Coordinator(self, webViewModel)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator

        if webViewModel.isAuthorised == false {
            if let request = buildAuthRequest() {
                webView.load(request)
            }
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {

        if webViewModel.shouldGoBack == true {
            
        }

    }

    private func buildAuthRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7861791"),
            URLQueryItem(name: "scope", value: "336918"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.130")
        ]

        return components.url.map { URLRequest(url: $0) }
    }
}
extension VkLoginWebView {
    class Coordinator: NSObject, WKNavigationDelegate {

        @ObservedObject var webViewModel: WebViewModel

        private let parent: VkLoginWebView

        init(_ parent: VkLoginWebView, _ webViewModel: WebViewModel) {
            self.parent = parent
            self.webViewModel = webViewModel
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            guard let url = navigationResponse.response.url,
                  url.path == "/blank.html",
                  let fragment = url.fragment else {
                decisionHandler(.allow)
                return
            }

            let params = fragment
                .components(separatedBy: "&")
                .map { $0.components(separatedBy: "=") }
                .reduce([String: String]()) { result, param in
                    var dict = result
                    let key = param[0]
                    let value = param[1]
                    dict[key] = value

                    return dict
                }

            guard let token = params["access_token"],
                  let userIdString = params["user_id"],
                  let userId = Int(userIdString)
            else {
                decisionHandler(.allow)
                return
            }
            updateLoginStatus()
            
            Session.instance.token = token
            Session.instance.userId = userId

            decisionHandler(.cancel)
        }

        func updateLoginStatus(){
            webViewModel.isAuthorised = true
        }
    }


}
