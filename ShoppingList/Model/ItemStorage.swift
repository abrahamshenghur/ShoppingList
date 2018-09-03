//
//  ItemStorage.swift
//  ShoppingList
//
//  Created by John on 8/29/18.
//  Copyright © 2018 Abraham Shenghur. All rights reserved.
//

import UIKit

class ItemStorage {
    
    var itemList = [Item]()
    
    @discardableResult func createList() -> Item {
        let newItem = Item(random: true)
        
        itemList.append(newItem)
        
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = itemList.index(of: item) {
            itemList.remove(at: index)
        }
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedItem = itemList[fromIndex]
        
        // Remove item from array
        itemList.remove(at: fromIndex)
        
        // Insert item in array at new location
        itemList.insert(movedItem, at: toIndex)
    }
}
