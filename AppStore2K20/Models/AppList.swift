//
//  AppList.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 14.06.2022.
//


struct AppList: Decodable {
    let bannerCategory: BannerCategory
    let categories: [Category]
}

struct BannerCategory: Decodable {
    let apps: [App]
}

struct Category: Decodable {
    let name: String
    let apps: [App]
}

struct App: Decodable {
    let id: Int?
    let name: String?
    let category: String?
    let price: Double?
    let imageName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case category = "category"
        case price = "Price"
        case imageName = "ImageName"
    }
}
