//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by John on 8/29/18.
//  Copyright © 2018 Abraham Shenghur. All rights reserved.
//

import UIKit

class ShoppingListViewController: UITableViewController {
    
    
    // MARK: - Storage Access; instances set externally in AppDelegate (abstraction required by dependency inversion principle)
    
    var itemStorage: ItemStorage!
    var imageStorage: ImageStorage!
    
    var totalPrice: Double = 0.0
    var numberOfItems = 0
    
    var unitSum = 0
    
    // MARK: - Adding Rows
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {

        // Create a new item and add it to the storage
        let newItem = itemStorage.createList()
        
        // Figure out where that item is in the array
        if let index = itemStorage.itemList.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            // Insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
            numberOfItems += indexPath.count / 2
            totalPrice += newItem.price
            totalPriceLabel.text = String(format: "\(numberOfItems) ITEMS\t\t Total Price $%.2f", totalPrice)
        }
    }
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    @IBAction func incrementItemUnit(_ sender: UIButton) {
        // When button is clicked increase item unit by 1
        // Use the sum of the unit's value multiplied by priceTextField
        
        // unitSum += 1
        // let updatedPriceTextField = unitSum * priceTextField
        
    }
    
    // TODO:- @IBAction func decrementItemUnit
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
        // var imageView = UIImage
    }
    
    
    // MARK: - QUESTION: Is it right to say this is the Table View Data Source?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStorage.itemList.count
    }
    
    
    // MARK: - Create/Retrieve UITableViewCells
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableView
        let item = itemStorage.itemList[indexPath.row]

        // Configure the cell with the Item
        cell.nameTextField.text = item.name
        cell.priceTextField.text = String(format: "$%.2f", item.price)
        
        return cell
    }
    
    
    // MARK: - Deleting Rows
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStorage.itemList[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            // Create instance of alert controller
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                // Remove the item from the storage
                self.itemStorage.removeItem(item)
                
                // Remove the image from the image storage
                self.imageStorage.deleteImage(forKey: item.itemKey)
                
                // Also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Moving Rows
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        itemStorage.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered segue is the "showPhoto" segue
        switch segue.identifier {
        case "showPhoto"?:
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                // Get the item associated with this row and pass it along
                let item = itemStorage.itemList[row]
                let photoViewController = segue.destination as! PhotoViewController
                photoViewController.item = item
                photoViewController.imageStorage = imageStorage
            }
        default: preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    
    // MARK: - Checkmark Selection
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .none {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
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
}











