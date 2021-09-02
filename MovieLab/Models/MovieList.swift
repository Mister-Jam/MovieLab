//
//  MovieList.swift
//  MovieLab
//
//  Created by King Bileygr on 9/1/21.
//

import Foundation
import RealmSwift

class MovieList: Object {
    @Persisted(primaryKey: true) var id = ""
    @Persisted var categoryName = ""
    @Persisted var results: List<MovieListItems>
}

class MovieListItems: Object {
    @Persisted var id = 0
    @Persisted var title = ""
    @Persisted var backdropPath = ""
}
