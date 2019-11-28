//	Views
//  FavoriteRowView.swift


import SwiftUI

struct FavoriteRowView: View {
    
    var favorite: Favorite?
    
    var body: some View {
        VStack{
            Text(favorite!.title!)

        }

    }
}

struct FavoriteRowView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteRowView()
    }
}
