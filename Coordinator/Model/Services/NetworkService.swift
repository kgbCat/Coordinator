//
//  NetworkService.swift
//  SwiftUI TEST
//
//  Created by Anna Delova on 11/9/21.
//

import Foundation
import SwiftyJSON

protocol VkNetworkRequestsInterface {

    func getFriends(completion: @escaping ([Friend]) -> Void)
    func getGroups(completion: @escaping ([MyVkGroup]) -> Void)
//    func searchGroups(search q: String, completion: @escaping ([SearchAllGroups]?) -> Void)
//    func getPhotos(userID:Int, completion: @escaping ([VkPhoto]?) -> Void)
    func getNews(completion: @escaping ([VkItem]?,[VkProfile]?) -> Void)
}
struct NetworkPaths {
    static let getFriends = "friends.get"
    static let getAllPhotos = "photos.getAll"
    static let getGroups = "groups.get"
    static let searchGroups = "groups.search"
    static let getNews = "newsfeed.get"
}

class NetworkService: VkNetworkRequestsInterface  {

   private var urlComponents: URLComponents = {
        var url = URLComponents()
        url.scheme = "https"
        url.host = "api.vk.com"
        url.queryItems = [
            URLQueryItem(name: "access_token", value: Session.instance.token),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "user_id", value: String(Session.instance.userId))
        ]
        return url
    }()


    func getGroups(completion: @escaping ([MyVkGroup]) -> Void) {
        urlComponents.path = "/method/\(NetworkPaths.getGroups)"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "extended", value: "1"),
                ])

        guard let url = urlComponents.url else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(GroupResponse.self, from: data)
                for group in result.response.items {
                    print(group.name)
                }
                DispatchQueue.main.async {
                    completion(result.response.items)
                }

            } catch {
                print(error)
            }
        } .resume()

    }

    func getFriends(completion: @escaping ([Friend]) -> Void) {
        urlComponents.path = "/method/\(NetworkPaths.getFriends)"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "offset", value: "5"),
            URLQueryItem(name: "fields", value: "photo_200_orig"),
                ])
        guard let url = urlComponents.url else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    completion(result.response.items)
                }

            } catch {
                print(error)
            }
        } .resume()
    }

    func getPhotos(userID:Int, completion: @escaping ([AlbumPhoto]?) -> Void) {
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "owner_id", value: "\(userID)"),
                ])
        guard let url = urlComponents.url else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            do {
                let json = try JSON(data)
                let itemsJson = json["response"]["items"].arrayValue
                let photos = itemsJson.compactMap{ AlbumPhoto($0) }

                DispatchQueue.main.async {
                    completion(photos)
                }
            } catch {
                print(error.localizedDescription)
            }
        } .resume()
    }

    func getNews(completion: @escaping ([VkItem]?, [VkProfile]?) -> Void) {
        urlComponents.path = "/method/\(NetworkPaths.getNews)"
        urlComponents.queryItems?.append(contentsOf: [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "50"),
        ])

        guard let url = urlComponents.url else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            do {
                let json = try JSON(data)
                let itemsJson = json["response"]["items"].arrayValue
                let vkItems = itemsJson.compactMap{ VkItem($0) }
                let profileJson = json["response"]["profiles"].arrayValue
                let vkProfiles = profileJson.compactMap{ VkProfile($0) }
                
                DispatchQueue.main.async {
                    completion(vkItems, vkProfiles)
                }
            } catch {
                print(error.localizedDescription)
            }
        } .resume()
    }
    
}









