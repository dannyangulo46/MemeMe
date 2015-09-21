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
    
    var memeSelected: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.imageView.image = memeSelected.memedImage
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "onRightBarButtonTap"), animated:true)

    }
    
    
    override func viewWillDisappear(animated: Bool) {
        //Pop current view
        self.navigationController!.popViewControllerAnimated(false)
    }
    
    func onRightBarButtonTap() {
        
                
        //Present Edito View Controller
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        //editMeme.imagePickedView.image = memeSelected.originalImage
        
        self.presentViewController(editMeme, animated: true, completion: nil)
        
    }


    
    
}
