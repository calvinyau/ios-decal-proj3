//
//  Photo.swift
//  Photos
//
//  Created by Gene Yoo on 11/3/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import Foundation
import UIKit

class Photo {
    /* The number of likes the photo has. */
    var likes : Int!
    /* The string of the url to the photo file. */
    var url : String!
    /* The username of the photographer. */
    var username : String!
    /* The photo's liked status */
    var hasBeenLiked : Bool!
    /* The date of the photo. */
    var date : String!
    /* The photo image */
    @IBOutlet var image: UIImage?

    /* Parses a NSDictionary and creates a photo object. */
    init (data: NSDictionary) {
        // FILL ME IN
        // HINT: use nested .valueForKey() calls, and then cast using 'as! TYPE'
        likes = (data.valueForKey("likes") as! NSDictionary).valueForKey("count") as! Int
        url = ((data.valueForKey("images") as! NSDictionary).valueForKey("low_resolution") as! NSDictionary).valueForKey("url") as! String
        username = (data.valueForKey("user") as! NSDictionary).valueForKey("username") as! String
        hasBeenLiked = false
        date = data.valueForKey("created_time") as! String
    }

}