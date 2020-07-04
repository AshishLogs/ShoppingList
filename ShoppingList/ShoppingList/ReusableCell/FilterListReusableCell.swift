//
//  FilterListReusableCell.swift
//  ShoppingList
//
//  Created by MelpApp-Ashish on 7/5/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit

class FilterListReusableCell: UICollectionViewCell, ReusableView, NibLoadableView {

    @IBOutlet weak var textLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textLabel.font = UIFont.systemFont(ofSize:11.0)
        self.textLabel.text = nil
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 1.2
        self.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
    }
    
    func text(_ txt: String?) {
        textLabel.text = txt
    }

}
