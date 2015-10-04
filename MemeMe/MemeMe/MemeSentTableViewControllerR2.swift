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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func viewWillAppear(animated: Bool) {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        self.memes = appDelegate.memes
        self.tableView!.reloadData()
        self.tabBarController?.tabBar.hidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
       
          }
    
  
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
       
        
        cell.imageView!.image = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row].memedImage
        
        cell.imageView!.contentMode = .ScaleAspectFill
        
        var phrase = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row].topText
        
        phrase = phrase! + "..." + (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row].bottomText!
        
        
        cell.textLabel?.text = phrase
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeMeDetailViewController")! as! MemeMeDetailViewController
        
        detailController.memeSelected = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
        
        self.tabBarController?.tabBar.hidden = true
        
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle==UITableViewCellEditingStyle.Delete
        {
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.removeAtIndex(indexPath.row)
            self.memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    
    @IBAction func addMemedImage(sender: UIBarButtonItem) {
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(editMeme, animated: true, completion: nil)
        
    }

}
