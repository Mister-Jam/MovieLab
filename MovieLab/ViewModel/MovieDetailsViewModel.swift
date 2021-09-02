//
//  MovieDetailsViewModel.swift
//  MovieLab
//
//  Created by King Bileygr on 9/1/21.
//

import Foundation

struct MovieDetailsViewModel {
    var synopsis: String
    var tagline: String
    var poularityScore: Double
    var releaseStatus: String
    var releaseDate: String
    var runtime: Int
    var revenue: Int
    var voteAverage: Float
    var voteCount: Int
    var genres: [Genre]
    var companies: [Companies]
    
    init(dataSource: MovieDetailsModel) {
        self.synopsis = dataSource.overview
        self.tagline = dataSource.tagline
        self.poularityScore = dataSource.popularity
        self.releaseStatus = dataSource.status
        self.releaseDate = dataSource.releaseDate
        self.runtime = dataSource.runtime
        self.revenue = dataSource.revenue
        self.voteAverage = dataSource.voteAverage
        self.voteCount = dataSource.voteCount
        self.genres = dataSource.genres
        self.companies = dataSource.productionCompanies
    }
}

struct DetailsViewModel {
    var releaseDate: String
    var releaseStatus: String
    var runtime: Int
    var revenue: Int
    
    init(dataSource: MovieDetailsViewModel) {
        self.releaseDate = dataSource.releaseDate
        self.releaseStatus = dataSource.releaseStatus
        self.runtime = dataSource.runtime
        self.revenue = dataSource.revenue
    }
}

struct SummaryViewModel {
    var overview: String
    var ratings: Float
    var genre: [Genre]
    
    init(dataSource: MovieDetailsViewModel) {
        self.overview = dataSource.synopsis
        self.ratings = dataSource.voteAverage
        self.genre = dataSource.genres
    }
}
