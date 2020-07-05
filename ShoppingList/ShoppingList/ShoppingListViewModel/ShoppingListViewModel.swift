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

    var coreDataManager : CoreDataWrapper?
    
    var shoppingModel : ShoppingModel? {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.updateView()
            }
        }
    }
    
    var filterObjects : [CategoryProduct]? {
        didSet {
            self.delegate?.updateView()
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
                DispatchQueue.main.async {
                    self?.coreDataManager = CoreDataWrapper(model)
                    self?.coreDataManager?.loadData(handler: { (result) in
                        self?.shoppingModel = ShoppingModel(category: result.categoy, rank: result.rank)
                    })
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.coreDataManager = CoreDataWrapper()
                    self?.coreDataManager?.loadData(handler: { (result) in
                        self?.shoppingModel = ShoppingModel(category: result.categoy, rank: result.rank)
                    })
                }
            }
        })
    }
    
    func sections() -> Int? {
        if let _ = currentRanking {
            return 1
        }
        
        return shoppingModel?.categories?.count
    }
    
    func rows(_ section: Int) -> Int? {
        
        if let _ = currentRanking {
            return filterObjects?.count
        }
        
        guard let shopModel = shoppingModel else { return nil }
        return shopModel.categories?[section].products?.count
    }
    
    func filteredRow() {
        guard let shopModel = shoppingModel else { return }
        guard let ranking = currentRanking else { return }
        var arr : [CategoryProduct] = []
        for element in ranking.products ?? [] {
            for internalObj in shopModel.categories  ?? []{
                if let nObj = internalObj.products?.filter({$0.id == element.id}) {
                    arr.append(contentsOf: nObj)
                }
            }
        }
         filterObjects = arr
    }
    
    func sectionHeaderText(_ section: Int) -> String? {
        if let _ = currentRanking { return nil }
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
