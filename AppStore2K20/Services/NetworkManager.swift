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

enum NetworkUrlLinks: String {
    case topPaid = "https://rss.applemarketingtools.com/api/v2/us/apps/top-paid/50/apps.json"
    case topFree = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
    case socialApp = "https://api.letsbuildthatapp.com/appstore/social"
}

class NetworkManager {
    
    static let shered = NetworkManager()
    private init() {}
    
    private func fetchSocialApps(url: String, completion: @escaping(Result<[SocialApp], NetworkError>) -> Void) {
        fechData(urlString: url, completion: completion)
    }
    
    private func fetchTopApps(url: String, completion: @escaping(Result<AppGroup, NetworkError>) -> Void) {
        fechData(urlString: url, completion: completion)
    }
    
    private func fetchSearchApps(searchTerm: String, completion: @escaping(Result<SearchResult, NetworkError>) -> Void) {
        let url = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        fechData(urlString: url, completion: completion)
    }
    
    private func fechData<T: Decodable>(urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
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
//MARK: - async/await methods
extension NetworkManager {
    
    func fetchSocilaAppsContinuations(url: String) async throws -> [SocialApp] {
        try await withCheckedThrowingContinuation { continuation in
            fetchSocialApps(url: url) { result in
                switch result {
                case .success(let socilaApp):
                    continuation.resume(returning: socilaApp)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetchTopAppsContinuations(url: String) async throws -> AppGroup {
        try await withCheckedThrowingContinuation { continuation in
            fetchTopApps(url: url) { result in
                switch result {
                case .success(let appGroup):
                    continuation.resume(returning: appGroup)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetchSearchAppsContinuations(searchTerm: String) async throws -> SearchResult {
        try await withCheckedThrowingContinuation { continuation in
            fetchSearchApps(searchTerm: searchTerm) { result in
                switch result {
                case .success(let appList):
                    continuation.resume(returning: appList)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}



