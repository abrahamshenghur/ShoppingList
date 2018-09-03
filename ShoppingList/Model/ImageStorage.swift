//
//  ImageStorage.swift
//  ShoppingList
//
//  Created by John on 9/2/18.
//  Copyright © 2018 Abraham Shenghur. All rights reserved.
//

import UIKit

class ImageStorage {
    let cache = NSCache<NSString,UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
