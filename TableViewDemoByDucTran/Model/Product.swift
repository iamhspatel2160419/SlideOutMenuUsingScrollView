//
//  Product.swift
//  TableViewDemoByDucTran
//
//  Created by hp ios on 1/18/18.
//  Copyright © 2018 andiosdev. All rights reserved.
//

import Foundation
import UIKit
public enum ProductRating
{
    case unrated
    case average
    case ok
    case good
    case brilliant
}

class Product
{
    var title: String
    var description: String
    var image: UIImage
    var rating: ProductRating
    
    init(titled: String, description: String, imageName: String)
    {
        self.title = titled
        self.description = description
        if let img = UIImage(named: imageName) {
            image = img
        } else {
            image = UIImage(named: "default")!
        }
        rating = .unrated
    }
    
}
