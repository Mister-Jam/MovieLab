//
//  OtherExtensions.swift
//  MovieLab
//
//  Created by King Bileygr on 8/31/21.
//

import Foundation

extension URLSession {
        //MARK: Get Data From a URL Session
        //MARK: Decode Data Gotten From a URL Session
        func decodeData<T: Decodable> (from url: URL, type: T.Type,
                                       keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy     = .useDefaultKeys,
                                       dataDecodingStrategy: JSONDecoder.DataDecodingStrategy   = .deferredToData,
                                       completion: @escaping ((Result<T, Error>)->Void)
        ) {
            
            URLSession.shared.dataTask(with: url) { apiData, _, apiError in
                guard let apiData = apiData, apiError == nil else {
                    completion(.failure(apiError!))
                    return }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy     = .convertFromSnakeCase
                decoder.dataDecodingStrategy    = dataDecodingStrategy
                do {
                    let decodedData = try decoder.decode(T.self, from: apiData)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
