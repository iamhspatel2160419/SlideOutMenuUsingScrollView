//
//  ProductTableViewCell.swift
//  TableViewDemoByDucTran
//
//  Created by hp ios on 1/18/18.
//  Copyright © 2018 andiosdev. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    var product:Product?
    {
        didSet
        {
         self.updateUI()
            
        }
    }
    func updateUI()
    {
        productTitleLabel?.text = product?.title
        productDescriptionLabel?.text = product?.description
        productImageView?.image = product?.image
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
