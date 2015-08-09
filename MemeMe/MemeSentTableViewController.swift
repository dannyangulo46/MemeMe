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
    var memes = [Meme]()  //Ask the question on what is the difference between that and using memes: [Meme]!
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        self.memes = appDelegate.memes
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        // Note: Why doesn't this work when I use wiewWillAppear instead of viewDidAppear?
        
        //if (UIApplication.sharedApplication().delegate as AppDelegate).memes.isEmpty {
        if !(self.memes.count > 0) {
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var editMeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as MemeEditorViewController
            self.presentViewController(editMeme, animated: true, completion: nil)
        
        }
        
    }
    
    // MARK: TableView Datasource and Delegate methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //Push the next story node.
      //  let nextStoryNode = storyNode.storyNodeForIndex(indexPath.row)
      //  let controller = self.storyboard!.instantiateViewControllerWithIdentifier("StoryNodeViewController") as //StoryNodeViewController
      //  controller.storyNode = nextStoryNode
        //self.navigationController!.pushViewController(controller, animated: true)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of prompts in the storyNode (The 2 is just a place holder)
        //return (UIApplication.sharedApplication().delegate as AppDelegate).memes.count
    
        return self.memes.count
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
