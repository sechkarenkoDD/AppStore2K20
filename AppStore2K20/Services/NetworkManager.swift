//
//  NetworkManager.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 14.06.2022.
//

import Foundation

enum LinksURL: String {
    case seatch = "https://itunes.apple.com/search?term=instagram&entity=software"
    case letsbuildthatapp = "https://api.letsbuildthatapp.com/appstore/featured"
}

enum NetworkError: Error {
    case invalidURL
    case noData
}

class NetworkManager {
    
    static let shered = NetworkManager()
    private init() {}
    
    func fetchSearchApp(completion: @escaping(Result<SearchResult, NetworkError>) -> Void) {
        fechData(urlString: LinksURL.seatch.rawValue, completion: completion)
    }
    
    func fetchApp(completion: @escaping(Result<AppList, NetworkError>) -> Void) {
        fechData(urlString: LinksURL.letsbuildthatapp.rawValue, completion: completion)
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

extension NetworkManager {
    
    func fetchAppWithContinuations() async throws -> AppList {
        try await withCheckedThrowingContinuation { continuation in
            fetchApp() { result in
                switch result {
                case .success(let appList):
                    continuation.resume(returning: appList)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func fetchSearchAppWithContinuations() async throws -> SearchResult {
        try await withCheckedThrowingContinuation { continuation in
            fetchSearchApp() { result in
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



