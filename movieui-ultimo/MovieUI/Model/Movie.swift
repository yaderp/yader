//
//  Movie.swift
//  MovieUI
//
//  Created by Carlos López Hurtado on 11/29/19.
//  Copyright © 2019 Andres Lopez. All rights reserved.
//

import Foundation

struct Movie: Decodable, Identifiable{
    
    let id: Int
    let title: String
    let overview: String
    let poster: String
    let genders: [Int]
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case title = "title"
        case overview = "overview"
        case poster = "poster_path"
        case genders = "genre_ids"
    
    }
    
    var imageUrlString: String{
        return urlImage + poster
    }
    
}

struct MovieResponse: Decodable{
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey{
        case movies = "results"
    }
}
