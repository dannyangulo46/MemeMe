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
    }
    
    override func viewDidAppear(animated: Bool) {
       
        // Note: Why doesn't this work when I use wiewWillAppear instead of viewDidAppear?
        
        //if (UIApplication.sharedApplication().delegate as AppDelegate).memes.isEmpty {
        if !(self.memes.count > 0) {
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
            self.presentViewController(editMeme, animated: true, completion: nil)
            
        }
    }
    
    // MARK: - Table view data source

/*    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }
*/
  
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        cell.imageView!.image = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row].memedImage
        
        var phrase = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row].topText
        
        phrase = phrase! + "..." + (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row].bottomText!
        
        
        cell.textLabel?.text = phrase
        
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeMeDetailViewController")! as! MemeMeDetailViewController
        
        detailController.image = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row].memedImage
        
        self.navigationController!.pushViewController(detailController, animated: true)
    
    }
    
    
    @IBAction func addMemedImage(sender: UIBarButtonItem) {
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        self.presentViewController(editMeme, animated: true, completion: nil)
        
    }

}
