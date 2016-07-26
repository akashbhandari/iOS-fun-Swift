//
//  SingleImageController.swift
//  Photers
//
//  Created by Akash Bhandari on 4/18/16.
//  Copyright © 2016 Akash Bhandari. All rights reserved.
//

import UIKit

class SingleImageController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var filterLabels = [String]()
    var context: CIContext!
    var currentFilter: CIFilter!
    var currentIntensity: Float = 1
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var lblNoImageSelected: UILabel!
    @IBOutlet weak var intensitySlider: UISlider!
    
    var currentImage: UIImage?
    var scaledDownImage: UIImage?
    var tempImage: UIImage?
    
    // MARK: Viewdidload
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadFilterLabels()
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.userInteractionEnabled = true
        filterCollectionView.reloadData()
        
        //showing the no image text & hiding the filterview
        
        if imageDisplay.image == nil{
            lblNoImageSelected.hidden = false
            imageDisplay.hidden = true
            filterCollectionView.hidden = true
            intensitySlider.hidden = true
            navigationItem.rightBarButtonItem?.enabled = false
        }
        
        //Initialize context using GPU as renderer.
        
        context = CIContext(EAGLContext: EAGLContext(API: EAGLRenderingAPI.OpenGLES2), options: [kCIContextWorkingColorSpace: NSNull()])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        filterCollectionView.reloadData()
  
    }
    
    ///////////////Browsing and Picking Images
    
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var btnUpload: UIBarButtonItem!
    
    
    @IBAction func browseBtn(sender: AnyObject) {
        let photoPicker = UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.sourceType = .PhotoLibrary
        self.presentViewController(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        currentImage = info [UIImagePickerControllerOriginalImage] as? UIImage
        scaledDownImage = resizeImage(currentImage!, targetSize: CGSize(width: 343 * 1.50, height: 352 * 1.50))
        imageDisplay.image = scaledDownImage
        
       
//        let beginImage = CIImage(image: currentImage!)
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        applyProcessing()
        
        
        ///Hiding the collection view in the beginning
        
        lblNoImageSelected.hidden = true
        imageDisplay.hidden = false
        filterCollectionView.hidden = false
        self.navigationItem.rightBarButtonItem!.enabled = true    //enabling upload button
        self.dismissViewControllerAnimated(false, completion: nil)
        //spinner.startAnimating()
    }
    
    @IBAction func intensitySlider(sender: UISlider) {
        currentIntensity = sender.value
        applyProcessing()
    }
    
    
    func applyProcessing(){
        
        // Store all the keys that the current filter supports
        let filterKeys = currentFilter.inputKeys
        
        
        if filterKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(currentIntensity, forKey: kCIInputIntensityKey)
        }
        
        if filterKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(currentIntensity * 200, forKey: kCIInputRadiusKey)
        }
        
        if filterKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(currentIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        if filterKeys.contains(kCIInputCenterKey) {
            currentFilter.setValue(CIVector(x: scaledDownImage!.size.width / 2, y: scaledDownImage!.size.height / 2), forKey: kCIInputCenterKey)
        }
        

        let cgimg = context.createCGImage(currentFilter.outputImage!, fromRect: currentFilter.outputImage!.extent)
        let processedImage = UIImage(CGImage: cgimg)
        imageDisplay.image = processedImage
    }
    
    //////Collectionview for the filter
 
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    func loadFilterLabels(){
        filterLabels = ["Sepia", "Vignette",
                        "Chrome", "Pixelate", "Mono", "Bump distortion", "Process", "Noir", "Transfer", "Fade"]
    }
    
 
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterLabels.count
    }
    
    
    //////////Changing the filter
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        intensitySlider.hidden = false
        
        let currentSelectedFilter = filterLabels[indexPath.row]

        switch currentSelectedFilter{
            
            case "Sepia":
                setFilterWithName("CISepiaTone")
                applyProcessing()
                intensitySlider.enabled = true
            case "Bump distortion":
                setFilterWithName("CIBumpDistortion")
                applyProcessing()
                intensitySlider.enabled = true
            case "Pixelate":
                setFilterWithName("CIPixellate")
                applyProcessing()
                intensitySlider.enabled = true
            case "Vignette":
                setFilterWithName("CIVignette")
                applyProcessing()
                intensitySlider.enabled = true
            case "Chrome":
                setFilterWithName("CIPhotoEffectInstant")
                applyProcessing()
                intensitySlider.enabled = false
            case "Mono":
                setFilterWithName("CIPhotoEffectMono")
                applyProcessing()
                intensitySlider.enabled = false
            case "Process":
                setFilterWithName("CIPhotoEffectProcess")
                applyProcessing()
                intensitySlider.enabled = false
            case "Noir":
                setFilterWithName("CIPhotoEffectNoir")
                applyProcessing()
                intensitySlider.enabled = false
            case "Transfer":
                setFilterWithName("CIPhotoEffectTransfer")
                applyProcessing()
                intensitySlider.enabled = false
            case "Fade":
                setFilterWithName("CIPhotoEffectFade")
                applyProcessing()
                intensitySlider.enabled = false
            
            
            
            default: break
        }
    }
    
    func setFilterWithName(filterName: String){
        currentFilter = CIFilter(name: filterName)
        if let image = scaledDownImage{
            let beginImage = CIImage(image: image)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
        }
    }
   //////////Updating the cell
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier: String = "filterCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        cell.lblFilterName.text = filterLabels[indexPath.row]
        
        //Making the cell image as the image display
        if let mainImage = currentImage{
            cell.imgFilterCell.image = mainImage
        }
        return cell
    }
    
    
    //////Linking the single view controller and the pop up
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier{
            switch identifier{
                case "showSave":
                    if let saveVC = segue.destinationViewController as? SingleImagePopUpController{
                        saveVC.filteredImage = imageDisplay.image
                }
            default: break
            }
        }
        
    }
   
   
   /////For the instagram effect, touching the image would change the image to the default image
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        if let touch = touches.first{
            if (touch.view == imageDisplay){
                if let image = currentImage {
                    tempImage = imageDisplay.image
                    imageDisplay.image = image
                }
            }
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        if let touch = touches.first{
            if (touch.view == imageDisplay){
                if let image = tempImage {
                    imageDisplay.image = image
                }
            }
        }
    }
    
    
    /// Function to resize the resolution of image to perform real time image editing
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
}










