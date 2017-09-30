//
//  ShotViewController.swift
//  Populic
//
//  Created by Chengyu_Ovaltine on 9/25/17.
//  Copyright © 2017 Chengyu_Ovaltine. All rights reserved.
//

import UIKit
import MobileCoreServices

class ShotViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicker : UIImagePickerController!
    @IBOutlet weak var takenPhoto: UIImageView!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SendPhoto" {
            if let nextViewController = segue.destination as? SentPhotoViewController {
                nextViewController.takenPhoto = self.takenPhoto.image
            }
        }
       
    }
    
    @IBAction func takePhotoClick(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }
        else{
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        self.dismiss(animated: true, completion: nil)
        print("User close the shoting process")
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //a photo was token
            
            self.takenPhoto.image = image
//            performSegue(withIdentifier: "SendPhoto", sender: self)
            
        }else{
            //a video was shott
            
        }
        
        self.dismiss(animated: true, completion: nil)
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

