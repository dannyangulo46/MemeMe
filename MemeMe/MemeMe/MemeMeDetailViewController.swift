//
//  MemeMeDetailViewController.swift
//  MemeMe
//
//  Created by Lloyd Angulo on 9/10/15.
//  Copyright (c) 2015 BajaCalApps. All rights reserved.
//

import UIKit

class MemeMeDetailViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.imageView.image = image
        
        //self.navBar.hidden = true
        //self.mainToolBar.hidden = true

        //self.tabBarController?.hidesBottomBarWhenPushed
    }
    



}
