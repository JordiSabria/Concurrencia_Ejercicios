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
        TabView {
            Group{
                Ejercicio1View()
                    .environment(vm)
                    .tabItem {
                        Label("Ejercicio1", systemImage: "list.bullet")
                    }
                Ejercicio2View()
                    .environment(vm)
                    .tabItem {
                        Label("Ejercicio2", systemImage: "list.bullet")
                    }
                Ejercicio3View()
                    .environment(vm)
                    .tabItem {
                        Label("Ejercicio3", systemImage: "list.bullet")
                    }
                Ejercicio4View()
                    .environment(vm)
                    .tabItem {
                        Label("Ejercicio4", systemImage: "list.bullet")
                    }
                Ejercicio5View()
                    .environment(vm)
                    .tabItem {
                        Label("Ejercicio5", systemImage: "list.bullet")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(PostsVM())
}

