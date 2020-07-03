//
//  Network.swift
//  ShoppingList
//
//  Created by MelpApp-Ashish on 7/3/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit

public class Network : Networking {

    private let queue = DispatchQueue(label: "Network.Serial.Queue")
    
    public func getJSON<T>(url: String, handler: @escaping (Result<T, Error>) -> Void) where T : Codable {
        Network.perform(urlString: url, completion: handler)
    }
    
    private class func perform<T: Codable>(urlString: String, completion:@escaping (Result<T, Error>) -> Void) {
        guard let safeURL = URL(string: urlString) else { return }
        var request = URLRequest(url: safeURL)
        request.httpMethod = "GET"
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let jsonData = data {
                do {
                    let response = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error ?? NSError.init(domain: "something went wrong", code: 404, userInfo: nil)))
            }
        }.resume()
    }
}
