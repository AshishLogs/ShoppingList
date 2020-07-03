//
//  NetworkRequest.swift
//  ShoppingList
//
//  Created by MelpApp-Ashish on 7/3/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit

class NetworkRequest {

    var network : Network?
    
    init(_ network: Network) {
        self.network = network
    }
    
    func shoppingList(completion: @escaping (Result<ShoppingModel, Error>) -> Void) {
        self.network?.getJSON(url: Constants.URL.shoppingList, handler: completion)
    }
}
