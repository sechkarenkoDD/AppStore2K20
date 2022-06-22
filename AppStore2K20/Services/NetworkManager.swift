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
    
    func fetchApp(completion: @escaping(Result<AppList, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.letsbuildthatapp.com/appstore/featured") else {
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
                let appList = try decoder.decode(AppList.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(appList))
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchAppWithContinuations() async throws -> AppList {
        try await withCheckedThrowingContinuation { continuation in
            fetchApp { result in
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



