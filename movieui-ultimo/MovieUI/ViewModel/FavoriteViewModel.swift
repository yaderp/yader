//
//  FavoriteViewModel.swift
//  MovieUI
//
//  Created by Carlos López Hurtado on 11/29/19.
//  Copyright © 2019 Andres Lopez. All rights reserved.
//

import SwiftUI


class FavoriteViewModel: ObservableObject{
    
    @Published var favorites = [Favorite]()
    
    func saveContext(){
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addFavorite(title: String, id: Int){
        
        let favorite = Favorite(context: context)
        favorite.title = title
        favorite.id = Int32(id)
        favorite.date = Date()
        saveContext()
    }
    
    func getAllFavorites(){
        
        do{
            self.favorites = try context.fetch(Favorite.fetchRequest())
        }catch(let error){
            print(error)
        }
    }
    
    func deleteFavorite(position: Int){
        
        let favorite = favorites[position]
        favorites.remove(at: position)
        context.delete(favorite)
        saveContext()
    }
    
    init() {
        getAllFavorites()
    }
    
    
}
