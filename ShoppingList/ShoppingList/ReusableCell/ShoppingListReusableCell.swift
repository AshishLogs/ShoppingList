//
//  ShoppingListReusableCell.swift
//  ShoppingList
//
//  Created by MelpApp-Ashish on 7/3/20.
//  Copyright © 2020 iSingh. All rights reserved.
//

import UIKit

protocol ShoppingListReusableCellDelegate: class {
    func productVariant(with index: IndexPath?)
}

class ShoppingListReusableCell: UITableViewCell, ReusableView, NibLoadableView {
    
    weak var delegate : ShoppingListReusableCellDelegate?

    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var tax: UILabel!
    
    @IBOutlet weak var nameValue: UILabel!
    @IBOutlet weak var dateValue: UILabel!
    @IBOutlet weak var taxValue: UILabel!
    
    @IBOutlet weak var btnVariants: UIButton!
    
    var index : IndexPath?
    
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
        btnVariants.isHidden = false
        name.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        date.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        tax.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        tax.text = "Tax (\(categories.tax?.name ?? ""))"
        
        nameValue.text = String.init(format: ":    %@", categories.name ?? "")
        dateValue.text = String.init(format: ":    %@", categories.dateAdded ?? "")
        taxValue.text = String.init(format: ":    %0.2f", categories.tax?.value ?? "")
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let dateFormatterNew = DateFormatter()
        dateFormatterNew.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterNew.dateFormat = "dd-MM-yyyy"

        
        if let date = dateFormatter.date(from: categories.dateAdded ?? "") {
            dateValue.text = String.init(format: ":    %@", dateFormatterNew.string(from: date))
        }
        
    }
    @IBOutlet weak var viewCount: UILabel!
    
    func viewCount(_ name: String?, count: String?) {
        if name == nil, count == nil {
            viewCount.text = nil
        } else {
            viewCount.text = "\(name ?? "") : \(count ?? "")"
        }
        
    }
    
    func categoryVariant(_ categories: Variant) {
        btnVariants.isHidden = true
        name.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        date.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        tax.font = UIFont.systemFont(ofSize: 15.0, weight: .semibold)
        name.text = "color"
        date.text = "size"
        tax.text = "price"
        
        nameValue.text = String.init(format: ":    %@", categories.color ?? "")
        dateValue.text = String.init(format: ":    %d", categories.size ?? 0)
        taxValue.text = String.init(format: ":    %d", categories.price ?? 0)
    }
    
    @IBAction func btnVariantAction(_ sender: UIButton) {
        self.delegate?.productVariant(with: index)
    }
}
