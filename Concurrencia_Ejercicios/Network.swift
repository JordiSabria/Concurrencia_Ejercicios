//
//  Network.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 16/12/23.
//

import SwiftUI

protocol DataInteractor {
    func getPosts() async throws -> [Posts]
    func getAuthor(urlAuthor: URL) async throws -> Author
    func getMedia(urlMedia: URL) async throws -> Media
    func getImage(url: URL) async throws -> UIImage?
    func getImagePost(postId: Int, url: URL) async throws -> (Int,UIImage?)
}

struct Network: DataInteractor{
    
    static let shared = Network()
    
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
        let (data, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(type, from: data)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func postJSON(request: URLRequest, status: Int = 200) async throws {
        let (_, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode != status {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func getPosts() async throws -> [Posts] {
        try await getJSON(request: .get(url: urlPosts), type: [DTOPosts].self).map(\.toPresentation) 
    }
    
    func getAuthor(urlAuthor: URL) async throws -> Author {
        try await getJSON(request: .get(url: urlAuthor), type: DTOAuthor.self).toPresentation
    }
    
    func getMedia(urlMedia: URL) async throws -> Media {
        try await getJSON(request: .get(url: urlMedia), type: DTOMedia.self).toPresentation
    }
    func getImage(url: URL) async throws -> UIImage? {
        let (data, _) = try await URLSession.shared.getData(from: url)
        if let image = UIImage(data: data){
            return image
        } else {
            return nil
        }
    }
    func getImagePost(postId: Int, url: URL) async throws -> (Int,UIImage?) {
        let (data, _) = try await URLSession.shared.getData(from: url)
        if let image = UIImage(data: data){
            return (postId,image)
        } else {
            return (0,nil)
        }
    }
}
