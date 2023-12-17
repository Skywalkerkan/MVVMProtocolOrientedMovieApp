//
//  MovieTrailer.swift
//  MVVMProtocolOriented
//
//  Created by Erkan on 18.09.2023.
//

import Foundation


struct MovieTrailer: Codable {
    let id: Int?
    let results: [TrailerInfo]?
}

// MARK: - Result
struct TrailerInfo: Codable {
    let iso639_1, iso3166_1, name, key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
