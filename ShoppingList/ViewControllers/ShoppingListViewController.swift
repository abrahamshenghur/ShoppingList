//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by John on 8/29/18.
//  Copyright © 2018 Abraham Shenghur. All rights reserved.
//

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var itemStorage: ItemStorage!
    var imageStorage: ImageStorage!
    var totalPrice: Double = 0.0
    var numberOfItems = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        // var imageView = UIImage
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var totalPriceLabel: UILabel!
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        let newItem = itemStorage.createList()
        if let index = itemStorage.itemList.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            self.numberOfItems += indexPath.count / 2
            updateUI()
        }
    }
    
    
    func updateUI() {
        totalPrice = 0
        for item in itemStorage.itemList {
            if item.isSelected == true {
                totalPrice += (item.price * Double(item.quantity))
                totalPriceLabel.text = String(format: "\(numberOfItems + item.quantity-1) ITEMS\t\t Total Price $%.2f", totalPrice)
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStorage.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        //print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row)")

        let item = itemStorage.itemList[indexPath.row]
        cell.nameTextField.text = item.name
        cell.priceTextField.text = String(format: "$%.2f", item.price)
        cell.incrementButtonHandler = {
            item.quantity += 1
            self.updateUI()
        }
        cell.decrementButtonHandler = {
            item.quantity -= 1
            self.updateUI()
        }
        cell.checkMarkButtonHandler = {
            print("Checkmark clicked")
            if item.isSelected == true {
                // show checkmark changing to solid color and adding to the price
                self.updateUI()
            } else {
                // show checkmark changing to ligter color and subtracting from price
                self.updateUI()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStorage.itemList[indexPath.row]
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                self.itemStorage.removeItem(item)
                self.imageStorage.deleteImage(forKey: item.itemKey)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStorage.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemStorage.itemList[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
                item.isSelected = true
            } else {
                cell.accessoryType = .none
                item.isSelected = false
            }
        }
        updateUI()
    }
    
    
    // MARK: - Reload UITableView to see edited PhotoViewController's text field contents
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStorage.itemList[row]
                let photoViewController = segue.destination as! PhotoViewController
                photoViewController.item = item
                photoViewController.imageStorage = imageStorage
                photoViewController.title = "Row \(row+1) - \(item.name)"
            }
        default: preconditionFailure("Unexpected segue identifier.")
        }
    }
}











