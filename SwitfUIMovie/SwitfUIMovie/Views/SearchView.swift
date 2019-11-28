//	Views
//  SearchView.swift


import SwiftUI

struct SearchView: View {
    @ObservedObject var movieListVM = MovieListViewModel()
    
    var body: some View {
        List{
            ForEach(self.movieListVM.movies) {movie in
                MovieRowView(movie: movie)
            }
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
