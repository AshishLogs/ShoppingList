//
//  ShoppingProductDetailViewController.swift
//  ShoppingList
//
//  Created by MelpApp-Ashish on 7/5/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit

class ShoppingProductDetailViewController: UIViewController {

    var product : CategoryProduct?
    
    @IBOutlet weak var productTableView: UITableView! {
        didSet {
            productTableView.delegate = self
            productTableView.dataSource = self
            productTableView.register(ShoppingListReusableCell.self)
            productTableView.tableFooterView = UIView(frame: CGRect.zero)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

//MARK:- UITableViewDelegate & UITableViewDataSource
extension ShoppingProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product?.variants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: 50.0))
        view.backgroundColor = .white
        let label = UILabel.init(frame: .init(x: 20, y: 0, width: tableView.frame.width, height: 50.0))
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.text = product?.name
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ShoppingListReusableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.categoryVariant(product!.variants![indexPath.row])
        return cell
    }
    
}
