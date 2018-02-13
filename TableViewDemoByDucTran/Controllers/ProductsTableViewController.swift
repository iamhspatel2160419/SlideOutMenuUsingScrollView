//
//  ProductsTableViewController.swift
//  TableViewDemoByDucTran
//
//  Created by hp ios on 1/18/18.
//  Copyright © 2018 andiosdev. All rights reserved.
//

import UIKit



class ProductsTableViewController: UITableViewController
{
    
   

    var products:ProductLine = ProductLine.productLines().first!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apple Store"
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        navigationItem.rightBarButtonItem = editButtonItem
    
    }
    @IBAction func toggleLeftSideBar(_ sender: UIBarButtonItem)
    {
        NotificationCenter.default.post(name: Notification.Name("toggleMethodCall"), object: nil)
       
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
       // let productLineHeader = products[section]
        return products.name
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return products.products.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        
        let product = products.products[indexPath.row]
        
        cell.product = product
   
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            
            products.products.remove(at: indexPath.row)
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
        let productToMove = products.products[sourceIndexPath.row]
      // move productToMove to destination product
      products.products
                .insert(productToMove,
                        at: destinationIndexPath.row)
      // delete productToMove from the source products
      products.products
            .remove(at: sourceIndexPath.row)
    }
    
    var selectedProduct: Product?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let product = products.products[indexPath.row]
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
