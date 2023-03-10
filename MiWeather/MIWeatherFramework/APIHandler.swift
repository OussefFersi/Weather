//
//  APIHandler.swift
//  MIWeatherFramework
//
//  Created by oussef on 09/03/2023.
//

import Foundation

class APIHandler: APIHandlerDelegate {
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                 completion(.failure(.invalidData))
                return
            }
                        
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                            return
            }
                        
            guard error == nil else {
                if let error = error?.localizedDescription {
                    completion(.failure(.error(error: error)))
                }
                return
            }
            
            completion(.success(data))
        }.resume()
    }
    
    
}
