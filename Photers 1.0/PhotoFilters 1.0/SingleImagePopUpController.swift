//
//  SingleImagePopUpController.swift
//  Photers
//
//  Created by Akash Bhandari on 5/18/16.
//  Copyright © 2016 Akash Bhandari. All rights reserved.
//

import UIKit
import AssetsLibrary
import Social

class SingleImagePopUpController: UIViewController {
    
    var filteredImage: UIImage?
    
    @IBOutlet weak var imgDisplay: UIImageView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        if let image = filteredImage{
            imgDisplay.image = image
        }
    }
    
    
    
    //Dismissing the popup window
    @IBAction func cancelBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Saving the photos in the iphone's photo library
    @IBAction func saveBtn(sender: AnyObject) {
        if let image = imgDisplay.image{
            
            let imageSaving: CIImage = CIImage(image: image)!
            let softwareContext = CIContext(options: [kCIContextUseSoftwareRenderer: true])
            let cgimg = softwareContext.createCGImage(imageSaving, fromRect: imageSaving.extent)
            let library = ALAssetsLibrary()
            library.writeImageToSavedPhotosAlbum(cgimg,
                                                          metadata:imageSaving.properties,
                                                          completionBlock:nil)
            //Showing alert to the user that the task has been saved
            let alert = UIAlertController(title: "Success", message: "Photo saved successfully!", preferredStyle: .Alert)
            let button = UIAlertAction(title: "Ok", style: .Default) {
                (_) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            alert.addAction(button)
            presentViewController(alert, animated: true, completion: nil)
        }
        
        
    }
    
    //Sharing on facebook and twitter
    
    //Facebook
    @IBAction func shareToFacebook(sender: AnyObject) {
        let sharingToFacebook: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        sharingToFacebook.setInitialText("My photo is cool")
        sharingToFacebook.addImage(filteredImage)
        
        self.presentViewController(sharingToFacebook, animated: true, completion: nil)
    }
    //Twitter
    @IBAction func shareToTwitter(sender: AnyObject) {
        let sharingToTwitter: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        sharingToTwitter.setInitialText("My Photo is cool")
        sharingToTwitter.addImage(filteredImage)
        
        self.presentViewController(sharingToTwitter, animated: true, completion: nil)
        
    }
    
    
    
    

}
