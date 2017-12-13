//
//  AddNoteViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 01/05/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire

class AddNoteViewController: UIViewController {

    var patientCo : Patient?
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var NomPrenom: UILabel!
    @IBOutlet weak var textNote: UITextView!
    @IBOutlet weak var bt_saveNote: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NomPrenom.text = " Patient: \((patientCo?.FirstName)!) \((patientCo?.LastName)!)"
        Email.text = " Email: \((patientCo?.FirstName)!)"
        textNote.isEditable = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func bt_saveNote(_ sender: AnyObject) {
        print("Patient connecté: ")
        print(patientCo?.description)
        let patId = (self.patientCo?.id)!
        let docid = (self.patientCo?.DocId)!
        let url:String = "http://127.0.0.1/pim/AddNote.php"
        let param : Parameters = ["text_note": self.textNote.text, "id_pat": patId, "id_doc": docid]
        Alamofire.request(url, method: .get, parameters: param).responseJSON{
            response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSDictionary
                print(response)
                self.displayAlertMessage(messageToDisplay: "Note Saved successfully")               
                //self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            case .failure(let error):
                self.displayAlertMessage(messageToDisplay: "Request failed with error: \(error)")
                //print("Request failed with error: \(error)")
            }
        }
       // displayAlertMessage(messageToDisplay: "Note Saved successfully")
    }
    
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Notes", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
           // print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}

//////////////////
/*
 
 https://github.com/WenchaoD/FSCalendar
 https://github.com/samjau/calendar
 https://github.com/patchthecode/JTAppleCalendar/blob/master/Example/JTAppleCalendar%20iOS%20Example/ViewController.swift
 http://www.globalnerdy.com/2016/08/18/how-to-work-with-dates-and-times-in-swift-3-part-1-dates-calendars-and-datecomponents/
 http://www.appcoda.com/ios-programming-course/
 
 */
