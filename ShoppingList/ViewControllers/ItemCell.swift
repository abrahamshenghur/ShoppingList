//
//  ItemCell.swift
//  ShoppingList
//
//  Created by John on 8/30/18.
//  Copyright © 2018 Abraham Shenghur. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameTextField.adjustsFontForContentSizeCategory = true
        priceTextField.adjustsFontForContentSizeCategory = true
    }
    
}
