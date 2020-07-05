//
//  ShoppingViewModel.swift
//  ShoppingListTests
//
//  Created by MelpApp-Ashish on 7/5/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import XCTest
@testable import ShoppingList

class ShoppingViewModel: XCTestCase, ShoppingListDelegate {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testViewModel() {
        let network = Network.init()
        let networkRequest = NetworkRequest.init(network)
        let model = ShoppingListViewModel.init(networkRequest, delegate: self)
        model.getModel()
    }
    
    func updateView() {
        XCTAssertTrue(true)
    }
    
    func testNetworkLogging() {
        let network = Network.init()
        let networkRequest = NetworkRequest.init(network)
        networkRequest.shoppingList { (result) in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    let coreData = CoreDataWrapper(model)
                    coreData.loadData(handler: { (rdata) in
                        XCTAssertTrue(rdata.categoy.count > 0)
                        XCTAssertTrue(rdata.rank.count > 0)
                    })
                }
            case .failure(_):
                DispatchQueue.main.async {
                    let coreData = CoreDataWrapper()
                    coreData.loadData { (coredata) in
                        let model = ShoppingModel(category: coredata.categoy, rank: coredata.rank)
                        XCTAssert(model.categories != nil && model.rankings != nil)
                    }
                }
            }
        }
    }
    
}
