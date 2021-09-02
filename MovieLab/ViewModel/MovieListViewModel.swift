//
//  MovieListViewModel.swift
//  MovieLab
//
//  Created by King Bileygr on 9/1/21.
//

import Foundation

struct MovieListViewModel {

    var id: Int
    var movieTitle: String
    var backdropPath: String
    
    init(dataSource: Results) {
        self.id = dataSource.id
        self.movieTitle = dataSource.title
        self.backdropPath = dataSource.backdropPath
    }
}

struct MovieViewModel {
    var categoryName: String
    var results: [Results]
    
    init(name: String, data: [Results]) {
        self.categoryName = name
        self.results = data
    }
}

