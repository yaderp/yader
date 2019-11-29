//
//  FavoriteView.swift
//  MovieUI
//
//  Created by Carlos López Hurtado on 11/29/19.
//  Copyright © 2019 Andres Lopez. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var favoriteVM: FavoriteViewModel
    
    var body: some View {
        
        NavigationView{
            List{
                ForEach(self.favoriteVM.favorites,id: \.self){
                    favorite in
                    Text(favorite.title!)
                }.onDelete(perform: removeMovie)
            }.navigationBarTitle("Lista de Favoritos")
        }
        
    }
    
    
    func removeMovie(at offsets: IndexSet) {
        for index in offsets {
            favoriteVM.deleteFavorite(position: index)
        }
    }
    
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
