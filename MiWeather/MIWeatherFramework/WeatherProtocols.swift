//
//  WeatherProtocols.swift
//  MIWeatherFramework
//
//  Created by oussef on 09/03/2023.
//

import Foundation

protocol APIHandlerDelegate {
    func fetchData(url: URL, completion: @escaping(Result<Data,NetworkError>) -> Void)
}

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data:Data, completion:(Result<T,NetworkError>) -> Void)
}
