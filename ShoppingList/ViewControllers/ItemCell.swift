//
//  ItemCell.swift
//  ShoppingList
//
//  Created by John on 8/30/18.
//  Copyright © 2018 Abraham Shenghur. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    var itemUnitNumber = 1 {
        didSet {
            itemUnitNumberLabel.text = String(itemUnitNumber)
        }
    }
    

    @IBOutlet var itemUnitNumberLabel: UILabel! // I need to take the String(itemUnitNumber) and store it in itemU.N.Label.txt
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    
    var incrementButtonHandler: (() -> Void)?
    var decrementButtonHandler: (() -> Void)?
    var checkMarkButtonHandler: (() -> Void)?
    
    @IBAction func incrementItem(_ sender: UIButton) {
        itemUnitNumber += 1
        incrementButtonHandler?()
    }
    
    @IBAction func decrementItem(_ sender: UIButton) {
        itemUnitNumber -= 1
        decrementButtonHandler?()
    }
    
    @IBAction func itemCheckmark(_ sender: UIButton) {
        checkMarkButtonHandler?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameTextField.adjustsFontForContentSizeCategory = true
        priceTextField.adjustsFontForContentSizeCategory = true
    }
    
}






