//
//  AddTraitementViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 17/05/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class AddTraitementViewController: UIViewController {

    
    var Pat : Patient?
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var takesperday: UITextField!
    @IBOutlet weak var dateDeb: UITextField!
    @IBOutlet weak var DateFin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        takesperday.keyboardType = UIKeyboardType.numberPad
        print(Pat?.description)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func dateDeb(_ sender: AnyObject) {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        dateDeb.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func dateFin(_ sender: AnyObject) {
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        DateFin.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged1(sender:)), for: .valueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateDeb.text = dateFormatter.string(from: sender.date)
        
    }
    
    func datePickerValueChanged1(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "dd MMM yyyy"
        DateFin.text = dateFormatter.string(from: sender.date)
        
    }
    
    
    @IBAction func saveTreat(_ sender: AnyObject) {
        
        if  (name.text?.isEmpty)! || (takesperday.text?.isEmpty)! || (dateDeb.text?.isEmpty)! || (DateFin.text?.isEmpty)! {
            
            displayAlertMessage(messageToDisplay: "Please fill all the fields")
            
        } else  {
            self.Addtrait()
            //displayAlertMessage(messageToDisplay: "Great")
        }
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
   
    func Addtrait(){
        let name = self.name.text! as String
        print(name)
        let takes = self.takesperday.text! as String
        print(takes)
        let datdebb = self.dateDeb.text! as String
        print(datdebb)
        let datefinn = self.DateFin.text! as String
        print(datefinn)
        
        let urll:String = "http://127.0.0.1:80/pim/AddTreatment.php"
        
        let param : Parameters =  [ "name" : name, "nbr_fois_jour" : takes, "date_debut": datdebb, "date_fin" : datefinn, "patient_id" : 1 ]
        print(urll)
        
        Alamofire.request(urll, method: .get, parameters: param).responseJSON {
            response in
            switch response.result {
            case .success(let JSON):
                print("successss")
                let response = JSON as! NSDictionary
                
                if (  Int(response.object(forKey: "success") as! NSNumber )  == 1 )
                {
                    self.dismiss(animated: true, completion: nil)
                    //myActivityIndicator.stopAnimating()
                   // self.performSegue(withIdentifier: "successRegister", sender: self)
                    
                }
                
                
                
            case .failure(let error):
                self.displayAlertMessage(messageToDisplay: "Error while processing your request: \(error)")
                print("Request failed with error: \(error)")
            }
        }
        
        
        
    }
    
}
