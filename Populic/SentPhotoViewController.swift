//
//  SentPhotoViewController.swift
//  Populic
//
//  Created by Chengyu_Ovaltine on 9/25/17.
//  Copyright © 2017 Chengyu_Ovaltine. All rights reserved.
//

import UIKit

class SentPhotoViewController: UIViewController {
    var takenPhoto:UIImage?
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let availableImg = takenPhoto{
            imageView.image = availableImg
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var challengeOrNot: UIButton!
    var challenged = true
    @IBAction func challengeOrNot(_ sender: Any) {
        if challenged {
            challengeOrNot.setImage(UIImage(named: "notChallenge.png"), for: .normal)
            challenged = false
        }
        else{
            challengeOrNot.setImage(UIImage(named: "isChallenge.png"), for: .normal)
            challenged = true
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(_ sender: Any) {
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
