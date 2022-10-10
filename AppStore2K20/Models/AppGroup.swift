//
//  AppGroup.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 14.06.2022.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let id, name, artistName, artworkUrl100: String
}
