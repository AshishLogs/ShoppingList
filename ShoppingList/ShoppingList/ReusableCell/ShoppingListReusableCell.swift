//
//  ShoppingListReusableCell.swift
//  ShoppingList
//
//  Created by MelpApp-Ashish on 7/3/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit

class ShoppingListReusableCell: UITableViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var tax: UILabel!
    
    @IBOutlet weak var nameValue: UILabel!
    @IBOutlet weak var dateValue: UILabel!
    @IBOutlet weak var taxValue: UILabel!
    
    @IBOutlet weak var btnVariants: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        parentView.layer.cornerRadius = 15.0
        parentView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        parentView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        parentView.layer.shadowRadius = 2.0
        parentView.layer.shadowOpacity = 0.7
        
        btnVariants.layer.cornerRadius = 15.0
        btnVariants.layer.shadowColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        btnVariants.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        btnVariants.layer.shadowRadius = 2.0
        btnVariants.layer.shadowOpacity = 0.7

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func category(_ categories: CategoryProduct) {
        name.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        date.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        tax.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        tax.text = "Tax (\(categories.tax?.name ?? Name.vat))"
        
        nameValue.text = String.init(format: ":    %@", categories.name ?? "")
        dateValue.text = String.init(format: ":    %@", categories.dateAdded ?? "")
        taxValue.text = String.init(format: ":    %0.2f", categories.tax?.value ?? "")
    }
    @IBOutlet weak var viewCount: UILabel!
    
    func viewCount(_ name: String?, count: String?) {
        viewCount.text = "\(name ?? "") : \(count ?? "")"
    }
    
}
