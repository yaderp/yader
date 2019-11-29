//
//  ContentView.swift
//  MovieUI
//
//  Created by Carlos López Hurtado on 11/29/19.
//  Copyright © 2019 Andres Lopez. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
         TabView{
           SearchView().tabItem(){
               Image(systemName: "magnifyingglass")
               Text("Movies")
           }
           
           FavoriteView().tabItem(){
               Image(systemName: "star")
               Text("Favorites")
           }
        }
    }
}

