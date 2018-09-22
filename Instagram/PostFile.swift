//
//  Post.swift
//  Instagram
//
//  Created by Pat Khai on 9/22/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import Parse

class PostFile: PFObject, PFSubclassing{
    @NSManaged var media: PFFile
    @NSManaged var authorUsername: String
    @NSManaged var caption: String
    @NSManaged var likesCount: Int
    @NSManaged var commentsCount: Int
    @NSManaged var date: String
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    /**
     * Other methods
     */
    
    /**
     Method to add a user post to Parse (uploading image file)
     
     - parameter image: Image that the user wants upload to parse
     - parameter caption: Caption text input by the user
     - parameter completion: Block to be executed after save operation is complete
     */
    class func postUserImage(image: UIImage?, withCaption caption: String, withCompletion completion: PFBooleanResultBlock?) {
        // use subclass approach
        let post = PostFile()
        
        post.media = getPFFileFromImage(image)!
        post.authorUsername = PFUser.current()!.username!
        
        post.caption = caption
        post.likesCount = 0
        post.commentsCount = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        dateFormatter.locale = Locale(identifier: "en_US")
        post.date = dateFormatter.string(from: Date())
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
        
    }
    
    /**
     Method to convert UIImage to PFFile
     
     - parameter image: Image that the user wants to upload to parse
     
     - returns: PFFile for the the data in the image
     */
    class func getPFFileFromImage(_ image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "upload_image.png", data: imageData)
            }
        }
        return nil
    }
        
        
        
    

}
