//
//  Meme.swift
//  MemeMe
//
//  Created by Lloyd Angulo on 5/30/15.
//  Copyright (c) 2015 BajaCalApps. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    let topText:String?
    let bottomText: String?
    let originalImage: UIImage?
    let memedImage: UIImage?
    
    
    // Per Udacity's team feedback, I changed the Meme from a class to a struct. In addition, I was supposed to delete the init but if I do that I am not sure how I would pass the values.
    
    init(topText: String, bottomText:String, originalImage: UIImage, memedImage: UIImage) {
        
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
        
    }
}
