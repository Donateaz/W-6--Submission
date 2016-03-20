//
//  HomeViewController.swift
//  Instagram
//
//  Created by Donatea Zefi on 3/19/16.
//  Copyright © 2016 Donatea Zefi. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import MBProgressHUD

class HomeViewController: UIViewController, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var tableView: UITableView!
    var posts: [PFObject]?
    var then: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
        
        let logoImage = UIImage(named: "Logo-Instagram-Transparent-Bordered")!
        let imageView = UIImageView(image: logoImage);
        imageView.frame.size.height = (navigationController?.navigationBar.frame.size.height)! - 10;
        imageView.contentMode = .ScaleAspectFit;
        navigationItem.titleView = imageView;

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchData(){
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        // fetch data asynchronously
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts {
                // do something with fetched data
                self.posts = posts
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.tableView.reloadData()
                print(posts)
                //print(post)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    
    @IBAction func onPost(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // do something with the images
        picker.dismissViewControllerAnimated(true, completion: nil)
        let postPhotoNavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("PostPhotoViewController") as! PostPhotoViewController
        postPhotoNavigationController.pickedImage = originalImage
        self.navigationController!.pushViewController(postPhotoNavigationController, animated: true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if posts != nil {
            return posts!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostedImageCell
        let photo = posts![indexPath.row]
        cell.imagePost = posts![indexPath.row]
        then = photo.createdAt!
        let timeSince = timePassed(then!)
        if timeSince >= 86400 {
            cell.timePostedLabel.text = "\(Int(timeSince)/86400)d"
        } else if timeSince >= 3600 {
            cell.timePostedLabel.text = "\(Int(timeSince)/3600)h"
        } else if timeSince >= 60 {
            cell.timePostedLabel.text = "\(Int(timeSince)/60)m"
        } else {
            cell.timePostedLabel.text = "\(Int(timeSince))s"
        }
        cell.selectionStyle = .None
        return cell
    }
    
    func timePassed(then: NSDate) -> NSTimeInterval {
        let now = NSDate()
        let timePassed = now.timeIntervalSinceDate(then)
        return timePassed
    }

    @IBAction func onLogout(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logoutSegue", sender: nil)
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
