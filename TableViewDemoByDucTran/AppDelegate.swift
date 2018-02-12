//
//  AppDelegate.swift
//  TableViewDemoByDucTran
//
//  Created by hp ios on 1/18/18.
//  Copyright © 2018 andiosdev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var menuNav:UINavigationController!
    
    var productNav:UINavigationController!
    
    var sideBarVC:SidebarViewController!
    
    var productTableViewController = [ProductsTableViewController]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        let storyBoard = UIStoryboard(name:"Main",bundle:Bundle.main)
        
        for productLine in ProductLine.productLines()
        {
            let productTVC = storyBoard.instantiateViewController(withIdentifier: "ProductTVC") as! ProductsTableViewController
            productTVC.products = productLine
            productTableViewController.append(productTVC)
        }
        
        productNav = UINavigationController(rootViewController: productTableViewController[0])
        
        let MenuVC = storyBoard.instantiateViewController(withIdentifier: "MenuVC") as! MenuTableViewController
        MenuVC.delegate = self
        
        menuNav = UINavigationController(rootViewController: MenuVC)
        
        sideBarVC = SidebarViewController(leftViewController: MenuVC,
                                          mainViewController: productNav,
                                          overLap: 86.0)
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController = sideBarVC
        window?.makeKeyAndVisible()
        
        return true
        
    }


}
extension AppDelegate:MenuTVCDelegate
{
    func menuTableViewController(_ controller:MenuTableViewController,didSelectRow row:Int)
    {
        let selectedVC = productTableViewController[row]
        if productNav.topViewController != selectedVC
        {
            productNav.setViewControllers([selectedVC], animated: false)
        }
    }
}

