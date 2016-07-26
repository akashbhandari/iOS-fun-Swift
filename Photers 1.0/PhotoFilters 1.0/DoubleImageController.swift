 //
//  ViewController.swift
//  PhotoFilters 1.0
//
//  Created by Akash Bhandari on 4/4/16.
//  Copyright © 2016 Akash Bhandari. All rights reserved.
//

import UIKit
 import AssetsLibrary


class DoubleImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
/////////////////For Two photos////////////////
    
    
   
    @IBOutlet weak var lblNoImageSelected: UILabel!
    
    @IBOutlet weak var lblNoImageSelected2: UILabel!
    
    @IBOutlet weak var akashImageView: UIImageView!
    
    @IBOutlet weak var secondImageView: UIImageView!
    
    var originalImage: UIImage = UIImage()
    
    let imageContext = CIContext (options: nil)
    
    var count = 0
    let filterCollection = ["CITwirlDistortion", "CICircularScreen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Adding Swipe gesture for second image
        if let  originalImage = secondImageView.image{
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(DoubleImageViewController.leftSwipe(_:)))
        
            let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(DoubleImageViewController.rightSwipe))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        }
        
        //showing the label when an image is not there
        
        if akashImageView.image == nil{
            lblNoImageSelected.hidden = false
            akashImageView.hidden = true
        }
        
    }
    

    
    ///////////////Browsing and Picking Images for first and second image
    
    
    
    @IBAction func browseBtn(sender: AnyObject) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
     //   if browseBtn()==true{
            
            akashImageView.image = info [UIImagePickerControllerOriginalImage] as? UIImage
       // } else if {
       //     secondImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    
 
        //hiding the label when the image is selected
        
        lblNoImageSelected.hidden = true
        akashImageView.hidden = false
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    //Saving the photos in the iphone's photo library
    @IBAction func saveBtn(sender: AnyObject) {
        if let image = akashImageView.image{
            
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


    
    ///Press function for the first image
    
    @IBAction func myBtn(sender: AnyObject) {
        
        // Creating image to filter
        if let image = akashImageView.image {
            
           let inputImage = CIImage(image: image)
            
            // Creating random color for filter
            let randomColor = [kCIInputAngleKey: (Double (arc4random_uniform(200))/100)]
            //let anotherColor
            
            //Applying filter to image
            if let filteredImage = inputImage?.imageByApplyingFilter("CIHueAdjust", withInputParameters: randomColor) {
                let finalImage = imageContext.createCGImage(filteredImage, fromRect: filteredImage.extent)
                akashImageView.image = UIImage (CGImage: finalImage)
            }
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /////////////////// Browsing the second image
    
    @IBAction func browse2Btn(sender: AnyObject) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
        

     func imagePickerController1(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        secondImageView.image = info [UIImagePickerControllerOriginalImage] as? UIImage
        
        //hiding the label when the image is selected
        
        lblNoImageSelected2.hidden = true
        secondImageView.hidden = false
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
   

    ///////////////Swipe Gestures func for second image
    
    
    func leftSwipe(sender: UISwipeGestureRecognizer){
        
        if count == filterCollection.count {
            return
        }
        
        
        let inputImage = originalImage
        let context = CIContext(options: nil)
        
        if let currentFilter = CIFilter(name: filterCollection[count]) {
            let beginImage = CIImage(image: inputImage)
            
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            //currentFilter.setValue(0.8, forKey: kCIInputIntensityKey)
            //currentFilter.setValue(2, forKey: kCIInputRadiusKey)
            
            
            if let output = currentFilter.outputImage {
                let cgimg = context.createCGImage(output, fromRect: output.extent)
                let processedImage = UIImage(CGImage: cgimg)
                secondImageView.image = processedImage
                // do something interesting with the processed image
            }
        }
        
        if count < filterCollection.count {
            count = count + 1
        }
        
        //count = (count < filterCollection.count) ? count + 1 : count
        print (count)
    }
    
    
    func rightSwipe(sender: UISwipeGestureRecognizer){
        
        if count != 0 {
            count = count - 1
        }
        else if count == 0 {
            secondImageView.image = originalImage
            return
        }
        let inputImage = originalImage
        let context = CIContext(options: nil)
        
        if let currentFilter = CIFilter(name: filterCollection[count]) {
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            //currentFilter.setValue(0.5, forKey: kCIInputIntensityKey)
            
            if let output = currentFilter.outputImage {
                let cgimg = context.createCGImage(output, fromRect: output.extent)
                let processedImage = UIImage(CGImage: cgimg)
                secondImageView.image = processedImage
                // do something interesting with the processed image
            }
        }
       
    }
}

