//
//  CameraViewController.swift
//  Instagram
//
//  Created by Pat Khai on 9/21/18.
//  Copyright © 2018 Pat Khai. All rights reserved.
//

import UIKit
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{



    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var photoImage: UIImageView!
    
    var postImage: UIImage! = nil
    
    //share and upload photo to the main view

    @IBAction func sharePost(_ sender: Any) {
      
        let image = photoImage.image!
        let caption = messageField.text!
        Post.postUserImage(image: image, withCaption: caption) { (success: Bool, error: Error?) in
            if success {
                self.performSegue(withIdentifier: "share", sender: nil)
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
            
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
            // Get the image captured by the UIImagePickerController
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            let resizedImage = resize(image: originalImage, newSize: CGSize(width: 300, height: 300))
            self.dismiss(animated: true, completion: nil)
            
            photoImage.contentMode = .scaleToFill
            photoImage.image = resizedImage
            camera.isEnabled = true
            
            shareButton.isEnabled = true
        
    }
    
    private func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        messageField.delegate = self
        messageField.returnKeyType = .done
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cameraLibrary(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
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

}
