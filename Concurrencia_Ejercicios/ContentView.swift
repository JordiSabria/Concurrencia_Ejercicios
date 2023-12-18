//
//  ContentView.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 15/12/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(PostsVM.self) var vm
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(vm.posts){post in
                Text("- " + post.title.rendered)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(PostsVM())
}
