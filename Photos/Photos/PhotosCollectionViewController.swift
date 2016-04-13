//
//  PhotosCollectionViewController.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    var photos: [Photo]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photos = []

        let api = InstagramAPI()
        api.loadPhotos(didLoadPhotos)
        // FILL ME IN
    }

    /* 
     * IMPLEMENT ANY COLLECTION VIEW DELEGATE METHODS YOU FIND NECESSARY
     * Examples include cellForItemAtIndexPath, numberOfSections, etc.
     */
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath : NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
    
        let imageView = UIImageView(frame: CGRectMake(0, 0, 175, 175));
        loadImageForCell(photos[indexPath.row], imageView: imageView)
        cell.addSubview(imageView)
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
            performSegueWithIdentifier("viewPhotoSegue", sender: indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 175, height: 175)
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewPhotoSegue" {
            let photoViewController = segue.destinationViewController as! PhotoViewController
            let indexPath = sender as! NSIndexPath
            photoViewController.currentPhoto = photos[indexPath.row]
        }
    }
    
    /* Creates a session from a photo's url to download data to instantiate a UIImage. 
       It then sets this as the imageView's image. */
    func loadImageForCell(photo: Photo, imageView: UIImageView) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: NSURL(string: photo.url)!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            dispatch_async(dispatch_get_main_queue(), {
                let image = UIImage(data : data!)
                photo.image = image
                imageView.image = image
            });
        }
    }
    
    /* Completion handler for API call. DO NOT CHANGE */
    func didLoadPhotos(photos: [Photo]) {
        self.photos = photos
        self.collectionView!.reloadData()
    }
    
}

