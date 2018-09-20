//
//  Item.swift
//  ShoppingList
//
//  Created by John on 8/29/18.
//  Copyright © 2018 Abraham Shenghur. All rights reserved.
//

import UIKit

class Item: NSObject {
    
    var name: String
    var price: Double
    var itemKey: String
    var isSelected: Bool
    var quantity: Int
    // TODO: item tax (most likely an optional)

    init(name: String, price: Double) {
        self.name = name
        self.price = price
        self.itemKey = UUID().uuidString
        self.isSelected = true
        self.quantity = 1

        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let quantity = ["1 pound ", "2 pounds ", "3 pounds "]
            let product = [" meat", " rice", " potatos"]
            
            var idx = arc4random_uniform(UInt32(quantity.count))
            let randomQuantity = quantity[Int(idx)]
            
            idx = arc4random_uniform(UInt32(product.count))
            let randomProduct = product[Int(idx)]
            
            let randomPurchase = "\(randomQuantity) \(randomProduct)"
            let randomPrice = Double(arc4random_uniform(100))
            
            self.init(name: randomPurchase, price: randomPrice)
        } else {
            self.init(name: "", price: 0.00)
        }
    }
}












