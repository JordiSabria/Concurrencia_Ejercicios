//
//  Ejercicio5View.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 20/12/23.
//

import SwiftUI

struct Ejercicio5View: View {
    @Environment(PostsVM.self) var vm
    
    var body: some View {
        ScrollView {
            VStack{
                if !vm.posts.isEmpty{
                    if let imagen = vm.posts[0].imagenPost{
                        Image(uiImage: imagen)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 250)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 250)
                    }
                    VStack(alignment: .leading) {
                        Text("Artículo:")
                            .foregroundStyle(.blue)
                        Text(vm.posts[0].title + "\n")
                            .padding(.leading)
                        Text("Extracto")
                            .foregroundStyle(.blue)
                        Text(vm.posts[0].excerpt)
                            .padding(.leading)
                        Text("Autor:")
                            .foregroundStyle(.blue)
                        if !vm.posts[0].authors.isEmpty{
                            Text(vm.posts[0].authors[0].name)
                                .padding(.leading)
                            if let imagenAuthor = vm.imagenAuthor {
                                Image(uiImage: imagenAuthor)
                            }
                        }
                        
                    }
                    .padding()
                    
                }
            }
            .onAppear(){
                vm.setPostImage(int: 0)
                if !vm.posts.isEmpty {
                    vm.getImageAuthor(urlImagen: vm.posts[0].authors[0].avatar_urls)
                }
            }
        }
    }
}

#Preview {
    Ejercicio5View()
        .environment(PostsVM())
}
