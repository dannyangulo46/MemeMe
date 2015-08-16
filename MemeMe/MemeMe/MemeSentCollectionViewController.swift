//
//  MemeSentCollectionViewController.swift
//  MemeMe
//
//  Created by Lloyd Angulo on 8/10/15.
//  Copyright (c) 2015 BajaCalApps. All rights reserved.
//

import UIKit

//let reuseIdentifier = "Cell"

class MemeSentCollectionViewController: UICollectionViewController {

    var memes = [Meme]()  //Ask the question on what is the difference between that and using memes: [Meme]!
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        self.memes = appDelegate.memes
    }
    

   // override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
    //    return 0
   // }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return self.memes.count

    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as MemedCollectionViewCell
        
        let meme = memes[indexPath.item]
        
        cell.imageView.image = meme.memedImage
        
       //cell?.imageView.image = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.item].memedImage
        
        
        return cell
    }

    @IBAction func addMemedImage(sender: UIBarButtonItem) {
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as MemeEditorViewController
        self.presentViewController(editMeme, animated: true, completion: nil)

        
    }
    
}
