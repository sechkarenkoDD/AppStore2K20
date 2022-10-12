//
//  SearchResult.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 04.07.2022.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    var results: [AppResult]
}

struct AppResult: Decodable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String // app icon
    var formattedPrice: String?
    let description: String
    var releaseNotes: String?
    let version: String
}
