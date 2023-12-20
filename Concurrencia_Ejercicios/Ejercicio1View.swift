//
//  Ejercicio1View.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 19/12/23.
//

import SwiftUI

struct Ejercicio1View: View {
    @Environment(PostsVM.self) var vm
    
    var body: some View {
        List {
            ForEach(vm.posts){post in
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
        .onAppear(){
            vm.getPostsAndAuthors()
        }
    }
}

#Preview {
    Ejercicio1View()
        .environment(PostsVM())
}
