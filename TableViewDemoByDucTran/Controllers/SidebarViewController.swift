//
//  SidebarViewController.swift
//  TableViewDemoByDucTran
//
//  Created by hp ios on 2/12/18.
//  Copyright © 2018 andiosdev. All rights reserved.
//

import UIKit
class SidebarViewController : UIViewController
{
    var leftViewController:UIViewController! // the Menu
    var mainViewController:UIViewController! // your main UI View
    var overLap:CGFloat!
    
    var productTabeleVC:ProductsTableViewController! = ProductsTableViewController()
    var scrollView: UIScrollView!
    var isFirstOpen = true
    
    override func viewDidLoad() {
        productTabeleVC.delegate=self
    }
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        if isFirstOpen
        {
            isFirstOpen=false
            closeMenu(animated: false)
        }
        
    }
   
    
    required init?(coder aDecoder: NSCoder)
    {
        assert(false,"Use init(leftVC,MainVC,OverLap) for this side bar instead")
        super.init(coder: aDecoder)!
    }
    
    init(leftViewController:UIViewController,
         mainViewController:UIViewController,
         overLap:CGFloat)
    {
       
        self.leftViewController = leftViewController
        self.mainViewController = mainViewController
        self.overLap = overLap
        
        super.init(nibName: nil, bundle: nil)
        
        
        self.view.backgroundColor = UIColor.white
        setupScrollView()
        setupViewController()
        
       
        productTabeleVC.delegate=self
        
        
    }
    
    func setupScrollView()
    {
     scrollView = UIScrollView()
     scrollView.translatesAutoresizingMaskIntoConstraints = false
     scrollView.bounces = false
     scrollView.isPagingEnabled = true
     scrollView.showsHorizontalScrollIndicator = false
        
        
     view.addSubview(scrollView)
     
        // add autolayout constraints for our scrollview
        let horizontalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: ["scrollView":scrollView])
        
        let verticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: nil, views: ["scrollView":scrollView])
        
        NSLayoutConstraint.activate(horizontalConstraint+verticalConstraint)
    }
    
    func setupViewController()
    {
        addViewController(uiViewController: leftViewController)
        addViewController(uiViewController: mainViewController)
        
        //apply autolayout to leftVC and mainVC's Views
        let views:[String:UIView] =
            [
            "left": leftViewController.view,
            "main": mainViewController.view,
            "outer":view
            ]
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "|[left][main(==outer)]|",
            options: [.alignAllTop,.alignAllBottom],
            metrics: nil,
            views: views)
        let leftWidthConstraints = NSLayoutConstraint.init(
            item: leftViewController.view,
            attribute: .width,
            relatedBy: .equal,
            toItem: view,
            attribute: .width,
            multiplier: 1.0,
            constant: -overLap)
        let verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|[main(==outer)]|",
            options: [],
            metrics: nil,
            views: views)
        mainViewController.view.addShadow()
        NSLayoutConstraint.activate(horizontalConstraints+verticalConstraints+[leftWidthConstraints])
    }
    
    func closeMenu(animated:Bool)
    {
        scrollView.setContentOffset(CGPoint(x:leftViewController.view.frame.width,y:0), animated: animated)
    }
    
    
    private func addViewController(uiViewController:UIViewController)
    {
        uiViewController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(uiViewController.view)
        addChildViewController(uiViewController)
        uiViewController.didMove(toParentViewController: self)
    }
    
    func openLeftMenu(animated:Bool)
    {
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: animated)
    }
    
    func isLeftOpen()->Bool
    {
       return scrollView.contentOffset.x==0
    }
    
    func toggleLeftMenu(animated:Bool)
    {
        if isLeftOpen()
        {
            closeMenu(animated: animated)
        }
        else
        {
            openLeftMenu(animated: animated)
        }
    }
    
    
}
private extension UIView
{
    func addShadow()
    {
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shadowRadius = 2.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.7
        layer.shadowColor=UIColor.black.cgColor
    }
}
extension SidebarViewController:toggleForLeftSide
{
    func toggleLeftSide(productsTVC:ProductsTableViewController)
    {
        toggleLeftMenu(animated: true)
        print("Here")
    }
}











