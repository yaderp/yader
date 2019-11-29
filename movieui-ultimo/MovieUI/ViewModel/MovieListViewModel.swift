//
//  MovieListViewModel.swift
//  MovieUI
//
//  Created by Carlos López Hurtado on 11/29/19.
//  Copyright © 2019 Andres Lopez. All rights reserved.
//

import SwiftUI
import Foundation

class MovieListViewModel: ObservableObject{
    
    @Published var movies = [Movie]()
    
    func createURL(query: String) -> URL{
        
        var urlComponent = URLComponents()
        let apiKey = URLQueryItem(name: "api_key", value: "3cae426b920b29ed2fb1c0749f258325")
        let queryItem = URLQueryItem(name: "query", value: query)
        
        urlComponent.scheme = "https"
        urlComponent.host = "api.themoviedb.org"
        urlComponent.path = "/3/search/movie"
        urlComponent.queryItems = [apiKey,queryItem]
        //urlComponent.percentEncodedQuery = urlComponent.percentEncodedQuery?.replacingOccurrences(of: "%20", with: "+")
        return urlComponent.url!
    }
    
    func getMovies(query: String = "frozen"){
        
        session.dataTask(with: createURL(query: query)){ data, response, error in
            
            DispatchQueue.main.async {
                
                do {
                     let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data!)
                     self.movies = movieResponse.movies
                } catch (let error){
                    print(error)
                }
                
            }
            
            
        }.resume()
        
    }
    
    init(){
        getMovies()
    }
    
}
