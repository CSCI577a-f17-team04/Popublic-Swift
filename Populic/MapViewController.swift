//
//  MapViewController.swift
//  Populic
//
//  Created by Chengyu_Ovaltine on 9/25/17.
//  Copyright © 2017 Chengyu_Ovaltine. All rights reserved.
//

import UIKit
import MapKit
import Contacts
import ContactsUI
import MessageUI

class MapViewController: UIViewController, CNContactPickerDelegate, MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
    }
    
    var time = Timer()
    var totalTime : Int!
    
    @IBOutlet weak var challengeButton: UIButton!
    @IBOutlet weak var timeRemaining: UILabel!
    
    @IBOutlet weak var doIt: UIButton!
    @IBOutlet weak var challengeFri: UIButton!
    @IBOutlet weak var suggestion: UIButton!
    
    @IBOutlet weak var schoolMap: MKMapView!
    @IBOutlet var challengeView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    var effect:UIVisualEffect!
    
    @IBAction func accessContactList(_ sender: Any) {
        let entireType = CNEntityType.contacts
        let authStatus = CNContactStore.authorizationStatus(for: entireType)
        
        if authStatus == CNAuthorizationStatus.notDetermined{
            let contactStore =
                CNContactStore.init()
            contactStore.requestAccess(for: entireType, completionHandler: {(success, nil) in
                if success {
                    self.openContact()
                }
                else{
                    print("Not autorized")
                }
            })
            
        }
        else if authStatus == CNAuthorizationStatus.authorized{
            self.openContact()
        }
    }
    
    func openContact() {
        let contactPicker = CNContactPickerViewController.init()
        contactPicker.delegate = self as CNContactPickerDelegate
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    func cancelContactPicker(_ picker: CNContactPickerViewController){
        picker.dismiss(animated: true){
            
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        if !contact.phoneNumbers.isEmpty{
            let phoneNum = (((contact.phoneNumbers[0] as AnyObject).value(forKey: "labelValuePair") as AnyObject).value(forKey: "value") as AnyObject).value(forKey: "stringValue")
            print(phoneNum! as! String)
            
        }
    }
    
    func sendSMS(_ phoneNum : String){
        let msgVC = MFMessageComposeViewController()
        
        msgVC.body = "Your friend challenge you in Popublic, what to learn more? Here is the Link"
        msgVC.recipients = [phoneNum]
        msgVC.messageComposeDelegate = self
        self.present(msgVC, animated: true, completion: {print("Share succeed")})
    }
    
    @IBAction func popUpChallenge(_ sender: Any) {
        animateIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalTime = 3*3600
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MapViewController.updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime(){
        totalTime = totalTime - 1
        timeRemaining.text = NumToString(totalTime)
    }
    
    func NumToString(_ totalTime:Int) -> String{
        let hrs = totalTime/3600
        let mins = (totalTime%3600)/60
        let secs = (totalTime%60)
        
        return String(format: "%02d:%02d:%02d", hrs, mins, secs)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.effect = visualEffectView.effect
        visualEffectView.effect = nil
        // Do any additional setup after loading the view.
        challengeButton.setImage(UIImage(named: "challenge.png"), for: .normal)
        
        challengeView.layer.cornerRadius = 5
        doIt.layer.cornerRadius = 5
        doIt.layer.borderWidth = 2
        doIt.layer.borderColor = UIColor.white.cgColor
        
        challengeFri.layer.cornerRadius = 5
        challengeFri.layer.borderWidth = 2
        challengeFri.layer.borderColor = UIColor.white.cgColor
        challengeFri.backgroundColor = UIColor(hue: 0.5917, saturation: 1, brightness: 0.87, alpha: 1.0)
        
        suggestion.layer.cornerRadius = 5
        suggestion.layer.borderWidth = 2
        suggestion.layer.borderColor = UIColor.white.cgColor
        suggestion.backgroundColor = UIColor(hue: 0.5917, saturation: 1, brightness: 0.87, alpha: 1.0)
        
        challengeView.backgroundColor = UIColor(hue: 0.55, saturation: 0.66, brightness: 0.98, alpha: 1)
        doIt.backgroundColor = UIColor.green
        
        
        //set up location and map features
        let latitude: CLLocationDegrees = 34.021340
        let longitude: CLLocationDegrees = -118.286493
        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        schoolMap.setRegion(region, animated: true)
    }
    
    func animateIn(){
        self.view.addSubview(challengeView)
        challengeView.center = self.view.center
        
        challengeView.transform = CGAffineTransform.init(scaleX:1.3, y:1.3)
        challengeView.alpha = 0
        
        UIView.animate(withDuration: 0.4){
            self.visualEffectView.effect = self.effect
            self.challengeView.alpha = 1
            self.challengeView.transform = CGAffineTransform.identity
        }
        
    }

    func animateOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.challengeView.transform = CGAffineTransform.init(scaleX:1.3, y:1.3)
            self.challengeView.alpha = 0
            
            self.visualEffectView.effect = nil
            }){(success:Bool) in
                self.challengeView.removeFromSuperview()
        }
    }
    @IBAction func cancelChallenge(_ sender: Any) {
        animateOut()
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
