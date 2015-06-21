//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Lloyd Angulo on 5/24/15.
//  Copyright (c) 2015 BajaCalApps. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    //VARIABLES
    
    var memedImage : UIImage!
    
    
    // OUTLETS
    
    
    @IBOutlet weak var imagePickedView: UIImageView!
    
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    
    @IBOutlet weak var textFieldTop: UITextField!
    
    @IBOutlet weak var textFieldBottom: UITextField!
    
    @IBOutlet weak var mainToolBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    // VIEW CONTROLLER LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldTop.delegate = self
        textFieldBottom.delegate = self
        textFieldTop.clearsOnBeginEditing = true
        textFieldBottom.clearsOnBeginEditing = true

        let memeTextAttributes = [NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: NSNumber(float: -3.0)]
        
        textFieldTop.defaultTextAttributes = memeTextAttributes
        textFieldBottom.defaultTextAttributes = memeTextAttributes
        textFieldTop.textAlignment = NSTextAlignment.Center
        textFieldBottom.textAlignment = NSTextAlignment.Center
        
        
    }

    override func viewWillAppear(animated: Bool) {
        cameraBarButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subscribeToKeyboardNotifications()
        
        if imagePickedView.image != nil {
            shareButton.enabled = true
        } else {
            shareButton.enabled = false
            
        }
        

    }
    
    override func viewWillDisappear(animated: Bool) {
        self.unsubscribeFromKeyboardNotifications()

    }
    
    // CORE FUNCTIONS

    
    @IBAction func dismissMyself(sender: UIBarButtonItem) {
    
    self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func pickAnImage(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func launchActivityViewController(sender: UIBarButtonItem) {
        
        self.memedImage = generateMemedImage()
        
        let objectToShare = [memedImage]
        
        let activityVC = UIActivityViewController(activityItems: objectToShare, applicationActivities: nil)
        
        
        
        self.presentViewController(activityVC, animated: true, completion: nil)
        
        
        
        activityVC.completionWithItemsHandler = { (activity: String!, completed: Bool, items: [AnyObject]!, error: NSError!) -> Void in
            if completed {
                self.saveMeme()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        
    
    }

    // Methods to shift view up and down as keyboard appears or disappears
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillDisappear:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillDisappear(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
        
    }
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue
        return keyboardSize.CGRectValue().height
    }

    // Create the new image with the text
    
    func saveMeme() {
        
        //var memedImage = generateMemedImage()
        
        var meme = Meme(topText: textFieldTop.text, bottomText: textFieldBottom.text, originalImage: imagePickedView.image!, memedImage: self.memedImage)
        
        //Add it to the memes Array on the Application delegate - this will be the shared model
        (UIApplication.sharedApplication().delegate as AppDelegate).memes.append(meme)
        
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar 
        
        self.navigationController?.setToolbarHidden(true, animated: true)
        self.mainToolBar.hidden = true
        
        
        //Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
       
        // Unhide toolbar and navbar
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.mainToolBar.hidden = false
        
        
        
        return memedImage
    }
    
    
    
    
    // UITEXTFIELDS DELEGATE METHODS
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        textField.clearsOnBeginEditing = false
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }

    
    // UIIMAGEPICKERCONTROLLER DELEGATE METHODS
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickedView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
  }

