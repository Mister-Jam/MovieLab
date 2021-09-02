//
//  MovieListMode.swift
//  MovieLab
//
//  Created by King Bileygr on 9/1/21.
//

import Foundation


struct MovieListModel: Decodable {
    var results: [Results]
}

struct Results: Decodable {
    var id: Int
    var title: String
    var backdropPath: String
}
