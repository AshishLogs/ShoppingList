//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by MelpApp-Ashish on 7/3/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, ShoppingListDelegate {

    var viewModel : ShoppingListViewModel? {
        didSet {
            viewModel?.getModel()
        }
    }
    
    @IBOutlet weak var shoppingTableView: UITableView! {
        didSet {
            shoppingTableView.delegate = self
            shoppingTableView.dataSource = self
            shoppingTableView.register(ShoppingListReusableCell.self)
            shoppingTableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Update view from view model
    func updateView() {
        print("done -- yayyyyy")
        shoppingTableView.reloadData()
    }
    
}

//MARK:- UITableViewDelegate & UITableViewDataSource
extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rows(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ShoppingListReusableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    
}
