//
//  DetailTableViewController.swift
//  TableViewDemoByDucTran
//
//  Created by hp ios on 1/18/18.
//  Copyright © 2018 andiosdev. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productDescriptionTextView: UITextView!
    @IBOutlet weak var productTitleTextField: UITextField!
    
    var product:Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Product"
        productTitleTextField.delegate = self
        
        productTitleTextField.text = product?.title
        productImageView.image = product?.image
        productDescriptionTextView.text = product?.description
        
        
    }
    
    // MARK :- UITableViewDelegate
    
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath?
      {
        if indexPath.section == 0 && indexPath.row == 0
        {
            return indexPath
        }
        else
        {
            return nil
        }
      }
}
extension DetailTableViewController:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
}

extension DetailTableViewController
{
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        productTitleTextField.resignFirstResponder()
        productDescriptionTextView.resignFirstResponder()
        
    }
    
    
}

