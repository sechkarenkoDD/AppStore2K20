//
//  Reviews.swift
//  AppStore2K20
//
//  Created by Дмитрий Сечкаренко on 10.10.2022.
//

import Foundation

struct Reviews: Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let author: Author
    let title: LabelString
    let content: LabelString
    let rating: LabelString
    
    private enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}

struct Author: Decodable {
    let name: LabelString
}

struct LabelString: Decodable {
    let label: String
}
