//
//  AskRDVViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 17/05/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire

class AskRDVViewController: UIViewController {

    var Pattt : Patient?
    
    @IBOutlet weak var rdvDate: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    @IBAction func rdvDate(_ sender: AnyObject) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        rdvDate.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
    }
    
  
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //dateFormatter.dateFormat = "YYYY-MM-dd hh:mm a"
        rdvDate.text = dateFormatter.string(from: sender.date)
        
    }
    
    
    
    @IBAction func saveTreat(_ sender: AnyObject) {
        
        if  (rdvDate.text?.isEmpty)!  {
            
            displayAlertMessage(messageToDisplay: "Please fill all the fields")
            
        } else  {
            self.AskRDV()
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
    
    func AskRDV(){
        let id_patient = (self.Pattt?.id)!
        print(id_patient)
        let id_doc = (self.Pattt?.DocId)!
        print(id_doc)
        let date = self.rdvDate.text! as String
        print(date)
        let urll:String = "http://127.0.0.1:80/pim/AddRDV.php"
        let param : Parameters =  [ "id_patient" : id_patient, "id_doc" : id_doc, "date": date]
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
                    
                }
                
                
                
            case .failure(let error):
                self.displayAlertMessage(messageToDisplay: "Error while processing your request: \(error)")
                print("Request failed with error: \(error)")
            }
        }
        
        
        
    }

}
