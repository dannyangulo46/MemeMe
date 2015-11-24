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
        
        imageView.image = memeSelected.memedImage
        navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "onRightBarButtonTap"), animated:true)

    }
    
    
    override func viewWillDisappear(animated: Bool) {
        //Pop current view
        navigationController!.popViewControllerAnimated(false)
    }
    
    func onRightBarButtonTap() {
        
                
        //Present Edito View Controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        
        editMeme.originalImage = memeSelected.originalImage
        editMeme.textTop = memeSelected.topText!
        editMeme.textBottom = memeSelected.bottomText!
        
        presentViewController(editMeme, animated: true, completion: nil)
        
    }


    
    
}
