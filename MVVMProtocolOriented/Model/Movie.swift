//
//  TrendingMoviesModel.swift
//  TMDBApp
//
//  Created by Erkan on 27.03.2023.
//

import Foundation

struct Movie: Codable {
    let page: Int?
    let results: [Result]?
    let totalPages, totalResults: Int?
    let dates: Dates?
    
    enum CodingKeys: String, CodingKey{
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case dates
    }
}


struct Dates: Codable {
    let maximum, minimum: String?
}


// MARK: - Result
struct Result: Codable {
    let adult: Bool?
    let name: String?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int?
    let first_air_date: String?
    
    
    var posterImage: String{
        "https://image.tmdb.org/t/p/original/\(posterPath ?? "")"
    }
    
    var posterImageımsı: String{
        "https://image.tmdb.org/t/p/original/\(backdropPath ?? "")"
    }
    
    
    enum CodingKeys: String, CodingKey {
        case first_air_date
        case adult
        case backdropPath = "backdrop_path"
        case name
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
