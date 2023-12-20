//
//  postView.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 20/12/23.
//

import SwiftUI

struct postView: View {
    @Environment(PostsVM.self) var vm
    
    let post: Posts
    
    var body: some View {
        HStack{
            if let imagen = post.imagenPost{
                Image(uiImage: imagen)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 250)
                    .padding(2)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 250)
                    .padding(2)
            }
            VStack(alignment: .leading) {
                Text("Artículo:")
                    .foregroundStyle(.blue)
                Text(post.title)
                    .padding(.leading,20)
                Text("Autores:")
                    .foregroundStyle(.blue)
                ForEach(post.authors){ author in
                    Text("- " + author.name)
                        .padding(.leading,20)
                }
            }
        }
    }
}

#Preview {
    postView(post: .test)
        .environment(PostsVM())
}
