//
//  Ejercicio4View.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 20/12/23.
//

import SwiftUI

struct Ejercicio4View: View {
    @Environment(PostsVM.self) var vm
    var body: some View {
        VStack{
            if let imagen = vm.imagenAuthor {
                Image(uiImage: imagen)
            }
        }
        .onAppear(){
            vm.getPostsAndAuthors()
            if !vm.posts.isEmpty {
                vm.getImageAuthor(urlImagen: vm.posts[0].authors[0].avatar_urls)
            }
        }
    }
}

#Preview {
    Ejercicio4View()
        .environment(PostsVM())
}
