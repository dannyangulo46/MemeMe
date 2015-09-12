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
  
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space))/3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
        
    }

    override func viewWillAppear(animated: Bool) {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        self.memes = appDelegate.memes
        
        self.collectionView!.reloadData()
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
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! MemedCollectionViewCell
        
        let meme = memes[indexPath.item]
        
        cell.imageView.image = meme.memedImage
        
       //cell?.imageView.image = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.item].memedImage
        
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeMeDetailViewController")! as! MemeMeDetailViewController
        
        detailController.image = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.item].memedImage
        
        self.navigationController!.pushViewController(detailController, animated: true)

        
        
    }
    

    @IBAction func addMemedImage(sender: UIBarButtonItem) {
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(editMeme, animated: true, completion: nil)

        
    }
    
}
