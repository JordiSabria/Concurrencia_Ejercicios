//
//  Concurrencia_EjerciciosApp.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 15/12/23.
//

import SwiftUI

@main
struct Concurrencia_EjerciciosApp: App {
    @State var vm: PostsVM = PostsVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .alert("App Alert",
                       isPresented: $vm.showAlert) {
                } message: {
                    Text(vm.errorMsg)
                }
        }
    }
}
