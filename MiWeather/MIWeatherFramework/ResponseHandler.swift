//
//  ResponseHandler.swift
//  MIWeatherFramework
//
//  Created by oussef on 09/03/2023.
//

import Foundation

class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T>(type: T.Type, data: Data, completion: (Result<T, NetworkError>) -> Void) where T : Decodable, T : Encodable {
        do {
            let response = try JSONDecoder().decode(type.self, from: data)
            completion(.success(response))
        } catch let error {
            completion(.failure(.decodingError(error: error.localizedDescription)))
        }
    }
    
    
}
