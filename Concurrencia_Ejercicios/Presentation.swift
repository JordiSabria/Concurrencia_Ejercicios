//
//  Presentation.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 18/12/23.
//

import SwiftUI

struct Posts: Identifiable {
    let id:Int
    let title:String
    let excerpt:String
    let authorsURL:[URL]
    var authors:[Author]
    let wpfeaturedmediaURL:[URL]
    var wpfeaturedmedia:[Media]
    var imagenPost: UIImage?
}
struct Author:Codable, Identifiable {
    let id:Int
    let name:String
    let avatar_urls:URL
}
struct Media:Codable, Identifiable {
    let id:Int
    let guid:URL
}
