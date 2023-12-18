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
            authors: _links.author.map(\.href),
            wpfeaturedmedia: _links.wpfeaturedmedia.map(\.href))
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
// haig de fer el extension to presentation
struct DTOMedia:Codable, Identifiable {
    let id:Int
    struct Rendered:Codable {
        let rendered:String
    }
    let guid:Rendered
}
// haig de fer el extension to presentation
