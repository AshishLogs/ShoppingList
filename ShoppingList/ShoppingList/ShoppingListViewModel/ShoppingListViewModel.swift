//
//  ShoppingListViewModel.swift
//  ShoppingList
//
//  Created by MelpApp-Ashish on 7/3/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit

protocol ShoppingListDelegate: class {
    func updateView()
}

public class ShoppingListViewModel {
    
    weak var delegate: ShoppingListDelegate?
    
    var manager : NetworkRequest?

    var shoppingModel : ShoppingModel? {
        didSet {
            self.delegate?.updateView()
        }
    }
    
    init(_ manager: NetworkRequest, delegate: ShoppingListDelegate? = nil) {
        self.manager = manager
        self.delegate = delegate
    }

    func getModel() {
        manager?.shoppingList(completion: { [weak self](result) in
            switch result {
            case .success(let model):
                self?.shoppingModel = model
            case .failure(let error):
                debugPrint(error)
            }
        })
    }
    
    func sections() -> Int? {
        return shoppingModel?.categories?.count
    }
    
    func rows(_ section: Int) -> Int? {
        guard let shopModel = shoppingModel else { return nil }
        return shopModel.categories?[section].products?.count
    }
        
}
