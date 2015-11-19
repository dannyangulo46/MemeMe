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
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    // Variables to be used when user is on DetailView and wants to edit the original image
    var originalImage : UIImage?
    var textTop:String?
    var textBottom:String?
    
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
        
        
        textFieldAttributes(textFieldTop)
        textFieldAttributes(textFieldBottom)
        
    }

    // Helper function to set attributes and alignment of text fields
    
    func textFieldAttributes(textField: UITextField) {
        
        textField.textAlignment = NSTextAlignment.Center
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraBarButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
        
        if let tempImage = originalImage {
            imagePickedView.image = tempImage
            textFieldTop.text = textTop!
            textFieldBottom.text = textBottom!
        
        }
        
        
        if imagePickedView.image != nil {
            shareButton.enabled = true
        } else {
            shareButton.enabled = false
            
        }
        
        
       
    }
    
    override func viewWillDisappear(animated: Bool) {
        unsubscribeFromKeyboardNotifications()
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    override func viewWillLayoutSubviews() {
       
        //Layout constraints for Top and Bottom text fields
        
        let verticalConstant:CGFloat = 0.15 * imagePickedView.bounds.size.height
        
        
        let verticalPositionTextFieldTop = NSLayoutConstraint(item: textFieldTop, attribute: .Top, relatedBy: .Equal, toItem: super.view, attribute: .Top, multiplier: 1, constant: verticalConstant)
        
        
        let verticalPositionTextFieldBottom = NSLayoutConstraint(item: textFieldBottom, attribute: .Bottom, relatedBy: .Equal, toItem: super.view, attribute: .Bottom, multiplier: 1, constant: -verticalConstant)
        
        
            view.addConstraint(verticalPositionTextFieldTop)
            view.addConstraint(verticalPositionTextFieldBottom)
        
    }
    
    
    
    // CORE FUNCTIONS

    
    @IBAction func dismissMyself(sender: UIBarButtonItem) {
    
        dismissViewControllerAnimated(true, completion: nil)
        
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
        
        
        activityVC.completionWithItemsHandler = { activity, completed, items, error -> Void in
            if completed {
                self.saveMeme()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
        }
        
                
    
    }

    // Methods to shift view up and down as keyboard appears or disappears
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillDisappear:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if textFieldBottom.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
    
        }
    }
    func keyboardWillDisappear(notification: NSNotification) {
     
        if !(self.view.frame.origin.y == 0) {
        
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }

    // Create the new image with the text
    
    func saveMeme() {
        
        
        
        let meme = Meme (topText: textFieldTop.text!, bottomText: textFieldBottom.text!, originalImage: self.imagePickedView.image!, memedImage: self.memedImage)
        
        
        //Add it to the memes Array on the Application delegate - this will be the shared model
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
        
    }
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar to memorialize picture with text
        
        
            navBar.hidden = true
            mainToolBar.hidden = true
        
        
        //Render view to an image
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        
        
        
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
       
        
        // Show toolbar and navbar
            mainToolBar.hidden = false
            navBar.hidden = false
        
        
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
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickedView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
  }

