//
//  Networking.swift
//  ShoppingList
//
//  Created by MelpApp-Ashish on 7/3/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit

public protocol Networking {
    func getJSON<T: Codable>(url: String,  handler: @escaping (_ result: Result<T, Error>) -> Void)
}
