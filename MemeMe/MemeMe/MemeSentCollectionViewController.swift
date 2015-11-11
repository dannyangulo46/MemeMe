//
//  MemeSentCollectionViewController.swift
//  MemeMe
//
//  Created by Lloyd Angulo on 8/10/15.
//  Copyright (c) 2015 BajaCalApps. All rights reserved.
//

import UIKit



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
        memes = appDelegate.memes
        tabBarController?.tabBar.hidden = false
        collectionView!.reloadData()
    }
    


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count

    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as! MemedCollectionViewCell
        
        let meme = memes[indexPath.item]
        
        cell.imageView.image = meme.memedImage
        
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        // If item is selected, create a detailview controller, present it, and pass the picture to be presented.
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeMeDetailViewController")! as! MemeMeDetailViewController
        
        detailController.memeSelected = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.item]
        
        tabBarController?.tabBar.hidden = true
        
        navigationController!.pushViewController(detailController, animated: true)

        
        
    }
    

    @IBAction func addMemedImage(sender: UIBarButtonItem) {
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(editMeme, animated: true, completion: nil)

        
    }
    
}
