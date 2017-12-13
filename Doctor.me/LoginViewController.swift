//
//  LoginViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 13/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class LoginViewController: UIViewController , NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var txtIdetifiant: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var bt_Login: UIButton!
    var patient: Patient!
    var medecin: Medecin!

    override func viewDidLoad() {
        super.viewDidLoad()
        txtPwd.isSecureTextEntry = true
        let x = 80
        let y = 80
        let frame = CGRect(x: x, y: y, width: 30, height: 30)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .ballTrianglePath, color: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1) , padding: CGFloat(0))
        self.view.addSubview(activityIndicatorView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        print("....................................")
        print(defaults.object(forKey: "Doctor_connected") )
        print("....................................")
        print("....................................")
        print(defaults.object(forKey: "Patient_connected") )
        print("....................................")
        
        if( defaults.object(forKey: "Doctor_connected") != nil)
        {
            bt_Login.isEnabled = false
            txtPwd.isEnabled = false
            txtIdetifiant.isEnabled = false
            self.performSegue(withIdentifier: "medecin", sender: self)
            // self.performSegue(withIdentifier: "medecin", sender: self)
            
        }else if ( defaults.object(forKey: "Patient_connected") as? Patient != nil) {
            bt_Login.isEnabled = false
            txtPwd.isEnabled = false
            txtIdetifiant.isEnabled = false
            
            self.performSegue(withIdentifier: "patient", sender: self)
            
        }else  {
            
            bt_Login.isEnabled = true
            txtPwd.isEnabled = true
            txtIdetifiant.isEnabled = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Login", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
            
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func LoginasPatient(_ sender: AnyObject) {
        
        if ((self.txtIdetifiant.text?.isEmpty)! || (self.txtPwd.text?.isEmpty)!)
        {
            self.displayAlertMessage(messageToDisplay: "Please fill all the fields")
        }
        else
        {
            
            var urll:String = "http://127.0.0.1:80/pim/login.php?mail="
            urll += String((self.txtIdetifiant.text)!)
            urll += "&password="
            urll += String((self.txtPwd.text)!)
            
            //print(urll)
            
            let size = CGSize(width: 30, height: 30)
            
            self.startAnimating(size, message: "Loading...")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating...")
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.stopAnimating()
            }
            
            
            Alamofire.request(urll, method: .get, parameters: nil, encoding: JSONEncoding.default)
                .responseJSON {
                    response in
                    switch response.result {
                    case .success(let JSON):
                        print("successss")
                        let response = JSON as! NSArray
                        print(response)
                        for item in response {
                            let obj = item as! NSDictionary
                            let defaults = UserDefaults.standard
                            //print(  (obj.object(forKey: "admin_id") as? String)! )
                            
                            if ( Int((obj.object(forKey: "Doc_id") as? String)!)  != nil )
                            {
                                //print("doc_id")
                                
                                let id = Int(obj.object(forKey: "Id") as! String)
                                let fn = obj.object(forKey: "FirstName")as! String
                                let ln = obj.object(forKey: "LastName")as! String
                                let mail = obj.object(forKey: "Email")as! String
                                let phone = Int(obj.object(forKey: "Phone") as! String)
                                let cin = Int(obj.object(forKey: "Cin") as! String)
                                let sexe = obj.object(forKey: "Sex")as! String
                                let grp_sng = obj.object(forKey: "groupe_sanguin")as! String
                                let poids = Int(obj.object(forKey: "poid") as! String)
                                let taille = Int(obj.object(forKey: "taille") as! String )
                                let doc_id = Int(obj.object(forKey: "Doc_id") as! String )
                                let passw = obj.object(forKey: "password") as! String
                                let Capteur1 = Int(obj.object(forKey: "capteur1") as! String )
                                let Capteur2 = Int(obj.object(forKey: "capteur2") as! String )
                                let Capteur3 = Int(obj.object(forKey: "capteur3") as! String )
                                let Capteur4 = Int(obj.object(forKey: "capteur4") as! String )
                                let Capteur5 = Int(obj.object(forKey: "capteur5") as! String )
                                let Capteur6 = Int(obj.object(forKey: "capteur6") as! String )
                                let Capteur7 = Int(obj.object(forKey: "capteur7") as! String )
                                
                                self.patient = Patient(aId : id , aFN: fn , aLN: ln  ,Email: mail, Phone: phone , Cin: cin, sexe: sexe,  grp_sanguin: grp_sng, Poids: poids, Taille: taille, DocId: doc_id , password: passw, capteur1: Capteur1, capteur2: Capteur2, capteur3: Capteur3, capteur4: Capteur4, capteur5: Capteur5, capteur6: Capteur6, capteur7: Capteur7)

                                let encodedPat = NSKeyedArchiver.archivedData(withRootObject: self.patient)
                                defaults.set(encodedPat, forKey: "Patient_connected")
                                defaults.synchronize()
                                self.performSegue(withIdentifier: "patient", sender: self)
                                return
                            }
                            
                        }
                        
                        
                    case .failure(let error):
                        self.displayAlertMessage(messageToDisplay: "Request failed with error: \(error)")
                    }
            }
        }
    }
    
    @IBAction func Login(_ sender: AnyObject) {
     

        if ((self.txtIdetifiant.text?.isEmpty)! || (self.txtPwd.text?.isEmpty)!)
        {
            self.displayAlertMessage(messageToDisplay: "Please fill all the fields")
        }
        else
        {
            
        var urll:String = "http://127.0.0.1:80/pim/login.php?mail="
        urll += String((self.txtIdetifiant.text)!)
        urll += "&password="
        urll += String((self.txtPwd.text)!)
        
        //print(urll)
           
            let size = CGSize(width: 30, height: 30)

            self.startAnimating(size, message: "Loading...")
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating...")
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.stopAnimating()
            }
        
        
        Alamofire.request(urll, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON {
                response in
                switch response.result {
                case .success(let JSON):
                    print("successss")
                    let response = JSON as! NSArray
                    print(response)
                    for item in response {
                        let obj = item as! NSDictionary
                        let defaults = UserDefaults.standard
                        if    ( Int((obj.object(forKey: "id") as? String)!)  != nil )
                        {
                            let id = Int(obj.object(forKey: "id") as! String)
                            let fn = obj.object(forKey: "name")as! String
                            let mail = obj.object(forKey: "email")as! String
                            let passw = obj.object(forKey: "password")as! String
                            //self.medecin = Medecin(aId: id, aFN: fn, aLN: ln, Email: mail, Phone: phone, pass: "")
                            self.medecin = Medecin(aId: id, aFN: fn, Email: mail, pass: passw)
                            let encodedData = NSKeyedArchiver.archivedData(withRootObject: self.medecin)
                            defaults.set(encodedData, forKey: "Doctor_connected")
                            defaults.synchronize()
                            self.performSegue(withIdentifier: "medecin", sender: self)
                            return
                        }
                        
                        }

                    
                case .failure(let error):
                    self.displayAlertMessage(messageToDisplay: "Request failed with error: \(error)")
                }
        }
        }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let defaults = UserDefaults.standard
        if segue.identifier == "medecin" {
            let destination:UINavigationController = segue.destination as! UINavigationController
            let dee: MainOneViewController = destination.topViewController as! MainOneViewController
            let decoded  = defaults.object(forKey: "Doctor_connected") as! Data
            let medcin_co = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Medecin
            dee.MedecinConnected = medcin_co
        }
        if segue.identifier == "patient" {
            let destination:UINavigationController = segue.destination as! UINavigationController
            let dee: PatientDetailsViewController = destination.topViewController as! PatientDetailsViewController
            let decoded  = defaults.object(forKey: "Patient_connected") as! Data
            let pat_co = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! Patient
            dee.Patient = pat_co
            
        }
    }
}
