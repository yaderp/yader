//
//  SearchView.swift
//  MovieUI
//
//  Created by Carlos López Hurtado on 11/29/19.
//  Copyright © 2019 Andres Lopez. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct SearchView: View {
    
    @ObservedObject var movieListVM = MovieListViewModel()
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    HStack{
                        Image(systemName: "magnifyingglass")

                        TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            self.movieListVM.getMovies(query: self.searchText)
                        }).foregroundColor(.primary)
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                                UIApplication.shared.endEditing(true)
                                self.searchText = ""
                                self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton)
                List{
                    ForEach(self.movieListVM.movies){movie in
                        MovieRowView(movie: movie)
                    }
                    
                    
                }
                
            }.navigationBarTitle("Lista de Películas")
            
            
            
        }
    }
}


