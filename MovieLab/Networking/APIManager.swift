//
//  APIManager.swift
//  MovieLab
//
//  Created by King Bileygr on 9/1/21.
//

import Foundation


protocol NetworkService {
    func loadRequest<T: Decodable>(path: String, model: T.Type, completion: @escaping ((Result<T, Error>)->Void))
}

class APIManager: NetworkService {
    
    static let shared = APIManager()
    
    public func loadRequest<T: Decodable>(path: String, model: T.Type, completion: @escaping ((Result<T, Error>)->Void)) {
        
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "api.themoviedb.org"
        componentURL.path = path
        componentURL.queryItems = [URLQueryItem(name: "api_key", value: "466c2ad60a1939e3104fbc1b17ebab12")]
        
        guard let url = componentURL.url else { return }
        URLSession.shared.decodeData(from: url, type: T.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
}


struct NetworkAdapter: NetworkService {
    let adapter: APIManager
    
    func loadRequest<T>(path: String, model: T.Type, completion: @escaping ((Result<T, Error>) -> Void)) where T : Decodable {
        adapter.loadRequest(path: path, model: model) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
