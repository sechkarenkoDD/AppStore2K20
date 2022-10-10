//
//  NetworkManager.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 14.06.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

class NetworkManager {
    
    static let shered = NetworkManager()
    private init() {}
    
    func fetchBannerApps(completion: @escaping(Result<[BannerApp], NetworkError>) -> Void) {
        let url = "https://api.letsbuildthatapp.com/appstore/social"
        getData(urlString: url, completion: completion)
    }
    
    func fetchTopPaidApps(completion: @escaping(Result<AppGroup, NetworkError>) -> Void) {
        let url = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/50/apps.json"
        getData(urlString: url, completion: completion)
    }
    
    func fetchTopFreeApps(completion: @escaping(Result<AppGroup, NetworkError>) -> Void) {
        let url = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
        getData(urlString: url, completion: completion)
    }
    
    func fetchSearchApps(request: String, completion: @escaping(Result<SearchResult, NetworkError>) -> Void) {
        let url = "https://itunes.apple.com/search?term=\(request)&entity=software"
        getData(urlString: url, completion: completion)
    }
    
    func fetchDetailApps(appID: String, completion: @escaping(Result<SearchResult, NetworkError>) -> Void) {
        let url = "https://itunes.apple.com/lookup?id=\(appID)"
        getData(urlString: url, completion: completion)
    }
    
    func fetchReviewApps(appID: String, completion: @escaping(Result<Reviews, NetworkError>) -> Void) {
        let url = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appID)/sortby=mostrecent/json?l=en&cc=us"
        getData(urlString: url, completion: completion)
    }
    
    private func getData<T: Decodable>(urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let data = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
////MARK: - async/await methods
//extension NetworkManager {
//
//    func fetchSocilaAppsContinuations() async throws -> [BannerApp] {
//        try await withCheckedThrowingContinuation { continuation in
//            fetchBannerApps(url: url) { result in
//                switch result {
//                case .success(let socilaApp):
//                    continuation.resume(returning: socilaApp)
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
//
//    func fetchTopAppsContinuations(url: String) async throws -> AppGroup {
//        try await withCheckedThrowingContinuation { continuation in
//            fetchTopPaidApps(url: url) { result in
//                switch result {
//                case .success(let appGroup):
//                    continuation.resume(returning: appGroup)
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
//
//    func fetchSearchAppsContinuations(request: String) async throws -> SearchResult {
//        try await withCheckedThrowingContinuation { continuation in
//            fetchSearchApps(request: request) { result in
//                switch result {
//                case .success(let appList):
//                    continuation.resume(returning: appList)
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
//
//    func fetchDetailAppsContinuations(id: String) async throws -> SearchResult {
//        try await withCheckedThrowingContinuation { continuation in
//            fetchDetailApps(id: id) { result in
//                switch result {
//                case .success(let app):
//                    continuation.resume(returning: app)
//                case .failure(let error):
//                    continuation.resume(throwing: error)
//                }
//            }
//        }
//    }
//}
//
//
//
