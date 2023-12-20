//
//  Model.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 16/12/23.
//

import Foundation

struct DTOPosts:Codable, Identifiable {
    let id:Int
    struct Rendered:Codable {
        let rendered:String
    }
    let title:Rendered
    let excerpt:Rendered
    struct Author:Codable {
        struct HREF:Codable {
            let href:URL
        }
        let author:[HREF]
        let wpfeaturedmedia:[HREF]
        enum CodingKeys:String, CodingKey {
            case author
            case wpfeaturedmedia = "wp:featuredmedia"
        }
    }
    let _links:Author
}
extension DTOPosts{
    var toPresentation: Posts{
        Posts(
            id: id,
            title: title.rendered,
            excerpt: excerpt.rendered,
            authorsURL: _links.author.map(\.href),
            authors: [],
            wpfeaturedmediaURL: _links.wpfeaturedmedia.map(\.href),
            wpfeaturedmedia: [],
            imagenPost: nil)
    }
}
struct DTOAuthor:Codable, Identifiable {
    let id:Int
    let name:String
    struct AvatarURLS:Codable {
        let _96:URL
        enum CodingKeys:String, CodingKey {
            case _96 = "96"
        }
    }
    let avatar_urls:AvatarURLS
}
extension DTOAuthor{
    var toPresentation: Author{
        Author(id: id, name: name, avatar_urls: avatar_urls._96)
    }
}
struct DTOMedia:Codable, Identifiable {
    let id:Int
    struct Rendered:Codable {
        let rendered:URL
    }
    let guid:Rendered
}
extension DTOMedia{
    var toPresentation: Media{
        Media(id: id, guid: guid.rendered)
    }
}
