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
    
    var currentRanking : Ranking? {
        didSet {
            self.delegate?.updateView()
        }
    }

    var coreDataManager : CoreDataWrapper? {
        didSet {
            self.delegate?.updateView()
        }
    }
    
    var shoppingModel : ShoppingModel? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.coreDataManager = CoreDataWrapper(self?.shoppingModel)
            }
        }
    }
    
    init(_ manager: NetworkRequest, delegate: ShoppingListDelegate? = nil) {
        self.manager  = manager
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
    
    func sectionHeaderText(_ section: Int) -> String? {
        guard let shopModel = shoppingModel else { return nil }
        return shopModel.categories?[section].name
    }
    
    //MARK:- Filter
    func filter_models() -> [Ranking] {
        guard let model = shoppingModel else { return [] }
        guard let rankings = model.rankings else { return [] }
        return rankings
    }
    
    func currentRank(_ indice: Int?) {
        if let index = indice {
            if let rank = shoppingModel?.rankings?[index], rank.ranking == currentRanking?.ranking {
                currentRanking = nil
            } else {
                currentRanking = shoppingModel?.rankings?[index]
            }
        } else {
            currentRanking = nil
        }
    }
        
}
