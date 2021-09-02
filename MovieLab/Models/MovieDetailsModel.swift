//
//  MovieDetailsModel.swift
//  MovieLab
//
//  Created by King Bileygr on 9/1/21.
//

import Foundation

struct MovieDetailsModel: Decodable {
    var budget: Int
    var genres: [Genre]
    var overview: String
    var popularity: Double
    var productionCompanies: [Companies]
    var releaseDate: String
    var revenue: Int
    var runtime: Int
    var status: String
    var tagline: String
    var voteAverage: Float
    var voteCount: Int
}

struct Genre: Decodable {
    var id: Int
    var name: String
}


struct Companies: Decodable {
    var name: String
    var logoPath: String?
}
