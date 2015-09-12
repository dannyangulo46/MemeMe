//
//  Meme.swift
//  MemeMe
//
//  Created by Lloyd Angulo on 5/30/15.
//  Copyright (c) 2015 BajaCalApps. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject {
    
    let topText:String?
    let bottomText: String?
    let originalImage: UIImage?
    let memedImage: UIImage?
    
    init(topText: String, bottomText:String, originalImage: UIImage, memedImage: UIImage) {
        //super.init()
        
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
        
        
    }
}
