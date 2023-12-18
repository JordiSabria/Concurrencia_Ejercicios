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
    
    var errorMsg = ""
    var showAlert = false
    
    init(interactor: DataInteractor = Network.shared) {
        self.interactor = interactor
        Task{
            await getDataPosts()
        }
    }
    
    func getDataPosts() async {
        do{
            let results = try await interactor.getPosts()
            await MainActor.run{
                self.posts = results
            }
        }catch {
            await MainActor.run {
                self.errorMsg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    func getNamePostAndAuthors(post: Posts) async -> (title:String, authors: [Author]){
        //var data:(title:String, authors: [Author])
        var authors: [Author] = []
        var title: String = ""
        
        do{
            for i in 1...post._links.author.count{
                let url = post._links.author[i].href
                let author = try await interactor.getAuthor(urlAuthor: url)
                authors.append(author)
            }
        }catch{
            
        }
        
        
    }
}
