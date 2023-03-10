//
//  NetworkManager.swift
//  MIWeatherFramework
//
//  Created by oussef on 09/03/2023.
//

import Foundation

class NetworkManager {
    let apiHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(apiHandler: APIHandlerDelegate = APIHandler(), responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T:Codable>(type:T.Type, url:URL, completion:@escaping(Result<T, NetworkError>) -> Void){
        apiHandler.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { decodeResult in
                    switch decodeResult {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

public enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case decodingError(error: String)
    case error(error: String)
}
