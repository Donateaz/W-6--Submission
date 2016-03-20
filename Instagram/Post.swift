//
//  Post.swift
//  Instagram
//
//  Created by Donatea Zefi on 3/19/16.
//  Copyright © 2016 Donatea Zefi. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    // add a user post to parse
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        
        // create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // add relevant fields to object
        post["media"] = getPFFileFromImage(image)
        post["author"] = PFUser.currentUser()
        post["caption"] = caption
        post["likesCount"] = 0
        post["commentsCount"] = 0
        
        // save object (in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
}
