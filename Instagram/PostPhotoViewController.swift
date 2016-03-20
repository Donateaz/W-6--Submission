//
//  PostPhotoViewController.swift
//  Instagram
//
//  Created by Donatea Zefi on 3/20/16.
//  Copyright © 2016 Donatea Zefi. All rights reserved.
//

import UIKit
import MBProgressHUD

class PostPhotoViewController: UIViewController {

    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var imageToPost: UIImageView!
    var pickedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    imageToPost.image = pickedImage
    
    let post = UIBarButtonItem(title: "post!", style: .Plain, target: self, action: Selector("onPost:"))
    self.navigationItem.rightBarButtonItem = post
    
}

override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
}

func onPost(sender: AnyObject){
    print("about to post!")
    MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    Post.postUserImage(imageToPost.image, withCaption: captionTextView.text) { (success: Bool, error: NSError?) -> Void in
        if success {
            print("photo posted!")
            self.performSegueWithIdentifier("backToFeed", sender: nil)
        } else {
            print(error?.localizedDescription)
        }
    }
}

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/

}
