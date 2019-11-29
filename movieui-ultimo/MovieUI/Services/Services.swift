//
//  Services.swift
//  MovieUI
//
//  Created by Carlos López Hurtado on 11/29/19.
//  Copyright © 2019 Andres Lopez. All rights reserved.
//

import Foundation


let urlString = "https://api.themoviedb.org/3/search/movie?api_key=3cae426b920b29ed2fb1c0749f258325&query="

let url = URL(string: urlString)!
let urlImage = "https://image.tmdb.org/t/p/w500/"

let session = URLSession.shared
