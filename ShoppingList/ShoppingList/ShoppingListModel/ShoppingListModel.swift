//
//  ShoppingListModel.swift
//  ShoppingList
//
//  Created by MelpApp-Ashish on 7/3/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit

// MARK: - ShoppingModel
struct ShoppingModel: Codable {
    let categories: [Category]?
    let rankings: [Ranking]?
    
    init(category: [Category]?, rank: [Ranking]? = nil) {
        self.categories = category
        self.rankings = rank
    }
    
}

// MARK: - Category
class Category: NSObject, Codable, NSCoding {
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(products, forKey: "products")
        coder.encode(childCategories, forKey: "child_categories")
    }
    
    required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as? Int
        name = coder.decodeObject(forKey: "name") as? String
        products = coder.decodeObject(forKey: "products") as? [CategoryProduct]
        childCategories = coder.decodeObject(forKey: "child_categories") as? [Int]
    }
    
    let id: Int?
    let name: String?
    let products: [CategoryProduct]?
    let childCategories: [Int]?
    
    
    
    enum CodingKeys: String, CodingKey {
        case id, name, products
        case childCategories = "child_categories"
    }
        
}

// MARK: - CategoryProduct
class CategoryProduct:NSObject, Codable, NSCoding {
    let id: Int?
    let name, dateAdded: String?
    let variants: [Variant]?
    let tax: Tax?

    enum CodingKeys: String, CodingKey {
        case id, name
        case dateAdded = "date_added"
        case variants, tax
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(dateAdded, forKey: "date_added")
        coder.encode(variants, forKey: "variants")
        coder.encode(tax, forKey: "tax")
    }
    
    required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as? Int
        name = coder.decodeObject(forKey: "name") as? String
        dateAdded = coder.decodeObject(forKey: "date_added") as? String
        variants = coder.decodeObject(forKey: "variants") as? [Variant]
        tax = coder.decodeObject(forKey: "tax") as? Tax
    }

    
}

// MARK: - Tax
class Tax:NSObject, Codable, NSCoding {
    let name: String?
    let value: Double?
    
    func encode(with coder: NSCoder) {
        coder.encode(value, forKey: "value")
        coder.encode(name, forKey: "name")
    }
    
    required init?(coder: NSCoder) {
        value = coder.decodeObject(forKey: "value") as? Double
        name = coder.decodeObject(forKey: "name") as? String
    }
}

// MARK: - Variant
class Variant: NSObject, Codable, NSCoding {
    let id: Int?
    let color: String?
    let size: Int?
    let price: Int?
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(color, forKey: "color")
        coder.encode(size, forKey: "size")
        coder.encode(price, forKey: "price")
    }
    
    required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as? Int
        color = coder.decodeObject(forKey: "color") as? String
        size = coder.decodeObject(forKey: "size") as? Int
        price = coder.decodeObject(forKey: "price") as? Int
    }

    
}

// MARK: - Ranking
class Ranking:NSObject, Codable, NSCoding {
    let ranking: String?
    var products: [RankingProduct]?
    
    func encode(with coder: NSCoder) {
        coder.encode(ranking, forKey: "ranking")
        coder.encode(products, forKey: "products")
    }
    
    required init?(coder: NSCoder) {
        ranking = coder.decodeObject(forKey: "ranking") as? String
        products = coder.decodeObject(forKey: "products") as? [RankingProduct]
    }

    
}

// MARK: - RankingProduct
class RankingProduct:NSObject, Codable, NSCoding {
    let id, viewCount, orderCount, shares: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case viewCount = "view_count"
        case orderCount = "order_count"
        case shares
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(viewCount, forKey: "view_count")
        coder.encode(orderCount, forKey: "order_count")
        coder.encode(shares, forKey: "shares")
    }
    
    required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as? Int
        viewCount = coder.decodeObject(forKey: "view_count") as? Int
        orderCount = coder.decodeObject(forKey: "order_count") as? Int
        shares = coder.decodeObject(forKey: "shares") as? Int
    }

    
}
