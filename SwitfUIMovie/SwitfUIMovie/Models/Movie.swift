//	Models
//  Movie.swift

import Foundation

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let overView: String
    let genders: [Int]
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case overView = "overview"
        case genders = "genre_ids"
        case poster = "poster_path"
    }
    
    var imageUrlString: String {
        return urlImage + poster
    }
}

struct MovieResponse: Decodable {
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
