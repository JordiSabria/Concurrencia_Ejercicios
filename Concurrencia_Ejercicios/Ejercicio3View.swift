//
//  Ejercicio3View.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 20/12/23.
//

import SwiftUI

struct Ejercicio3View: View {
    @Environment(PostsVM.self) var vm
    var body: some View {
        List{
            ForEach(vm.posts){ post in
                postView(post: post)
                    .environment(vm)
            }
        }
        .onAppear(){
            vm.getAllPostsImages()
        }
    }
}

#Preview {
    Ejercicio3View()
        .environment(PostsVM())
}
