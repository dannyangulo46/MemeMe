//
//  MemeSentTableViewControllerR2.swift
//  MemeMe
//
//  Created by Lloyd Angulo on 8/16/15.
//  Copyright (c) 2015 BajaCalApps. All rights reserved.
//

import UIKit

class MemeSentTableViewControllerR2: UITableViewController {
    
    var memes = [Meme]()  //Ask the question on what is the difference between that and using memes: [Meme]!
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        tableView!.reloadData()
        tabBarController?.tabBar.hidden = false
    }
    
        
  
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) //as! UITableViewCell
        
       
        
        cell.imageView!.image = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row].memedImage
        
        cell.imageView!.contentMode = .ScaleAspectFill
        
        var phrase = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row].topText
        
        phrase = phrase! + "..." + (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row].bottomText!
        
        
        cell.textLabel?.text = phrase
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeMeDetailViewController") as!MemeMeDetailViewController
        
        detailController.memeSelected = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
        
            tabBarController?.tabBar.hidden = true
        
            navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle==UITableViewCellEditingStyle.Delete
        {
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.removeAtIndex(indexPath.row)
            memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    
    @IBAction func addMemedImage(sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
            presentViewController(editMeme, animated: true, completion: nil)
        
    }

}
