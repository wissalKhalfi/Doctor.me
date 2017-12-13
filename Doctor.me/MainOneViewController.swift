//
//  MainOneViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 31/03/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class MainOneViewController: UIViewController, UISearchResultsUpdating, SideBarDelegate , UITableViewDataSource, UITableViewDelegate, NVActivityIndicatorViewable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addNew: UIButton!
    @IBOutlet weak var PatientsList: UITableView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var TextAbout: UITextView!
    @IBOutlet weak var DocNameSurname: UILabel!
    @IBOutlet weak var DocMail: UILabel!
    @IBOutlet weak var DocAddress: UILabel!
    @IBOutlet weak var DocActivP: UILabel!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var ListeRDV: UITableView!
    @IBOutlet weak var calendar: UIButton!
    
    let searchController = UISearchController(searchResultsController: nil)
    let searchController1 = UISearchController(searchResultsController: nil)
    //let searchbar: UISearchController
    var MedecinConnected:Medecin?
    var chosenRdv: RDV?
    var PatientSelected:Patient?
    var sideBar:SideBar = SideBar()
    var happyHours = [Patient]()
    var Rdvs = [RDV]()
    var filteredPatients = [Patient]()
    var filteredRdvs = [RDV]()
    var  Pat: Patient?

    override func viewDidLoad() {
        super.viewDidLoad()
        let x = 80
        let y = 80
        let frame = CGRect(x: x, y: y, width: 30, height: 30)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .squareSpin, color: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1) , padding: CGFloat(0))
        self.view.addSubview(activityIndicatorView)
        logo.isHidden = false
        TextAbout.isHidden = true
        addNew.isHidden=true
        PatientsList.isHidden = true
        ListeRDV.isHidden = true
        DocNameSurname.isHidden = true
        DocMail.isHidden = true
        DocActivP.isHidden = true
        DocAddress.isHidden = true
        logout.isHidden=true
        calendar.isHidden = true
        sideBar = SideBar(sourceView: self.view, menuItems: ["About", "Patients", "Appointements", "My infos"])
        sideBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        PatientsList.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        PatientsList.alpha = 0.75
        //ListeRDV.delegate = self
        //ListeRDV.dataSource = self
        //AppointementsView.addSubview(ListeRDV)
        ListeRDV.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        ListeRDV.alpha = 0.75
        //ListeRDV.tableHeaderView = searchController.searchBar
        PatientsList.tableHeaderView = searchController.searchBar
        loadHappyHourElements()
        loadRDV()
        //print("Medecin connecté: ")
        //print(MedecinConnected?.description)
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func bt_logout(_ sender: AnyObject) {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "Doctor_connected")
        print("Test C: My defaults removed \(UserDefaults.standard.object(forKey: "Doctor_connected"))")
            //.set(nil, forKey: "Doctor_connected")
        //UserDefaults.standard.removeObject(forKey: "MyDefaults")
        let size = CGSize(width: 30, height: 30)
        
        self.startAnimating(size, message: "Loading...")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Loging out...")
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.stopAnimating()
        }
        dismiss(animated: true, completion: nil)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        //Rdvs.removeAll()
        //loadRDV()
        //ListeRDV.reloadData()
        //PatientsList.reloadData()
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        filteredPatients = happyHours.filter { candy in
            return (candy.FirstName?.lowercased().contains(searchText.lowercased()))!
        }
        
        PatientsList.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    
    func sideBarDidSelectButtonAtIndex(_ index: Int) {
        if index == 0{
            ListeRDV.isHidden = true
            addNew.isHidden=true
            logo.isHidden = false
            TextAbout.isHidden = false
            PatientsList.isHidden = true
            DocNameSurname.isHidden = true
            DocMail.isHidden = true
            DocActivP.isHidden = true
            DocAddress.isHidden = true
            logout.isHidden=true
            calendar.isHidden = true
        } else if index == 1{
            ListeRDV.isHidden = true
            DocNameSurname.isHidden = true
            DocMail.isHidden = true
            DocActivP.isHidden = true
            DocAddress.isHidden = true
            addNew.isHidden=false
            PatientsList.isHidden = false
            TextAbout.isHidden = true
            logo.isHidden = true
            logout.isHidden=true
            calendar.isHidden = true
            
        }else if index == 2{
            
            DocNameSurname.isHidden = true
            DocMail.isHidden = true
            DocActivP.isHidden = true
            DocAddress.isHidden = true
            addNew.isHidden=true
            PatientsList.isHidden = true
            TextAbout.isHidden = true
            logo.isHidden = true
            logout.isHidden=true
            ListeRDV.isHidden = false
            calendar.isHidden = false
            
        } else if index == 3{
            ListeRDV.isHidden = true
            addNew.isHidden=true
            PatientsList.isHidden = true
            TextAbout.isHidden = true
            logo.isHidden = false
            calendar.isHidden = true
            DocNameSurname.isHidden = false
            DocMail.isHidden = false
            DocActivP.isHidden = false
            DocAddress.isHidden = false
            logout.isHidden=false
            DocNameSurname.text = " Doctor: \( (self.MedecinConnected?.Name)!) "
            DocMail.text = " Email : \( (self.MedecinConnected?.Name)!) "
            DocAddress.text =  " Number of active patients: \(String( self.happyHours.count )) "
            //DocActivP.text =
            
            //  imageView.backgroundColor = UIColor.clear
            // imageView.image = UIImage(named: "bg1")
                    //" Patient: \((Patient?.FirstName)!) \((Patient?.LastName)!)"
        }
    }
    
    func loadRDV(){
        
        var url:String = "http://127.0.0.1/pim/GetRdvByDoc.php?docId="
        let DocId = (self.MedecinConnected?.id)!
        url += String(DocId)
        
        print(url)
        
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
            response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSArray
                //print(response)
                for item in response { // loop through data items
                    let obj = item as! NSDictionary
                    
                    let id = Int(obj.object(forKey: "id") as! String)
                    let fn = Int(obj.object(forKey: "id_doc")as! String)
                    let ln = Int(obj.object(forKey: "id_patient")as! String)
                    let date_r = obj.object(forKey: "Daterdv")as! String
                    let etat = Int(obj.object(forKey: "etat")as! String)
                    
                    let rdv = RDV(aId: id, id_doc: fn, id_pat: ln, et: etat, date_rq: date_r)
                    print(rdv.description)
                    self.Rdvs.append(rdv)
                    
                }
                self.ListeRDV.reloadData()
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func loadHappyHourElements(){
        
        print("Medecin connecté: ")
        print(MedecinConnected?.description)
        let DocId = (self.MedecinConnected?.id)!
        var url:String = "http://127.0.0.1:80/pim/Patients.php?docId="
        url += String(DocId)
        
        print(url)
       
        
        
           Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
            response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSArray
                for item in response { // loop through data items
                    let obj = item as! NSDictionary
                    
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
                    
                    let happyhour = Patient(aId : id , aFN: fn , aLN: ln  ,Email: mail, Phone: phone , Cin: cin, sexe: sexe,  grp_sanguin: grp_sng, Poids: poids, Taille: taille, DocId: doc_id , password: passw, capteur1: Capteur1, capteur2: Capteur2, capteur3: Capteur3, capteur4: Capteur4, capteur5: Capteur5, capteur6: Capteur6, capteur7: Capteur7)
                    
                    self.happyHours.append(happyhour!)
                    let size = CGSize(width: 30, height: 30)
                    
                    self.startAnimating(size, message: "Loading...")
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                        NVActivityIndicatorPresenter.sharedInstance.setMessage("Patient's list...")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                        self.stopAnimating()
                    }
                }
                self.PatientsList.reloadData()
                //self.do_tablePatients_refresh();
            case .failure(let error):
                print("Request failed with error: \(error)")
                }
        }
    }
    
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count:Int?
        if tableView == self.PatientsList {
            if searchController.isActive && searchController.searchBar.text != "" {
                count = filteredPatients.count
            }
            count = happyHours.count
        }
        else if tableView == self.ListeRDV {
            count = Rdvs.count
        }
        return count!
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print("You selected cell #\(indexPath.row)!")
        //let pat: Patient
        if tableView == self.PatientsList {
            if searchController.isActive && searchController.searchBar.text != "" {
                PatientSelected = filteredPatients[indexPath.row]
            } else {
                PatientSelected = happyHours[indexPath.row]
            }
            //PatientSelected = happyHours[indexPath.row]
            performSegue(withIdentifier: "patientdeets", sender: self)
        }
        if tableView == self.ListeRDV {
            
            chosenRdv = Rdvs[indexPath.row]
            //PatientSelected = happyHours[indexPath.row]
            performSegue(withIdentifier: "deetsRDV", sender: self)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "patientdeets" {
            let destination:UINavigationController = segue.destination as! UINavigationController
            let dee: PatientDetailsViewController = destination.topViewController as! PatientDetailsViewController
            //let destination:PatientDetailsViewController = segue.destination as! PatientDetailsViewController
            dee.Patient = PatientSelected
            
        }
        if segue.identifier == "deetsRDV" {
            let destination:DetailsRDVViewController = segue.destination as! DetailsRDVViewController
            //let dee: DetailsRDVViewController = destination.topViewController as! PatientDetailsViewController
            //let destination:PatientDetailsViewController = segue.destination as! PatientDetailsViewController
            destination.RDVselected = chosenRdv
            destination.Pat = Pat
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell?
        
        if tableView == self.PatientsList {
            cell = tableView.dequeueReusableCell(withIdentifier: "PatientCell", for: indexPath)
            cell?.backgroundColor = UIColor.clear;
            let happyHour: Patient
            if searchController.isActive && searchController.searchBar.text != "" {
                happyHour = filteredPatients[indexPath.row]
            } else {
                happyHour = happyHours[indexPath.row]
            }
            
            
            let FirstN:UILabel = cell?.viewWithTag(30) as! UILabel
            let LastN:UILabel = cell?.viewWithTag(10) as! UILabel
            let email:UILabel = cell?.viewWithTag(20) as! UILabel
            
            FirstN.text = happyHour.FirstName
            LastN.text = happyHour.LastName
            email.text = happyHour.Email
        }
        
        else if tableView == self.ListeRDV {
            cell = tableView.dequeueReusableCell(withIdentifier: "RDVCell", for: indexPath)
            
            let rdd: RDV
            print("..............")
            rdd = Rdvs[indexPath.row]
            print(rdd.description)
            print("..............")
            //cell?.backgroundColor = UIColor.clear;
            
            if (rdd.etat)! == 0 {
                cell?.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            } else if (rdd.etat)! == 2 {
                cell?.backgroundColor = #colorLiteral(red: 1, green: 0.2265126109, blue: 0.1189805344, alpha: 1)
                cell?.isUserInteractionEnabled = false
            } else if (rdd.etat)! == 1 {
                cell?.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            /*  filteredPatients = happyHours.filter { candy in
             return (candy.FirstName?.lowercased().contains(searchText.lowercased()))!
             }*/
            for pat in happyHours {
              //  print(" rdd id \(rdd.id!)")
              //  print("pat id \(pat.id!)")
                if pat.id! == rdd.idPat! {
                    Pat = pat
                }
            }
            
            let test1:UILabel = cell?.viewWithTag(300) as! UILabel
            let test3:UILabel = cell?.viewWithTag(100) as! UILabel
            let test2:UILabel = cell?.viewWithTag(200) as! UILabel
            
            test1.text = rdd.dateRdv
            test2.text = (Pat?.Email)
            test3.text = " \(Pat?.FirstName)  \(Pat?.LastName) "
            
            // \(Pat?.FirstName) \(Pat.LastName)
        }
       
        return cell!
        
    }
    
    
    //Notifications
    //Photopatient/medecin
    //Critical Cases 
    //Calendrier : rdv
    //Treatmnents
    //Call phone actions
    

}
