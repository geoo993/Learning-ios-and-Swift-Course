//
//  ImageCropperViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 12/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.youtube.com/watch?v=hz9pMw4Y2Lk
//https://stackoverflow.com/questions/41717115/how-to-uiimagepickercontroller-for-camera-and-photo-library-in-the-same-time-in
//https://makeapppie.com/2016/06/28/how-to-use-uiimagepickercontroller-for-a-camera-and-photo-library-in-swift-3-0/
//https://stackoverflow.com/questions/39520499/class-plbuildversion-is-implemented-in-both-frameworks

//https://stackoverflow.com/questions/41972578/how-to-implement-xcode-swift3-uiscrollview-image-zooming


import UIKit

class ImageCropperViewController: UIViewController {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func cropsaveButtonClicked(_ sender: UIButton) {
        
        if scrollView.subviews.count > 0 {
            
            let scrollViewSize = scrollView.bounds.size
            let scrollViewOffset = scrollView.contentOffset
            let image = scrollView.snapShotImage(withSize:scrollViewSize, opaque: true, offset: scrollViewOffset)
            
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            // we got back an error!
            let alert = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true, completion: nil)
        } else {
            
            let alert  = UIAlertController(title: "Image Save!", message: "Your image has been saved to your camera roll", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var imageView : UIImageView?
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.delegate = self
        imagePicker.delegate = self
        
        prepareImageView()
        
    }

    func prepareImageView(){
        
        if imageView == nil {
            let frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
            imageView = UIImageView(frame: frame)
            imageView?.image = UIImage(named: "imagesArchive")
            imageView?.isUserInteractionEnabled = true
            imageView?.contentMode = .scaleAspectFill
            imageView?.clipsToBounds = true
            scrollView.addSubview( imageView! )
            
            setGestureRecognizer()
        }
        
        
    }
    
    func setGestureRecognizer()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageTap(_:)))
        tap.numberOfTapsRequired = 1
        imageView?.addGestureRecognizer(tap)
    }
    
    @objc func handleImageTap(_ recognizer: UITapGestureRecognizer)
    {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func clearArea(){
        view.removeEverything()
        imageView = nil
    }
    
    
    deinit {
        clearArea()
        print("Image Cropper view controller is \(#function)")
    }

}

extension ImageCropperViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage 
        imageView?.image = image
        imageView?.contentMode = .center
        imageView?.frame = CGRect(origin: CGPoint.zero, size: image.size)
        
        scrollView.contentSize = image.size
        
        let scrollViewSize = scrollView.bounds.size
        let scaleWidth = scrollViewSize.width / image.size.width
        let scaleHeight = scrollViewSize.height / image.size.height
        let minScale = min(scaleWidth, scaleHeight)
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 1.0
        scrollView.zoomScale = minScale
    
        centerScrollViewContent()
        
        picker.dismiss(animated: true) { 
            print("picker is dismissed")
        }
    }
    
    func centerScrollViewContent(){
     
        let imageViewSize = imageView?.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = (imageViewSize?.height)! < scrollViewSize.height ? (scrollViewSize.height - (imageViewSize?.height)!) / 2 : 0
        let horizontalPadding = (imageViewSize?.width)! < scrollViewSize.width ? (scrollViewSize.width - (imageViewSize?.width)!) / 2 : 0
        
        imageView?.frame = CGRect(origin: CGPoint(x:horizontalPadding,y:verticalPadding) , size: (imageView?.frame.size)!)
        
        //scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    
    }
  
    
}
extension ImageCropperViewController: UIScrollViewDelegate {
    
    func scrollViewDidZoom(_ scrollView: UIScrollView)
    {
        centerScrollViewContent()
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    
}
extension ImageCropperViewController: UINavigationControllerDelegate {


}


