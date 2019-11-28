//	Views
//  ContentView.swift


import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            TabView{
                SearchView().tabItem{
                    Text("Search")
                    Image("ic_home")
                }
                FavoriteView().tabItem{
                    Text("Favorites")
                    Image("ic_favorite")
                }
                
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
