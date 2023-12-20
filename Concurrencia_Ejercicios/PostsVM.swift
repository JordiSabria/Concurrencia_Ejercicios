//
//  PostsVM.swift
//  Concurrencia_Ejercicios
//
//  Created by Jordi Sabrià Pagès on 16/12/23.
//

import SwiftUI

@Observable
final class PostsVM {
    let interactor: DataInteractor
    var posts: [Posts] = []
    var arrayPostImagenes: [(Int,UIImage?)] = [] // Para ejercicio3
    var imagenAuthor: UIImage? = nil // Para ejercicio4
    
    var errorMsg = ""
    var showAlert = false
    
    init(interactor: DataInteractor = Network.shared) {
        self.interactor = interactor
    }
    // Ejercicio1
    func getPostsAndAuthors(){
        Task{
            do{
                // Primero recuperamos los posts
                try await getDataPosts()
                // Luego recuperamos los autores de cada posts
                try await getAuthors()
            }catch{
                await MainActor.run {
                    self.errorMsg = "\(error)"
                    self.showAlert.toggle()
                }
            }
        }
    }
    // Ejercicio2
    func setPostImage(int: Int){        
        Task{
            do{
                // Primero recuperamos los posts
                try await getDataPosts()
                // Luego recuperamos los autores de cada posts
                try await getAuthors()
                // Luego recuperamos los Medios
                try await getMedia()
                // Finalment la imagen
                if !posts.isEmpty{
                    let image = try await interactor.getImage(url: posts[int].wpfeaturedmedia[0].guid)
                    await MainActor.run{
                        posts[int].imagenPost = image
                    }
                }
            }catch{
                await MainActor.run {
                    self.errorMsg = "\(error)"
                    self.showAlert.toggle()
                }
            }
        }
    }
    // Ejercicio3
    func getAllPostsImages(){
        // Hemos de recuperar todas las imagenes de todos los posts de forma asincrona y concurrente y guardarlas en una array.
        // Para ello vamos a englobar todas las llamadas en un Task Group.
        // Para rizar el rizo vamos a guardar cada imagen en su post.
        
        // primero vaciamos la array de imagenes
        arrayPostImagenes = []
        Task{
            do{
                // Primero recuperamos los posts
                try await getDataPosts()
                // Luego recuperamos los autores de cada posts
                try await getAuthors()
                // Luego recuperamos los Medios
                try await getMedia()
                // Finalment las imagenes
                try await withThrowingTaskGroup(of: (Int,UIImage?).self){ group in
                    // Recorremos todos los posts
                    for postNum in 0...posts.count-1 {
                        group.addTask{
                            try await self.interactor.getImagePost(postId: self.posts[postNum].id, url: self.posts[postNum].wpfeaturedmedia[0].guid)
                        }
                    }
                    for try await imageTuplaRecovered in group.compactMap({$0}){
                        self.arrayPostImagenes.append(imageTuplaRecovered)
                    }
                }
                await MainActor.run{
                    for postImage in arrayPostImagenes{
                        if let index = posts.firstIndex(where: { $0.id == postImage.0 }) {
                            posts[index].imagenPost = postImage.1
                        }
                    }
                }
            }catch{
                await MainActor.run {
                    self.errorMsg = "\(error)"
                    self.showAlert.toggle()
                }
            }
        }
    }
    // Ejercicio4
    func getImageAuthor(urlImagen: URL){
        imagenAuthor = nil
        Task{
            let imagen = try await interactor.getImage(url: urlImagen)
            await MainActor.run{
                self.imagenAuthor = imagen
            }
        }
    }
    func getDataPosts() async throws{
        // Hacemos una llamada asyncrona para recureprar todos los pots
        let results = try await interactor.getPosts()
        await MainActor.run{
            self.posts = results
        }
    }
    func getAuthors() async throws{
        // Para recuperar los Authors al tener que hacer varias llamadas una para cada Author, englobamos en un Task Group.
        
        // Recorremos todos los posts
        for postNum in 0...posts.count-1 {
            try await withThrowingTaskGroup(of: Author?.self){ group in
                // Recorremos la array de URL de authores.
                for authorURL in posts[postNum].authorsURL{
                    group.addTask{
                        try await self.interactor.getAuthor(urlAuthor: authorURL)
                    }
                }
                for try await authorRecovered in group.compactMap({ $0 }){
                    posts[postNum].authors.append(authorRecovered)
                }
            }
        }
    }
    func getMedia() async throws{
        // Como hemos visto que aunque es un array siempre hay solo un "media", recuperamos solo uno.
        
        // Recorremos todos los posts
        for postNum in 0...posts.count-1 {
            let result = try await interactor.getMedia(urlMedia: posts[postNum].wpfeaturedmediaURL[0])
            posts[postNum].wpfeaturedmedia.append(result)
        }
        
    }
    
}
