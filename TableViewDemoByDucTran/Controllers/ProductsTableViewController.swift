//
//  ProductsTableViewController.swift
//  TableViewDemoByDucTran
//
//  Created by hp ios on 1/18/18.
//  Copyright © 2018 andiosdev. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {

    var products:[ProductLine] = ProductLine.productLines()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple Store"
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        navigationItem.rightBarButtonItem = editButtonItem
    
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let productLineHeader = products[section]
        return productLineHeader.name
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return products.count
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return products[section].products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        
        let product = products[indexPath.section].products[indexPath.row]
        
        cell.product = product
   
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let productLine = products[indexPath.section]
            productLine.products.remove(at: indexPath.row)
            
            //tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    // Moving Cells
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let productToMove = products[sourceIndexPath.section].products[sourceIndexPath.row]
      // move productToMove to destination product
      products[destinationIndexPath.section].products
                .insert(productToMove,
                        at: destinationIndexPath.row)
      // delete productToMove from the source products
      products[destinationIndexPath.section].products
            .remove(at: sourceIndexPath.row)
    }
    
    var selectedProduct: Product?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let product = products[indexPath.section].products[indexPath.row]
        selectedProduct = product
        performSegue(withIdentifier: "ShowProductDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ShowProductDetail"
        {
           let detailTVC = segue.destination as! DetailTableViewController
           detailTVC.product = selectedProduct
        }
    }
    
}
