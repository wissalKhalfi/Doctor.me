//
//  TreatmentPatViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 15/05/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class TreatmentPatViewController: UIViewController , UISearchResultsUpdating,  UITableViewDataSource, UITableViewDelegate, NVActivityIndicatorViewable {

    var Patientselected : Patient?
    let searchController = UISearchController(searchResultsController: nil)
    var TreatmentList = [Treatment]()
    var filteredTreatment = [Treatment]()
    var TreatmentSelected:Treatment?
    
    @IBOutlet weak var TreatmentListView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let x = 80
        let y = 80
        let frame = CGRect(x: x, y: y, width: 30, height: 30)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .squareSpin, color: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1) , padding: CGFloat(0))
        self.view.addSubview(activityIndicatorView)
        LoadTreatments()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        TreatmentListView.tableHeaderView = searchController.searchBar
        print("Patient connecté: ")
        print(Patientselected?.description)
    }

    override func viewWillAppear(_ animated: Bool) {
        TreatmentListView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredTreatment = TreatmentList.filter { candy in
            return (candy.name?.lowercased().contains(searchText.lowercased()))!
        }
        
        TreatmentListView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    
    func LoadTreatments(){
        let patId = (self.Patientselected?.id)!
        var url:String = "http://127.0.0.1:80/pim/loadTreatmentsPerPatient.php?patId="
        url += String(patId)
        
        print(url)
        
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
            response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSArray
                print(response)
                for item in response { // loop through data items
                    let obj = item as! NSDictionary
                    
                    let idd = Int(obj.object(forKey: "id") as! String)
                    let nameTr = obj.object(forKey: "name")as! String
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yy"
                    let date_debut = dateFormatter.date(from: obj.object(forKey: "date_debut")as! String)
                    let date_fin = dateFormatter.date(from: obj.object(forKey: "date_fin")as! String)
                    let patientId = Int(obj.object(forKey: "patient_id")as! String)
                    let nbr_fois_jour = Int(obj.object(forKey: "nbr_fois_jour")as! String)
                    let created_at = dateFormatter.date(from: obj.object(forKey: "created_at")as! String)
                    
                    /* //Your date format
                     let created_at = dateFormatter.date(from: obj.object(forKey: "CREATED_AT")as! String )
                     */
                    
                    let trp = Treatment(aId: idd, Name: nameTr, dateDebut: date_debut, dateFin: date_fin, id_pat: patientId, nbrFois: nbr_fois_jour, createdAt: created_at)
                    //self.TreatmentList.append(treatmentP)
                    let size = CGSize(width: 30, height: 30)
                    
                    self.startAnimating(size, message: "Loading...")
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                        NVActivityIndicatorPresenter.sharedInstance.setMessage("Treatment's list...")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                        self.stopAnimating()
                    }
                }
                self.TreatmentListView.reloadData()
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
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredTreatment.count
        }
        return TreatmentList.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print("You selected cell #\(indexPath.row)!")
        if searchController.isActive && searchController.searchBar.text != "" {
            TreatmentSelected = filteredTreatment[indexPath.row]
        } else {
            TreatmentSelected = TreatmentList[indexPath.row]
        }
       // performSegue(withIdentifier: "noteDeets", sender: self)
        
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if segue.identifier == "noteDeets" {
            
            let destination:NoteDeetsViewController = segue.destination as! NoteDeetsViewController
            destination.NoteSelected = NoteSelected
            
        }
        if segue.identifier == "addNote" {
            let destination: AddNoteViewController = segue.destination as! AddNoteViewController
            destination.patientCo = Patientselected
            
        }*/
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let treaaa: Treatment = TreatmentList[indexPath.row]
            var url:String = "http://127.0.0.1:80/pim/RemoveTreatmentByid.php?id="
            url += String((treaaa.id)!)
            
            print(url)
            
            
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
                response in switch response.result {
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    print(response)
                    self.TreatmentList.remove(at: indexPath.row)
                    self.TreatmentListView.deleteRows(at: [indexPath], with: .automatic)
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TreatmentCell", for: indexPath)
        cell.backgroundColor = UIColor.clear;
        let treaa: Treatment
        if searchController.isActive && searchController.searchBar.text != "" {
            treaa = filteredTreatment[indexPath.row]
        } else {
            treaa = TreatmentList[indexPath.row]
        }
        
        
        let textNote:UITextView = cell.viewWithTag(2750) as! UITextView
        let dateNote:UILabel = cell.viewWithTag(1995) as! UILabel
        textNote.text = ("Id: \(treaa.id!)")
        textNote.isEditable = false
        dateNote.text = treaa.name!
        
        
        return cell
        
    }

}
