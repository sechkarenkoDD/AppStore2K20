//
//  SearchResult.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 04.07.2022.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    var results: [ResultApp]
}

struct ResultApp: Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String // app icon
}
