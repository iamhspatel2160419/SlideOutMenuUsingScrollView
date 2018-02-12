//
//  MenuTableViewController.swift
//  TableViewDemoByDucTran
//
//  Created by hp ios on 2/12/18.
//  Copyright © 2018 andiosdev. All rights reserved.
//

import Foundation
import UIKit


protocol MenuTVCDelegate:class
{
    func menuTableViewController(_ controller:MenuTableViewController,didSelectRow row:Int)
}
    
    
class MenuTableViewController:UITableViewController
{
    weak var delegate:MenuTVCDelegate?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.menuTableViewController(self, didSelectRow: indexPath.row)
    }
}
