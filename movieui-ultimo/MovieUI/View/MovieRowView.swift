//
//  MovieRowView.swift
//  MovieUI
//
//  Created by Carlos López Hurtado on 11/29/19.
//  Copyright © 2019 Andres Lopez. All rights reserved.
//

import SwiftUI

struct MovieRowView: View {
    @EnvironmentObject var favoriteVM: FavoriteViewModel
    
    var movie: Movie?
    
    var body: some View {
        
        HStack{
            ImageView(withURL: self.movie!.imageUrlString)

                VStack(alignment: .leading){
                    Text(movie!.title).bold()
                    Spacer()
                    Text(movie!.overview).lineLimit(2)

                }
                Spacer()
                Button(action:{
                    self.favoriteVM.addFavorite(title: self.movie!.title, id: self.movie!.id)
                    self.favoriteVM.getAllFavorites()
                }){
                    Image(systemName: "plus")
                }
            }.buttonStyle(BorderlessButtonStyle())
    }
}

struct MovieRowView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowView()
    }
}
