//	ViewModels
//  FavoriteViewModel.swift

import SwiftUI

class FavoriteViewModel: ObservableObject{
    @Published var favorites = [Favorite]()
    
    func saveContext(){
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    func addFavorite(title:String) {
        let favorite = Favorite(context: context)
        favorite.title = title
        favorite.date = Date()
        saveContext()
        
        
    }
    
    func getAllFavorites(){
        do {
            self.favorites = try context.fetch(Favorite.fetchRequest())
        } catch (let error){
            print(error)
        }
    }
    
    func deleteFavorite(position: Int){
        let favorite = favorites[position]
        
        context.delete(favorite)
        saveContext()
    }
    
    init (){
        getAllFavorites()
        
    }
}
