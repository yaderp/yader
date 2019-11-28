//	Views
//  FavoriteView.swift

import SwiftUI

struct FavoriteView: View {
    
    @EnvironmentObject var favoriteVM: FavoriteViewModel

    var body: some View {
        List{
            ForEach(self.favoriteVM.favorites, id: \.self) { favorite in
                FavoriteRowView(favorite: favorite)
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
