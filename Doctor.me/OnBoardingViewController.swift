//
//  OnBoardingViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 31/03/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import PaperOnboarding
class OnBoardingViewController: UIViewController, PaperOnboardingDataSource , PaperOnboardingDelegate{
    
    //@IBOutlet weak var onBoarding: OnboardingView!
    
    @IBOutlet weak var onBoarding: OnboardingView!
   // @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onBoarding.dataSource = self
        onBoarding.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundColorOne = UIColor(red: 217/255, green: 72/255, blue: 89/255, alpha: 1)
        let backgroundColorTwo = UIColor(red: 106/255, green: 166/255, blue: 211/255, alpha: 1)
        let backgroundColorThree = UIColor(red: 168/255, green: 200/255, blue: 78/255, alpha: 1)
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!
        let descirptionFont = UIFont(name: "AvenirNext-Regular", size: 18)!
        
        return [("doctor1", "Welcome...", "Doctor.me application allows the communication between the doctors and the patients", "", backgroundColorTwo, UIColor.white, UIColor.white, titleFont, descirptionFont),
                
                ("dd", "Realtime monitoring", "Check the health status through charts, and get all the infomations you need about your patient.", "", backgroundColorOne, UIColor.white, UIColor.white, titleFont, descirptionFont),
                
                ("hospital", "Hidden Sidebar", "To get all the features of the app, swipe from left to right to show the hidden side bar", "", backgroundColorThree, UIColor.white, UIColor.white, titleFont, descirptionFont)][index]
        
        
        
    }
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    
    
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1 {
            
            if self.getStartedButton.alpha == 1 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.getStartedButton.alpha = 0
                })
            }
            
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            UIView.animate(withDuration: 0.4, animations: {
                self.getStartedButton.alpha = 1
            })
        }
    }
    
  
    @IBAction func GetSart(_ sender: AnyObject) {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(true, forKey: "onboardingComplete")
        
        userDefaults.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
