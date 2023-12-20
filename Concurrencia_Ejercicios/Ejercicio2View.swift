//
//  Ejercicio2View.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 19/12/23.
//

import SwiftUI

struct Ejercicio2View: View {
    @Environment(PostsVM.self) var vm
    
    var body: some View {
        VStack{
            if !vm.posts.isEmpty{
                VStack(alignment: .leading) {
                    Text("Artículo:")
                        .foregroundStyle(.blue)
                    Text(vm.posts[0].title)
                }
                .padding(20)
                if let imagen = vm.posts[0].imagenPost{
                    Image(uiImage: imagen)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 450)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 450)
                }
            }
        }
        .onAppear(){
            vm.setPostImage(int: 0)
        }
    }
}

#Preview {
    Ejercicio2View()
        .environment(PostsVM())
    
}
