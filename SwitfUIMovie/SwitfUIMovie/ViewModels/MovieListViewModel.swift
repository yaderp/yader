//	ViewModels
//  MovieListViewModel.swift


import SwiftUI

class MovieListViewModel: ObservableObject {
    @Published var movies = [Movie]()
    
    init(){
        
        session.dataTask(with: url) {
            data, response, error in
            
            DispatchQueue.main.async {
                let movieReponse = try! JSONDecoder().decode(MovieResponse.self, from: data!)
                
                self.movies = movieReponse.movies
            }
        }.resume()
    }
}
