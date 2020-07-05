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
    
    @IBOutlet weak var filterCollections: UICollectionView! {
        didSet {
            filterCollections.delegate = self
            filterCollections.dataSource = self
            filterCollections.register(FilterListReusableCell.self)
        }
    }
    
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- Update view from view model
    func updateView() {
        DispatchQueue.main.async { [unowned self] in
            self.shoppingTableView.reloadData()
            self.filterCollections.reloadData()
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let count = viewModel?.rows(section), count <= 0 {
            return 0.0
        }
        if viewModel?.currentRanking != nil { return 0 }
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: 50.0))
        view.backgroundColor = .white
        let label = UILabel.init(frame: .init(x: 20, y: 0, width: tableView.frame.width, height: 50.0))
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.text = viewModel?.sectionHeaderText(section)
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ShoppingListReusableCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        if let rank = viewModel?.currentRanking {
            cell.category(viewModel!.filterObjects![indexPath.row])
            cell.viewCount(rank.ranking, count: "\(rank.products!.first(where: {$0.id == viewModel!.filterObjects![indexPath.row].id })?.viewCount ?? 0)")
        } else {
            cell.category(viewModel!.shoppingModel!.categories![indexPath.section].products![indexPath.row])
            cell.viewCount(nil, count: nil)
        }
        return cell
    }
    
}

//MARK:- UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension ShoppingListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.filter_models().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : FilterListReusableCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        if let model = viewModel {
            let ranking = model.filter_models()[indexPath.row]
            if let rank = model.currentRanking, rank.ranking == ranking.ranking {
                cell.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.2549019608, blue: 0.2117647059, alpha: 1).cgColor
            } else {
                cell.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
            }
            cell.text(ranking.ranking)
            if indexPath.row == model.filter_models().count - 1 {
                heightCollectionView.constant = collectionView.contentSize.height + 8.0
                view.layoutIfNeeded()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let model = viewModel else { return CGSize.zero }
        let ranking = model.filter_models()[indexPath.row]
        let text = ranking.ranking ?? ""
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:12.0)]).width + 30.0
        return CGSize(width: cellWidth, height: 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = viewModel else { return  }
        model.currentRank(indexPath.row)
        model.filteredRow()
    }
    
}
