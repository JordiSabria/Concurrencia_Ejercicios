//
//  Presentation.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 18/12/23.
//

import Foundation

struct Posts:Codable, Identifiable {
    let id:Int
    let title:String
    let excerpt:String
    let authors:[URL]
    let wpfeaturedmedia:[URL]
}
struct Author:Codable, Identifiable {
    let id:Int
    let name:String
    let avatar_urls:URL
}
struct Media:Codable, Identifiable {
    let id:Int
    let guid:String
}
