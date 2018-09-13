//
//  PhotoViewController.swift
//  ShoppingList
//
//  Created by John on 9/1/18.
//  Copyright © 2018 Abraham Shenghur. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var priceField: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func takePhoto(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        // If the device has a camera, take a picture; otherwise,
        // just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        // Place image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // TODO: QUESTION - Is this the right approach to display the item's corresponding row number for the navigationItem's title?
    var itemRowNumber: Int = 0 {
        didSet {
            itemRowNumber = 1
        }
    }
    
    
    // MARK:- Setup Interface; a reference to Item.swift to display contents

    var item: Item! {
        didSet {
            navigationItem.title = "Item " + "\(itemRowNumber)" + "  -  " + item.name
        }
    }
    var imageStorage: ImageStorage!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.becomeFirstResponder()
        
        nameField.text = item.name
        priceField.text = "\(item.price)"
        
        // Get the item key
        let key = item.itemKey
        
        // If there is an associated image with the item
        // display it on the image view
        let imageToDisplay = imageStorage.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    
    // MARK: - Disappearing View
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Clear first responder
        view.endEditing(true)
        
        // "Save" changes to item
        item.name = nameField.text ?? ""
        //item.price = priceField.text ?? "" //TODO: Gives Error when uncommented
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Store the image in teh ImageStorage for the item's key
        imageStorage.setImage(image, forKey: item.itemKey)
        
        // Put that image on the screen in the image view
        imageView.image = image
        
        // Take the pikcer off the screen -
        // you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }
}





