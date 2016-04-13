//
//  PhotoViewController.swift
//  Photos
//
//  Created by Calvin Yau on 4/13/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var likeNum: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var likeIcon: UIButton!
    
    var currentPhoto : Photo!
    
    override func viewDidLoad() {
        let photoDate = NSDate(timeIntervalSince1970: Double(currentPhoto.date)!)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.stringFromDate(photoDate)
        
        imageView.image = currentPhoto.image
        likeIcon.addTarget(self, action: "toggleLike", forControlEvents:.TouchUpInside)
        username.text = "Username: " + currentPhoto.username
        date.text = "Posted: " + dateString
        likeNum.text = "Likes: " + String(currentPhoto.likes)
        likeIcon.frame = CGRectMake(0, 0, 10, 10)
        
        if (currentPhoto.hasBeenLiked == true) {
            likeIcon.setImage(UIImage(named: "red-heart-like"), forState: .Normal)
        } else {
            likeIcon.setImage(UIImage(named: "empty_heart_like"), forState: .Normal)
        }
        
    }
    
    func toggleLike() {
        if (currentPhoto.hasBeenLiked == true) {
            currentPhoto.hasBeenLiked = false
            likeIcon.setImage(UIImage(named: "empty_heart_like"), forState: .Normal)
            currentPhoto.likes = currentPhoto.likes - 1
            likeNum.text = "Likes: " + String(currentPhoto.likes)
        } else {
            currentPhoto.hasBeenLiked = true
            likeIcon.setImage(UIImage(named: "red-heart-like"), forState: .Normal)
            currentPhoto.likes = currentPhoto.likes + 1
            likeNum.text = "Likes: " + String(currentPhoto.likes)
            
        }
    }
}