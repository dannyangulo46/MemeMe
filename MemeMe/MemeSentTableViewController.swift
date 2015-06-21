//
//  MemeSentTableViewController.swift
//  MemeMe
//
//  Created by Lloyd Angulo on 6/16/15.
//  Copyright (c) 2015 BajaCalApps. All rights reserved.
//

import UIKit

class MemeSentTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Note: Why doesn't this work when I use wiewWillAppear instead of viewDidAppear?
        
        if (UIApplication.sharedApplication().delegate as AppDelegate).memes.isEmpty {
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as MemeEditorViewController
            self.presentViewController(editMeme, animated: true, completion: nil)
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Push the next story node.
      //  let nextStoryNode = storyNode.storyNodeForIndex(indexPath.row)
      //  let controller = self.storyboard!.instantiateViewControllerWithIdentifier("StoryNodeViewController") as //StoryNodeViewController
      //  controller.storyNode = nextStoryNode
        //self.navigationController!.pushViewController(controller, animated: true)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of prompts in the storyNode (The 2 is just a place holder)
        return (UIApplication.sharedApplication().delegate as AppDelegate).memes.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //Dequeue a cell and populate it with text from the correct prompt.
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        cell.imageView!.image = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.row].memedImage
        cell.textLabel?.text = (UIApplication.sharedApplication().delegate as AppDelegate).memes[indexPath.row].bottomText
        
        return cell
    }
    
    
    @IBAction func addMemedImage(sender: UIBarButtonItem) {
        
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as MemeEditorViewController
        self.presentViewController(editMeme, animated: true, completion: nil)
    }
    
    
    
}
