//
//  AddPatientViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 31/03/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import Eureka
import Alamofire
import NVActivityIndicatorView

class AddTreatmentViewController: UIViewController  , UIPickerViewDataSource, UIPickerViewDelegate ,  NVActivityIndicatorViewable , UITextFieldDelegate  {

    
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var LAstName: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var DateOfBirth: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var PhoneNumber: UITextField!
    @IBOutlet weak var cin: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var bloodgroup: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height: UITextField!
    var pickOption = ["Female", "Male"]
    override func viewDidLoad() {
        super.viewDidLoad()

        let pickerView = UIPickerView()
        pickerView.delegate = self
        gender.inputView = pickerView
        FirstName.delegate = self
        LAstName.delegate = self
        Email.delegate = self
        DateOfBirth.delegate = self
        Address.delegate = self
        PhoneNumber.delegate = self
        cin.delegate = self
        gender.delegate = self
        bloodgroup.delegate = self
        weight.delegate = self
        height.delegate = self
        
        
        let x = 80
        let y = 80
        let frame = CGRect(x: x, y: y, width: 30, height: 30)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballTrianglePath, color: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1) , padding: CGFloat(0))
        self.view.addSubview(activityIndicatorView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SavePatient(_ sender: AnyObject) {
        let mail = Email.text! as String
        let isEmailAddressValid = isValidEmailAddress(emailAddressString: mail)
        
        if  (FirstName.text?.isEmpty)! || (LAstName.text?.isEmpty)! || (Email.text?.isEmpty)! || (DateOfBirth.text?.isEmpty)! || (Address.text?.isEmpty)! || (PhoneNumber.text?.isEmpty)! || (cin.text?.isEmpty)! || (gender.text?.isEmpty)! || (bloodgroup.text?.isEmpty)! || (weight.text?.isEmpty)! || (height.text?.isEmpty)!   {
            
            displayAlertMessage(messageToDisplay: "Please fill all the fields")
            
        } else if !isEmailAddressValid {
            displayAlertMessage(messageToDisplay: "Email address is not valid")
        }else  {
           // self.signin()
        displayAlertMessage(messageToDisplay: "Great")
        }
    }
    
    
    @IBAction func DateOfBirth(_ sender: AnyObject) {
            
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            DateOfBirth.inputView = datePicker
            datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        }
        
        func datePickerValueChanged(sender:UIDatePicker) {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.medium
            dateFormatter.dateFormat = "dd MMM yyyy"
            DateOfBirth.text = dateFormatter.string(from: sender.date)
            
        }
        
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Register", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gender.text = pickOption[row]
    }

}
