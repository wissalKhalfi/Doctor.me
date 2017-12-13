//
//  DetailsRDVViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 29/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class DetailsRDVViewController: UIViewController, NVActivityIndicatorViewable {

     @IBOutlet weak var bt_declineRDV: UIButton!
     @IBOutlet weak var bt_acceptRDV: UIButton!
     @IBOutlet weak var field1: UILabel!
     @IBOutlet weak var field2: UILabel!
     @IBOutlet weak var field3: UILabel!
     @IBOutlet weak var field4: UILabel!
     @IBOutlet weak var field5: UILabel!
     @IBOutlet weak var field6: UILabel!
     var RDVselected: RDV!
     var Pat: Patient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let x = 80
        let y = 80
        let frame = CGRect(x: x, y: y, width: 30, height: 30)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .squareSpin, color: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1) , padding: CGFloat(0))
        self.view.addSubview(activityIndicatorView)
        field1.text = " Patient: \((Pat.FirstName)!) \((Pat.LastName)!)"
        field1.sizeToFit()
        field2.text = " Email:  \((Pat.Email)!)"
        field2.sizeToFit()
        field3.text = " Phone:  \((Pat.Phone)!)"
        field3.sizeToFit()
        field4.text = " Date appointement:  \((RDVselected.dateRdv)!)"
        field4.sizeToFit()
        field5.text = " Gender:  \((Pat.sexe)!)"
        field5.sizeToFit()
        field6.text = " Weight:  \((Pat.Poids)!)"
        field6.sizeToFit()
        
        //print(RDVselected.description)
        //print(Pat.description)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func bt_acceptRDV(_ sender: AnyObject) {
        //print("Patient connecté: ")
        //print(Patientselected?.description)
        //let patId = (self.Patientselected?.id)!
        var url:String = "http://localhost/pim/vaidate_rdv.php?rdv_id="
        url += String((RDVselected.id)!)
        
        print(url)
        
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
            response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSDictionary
                print(response)
                self.bt_acceptRDV.isEnabled = true
                self.bt_declineRDV.isEnabled = true
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                    NVActivityIndicatorPresenter.sharedInstance.setMessage("Validating...")
                }
                //self.dismiss(animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    self.stopAnimating()
                }
                /*for item in response { // loop through data items
                    let obj = item as! NSDictionary
                    
                    let id = Int(obj.object(forKey: "success") as! String)
                    let fn = Int(obj.object(forKey: "error")as! String)
                    let size = CGSize(width: 30, height: 30)
                    
                    //self.startAnimating(size, message: "Loading...")
                    
                   
                }*/
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
   

    @IBAction func bt_declineRDV(_ sender: AnyObject) {
        var url:String = "http://localhost/pim/decline_rdv.php?rdv_id="
        url += String((RDVselected.id)!)
        
        print(url)
        
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
            response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSDictionary
                print(response)
                self.bt_acceptRDV.isEnabled = true
                self.bt_declineRDV.isEnabled = true
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                    NVActivityIndicatorPresenter.sharedInstance.setMessage("Validating...")
                }
                //self.dismiss(animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    self.stopAnimating()
                }
                /*for item in response { // loop through data items
                 let obj = item as! NSDictionary
                 
                 let id = Int(obj.object(forKey: "success") as! String)
                 let fn = Int(obj.object(forKey: "error")as! String)
                 let size = CGSize(width: 30, height: 30)
                 
                 //self.startAnimating(size, message: "Loading...")
                 
                 
                 }*/
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
   
}
