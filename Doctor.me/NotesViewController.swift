//
//  NotesViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 28/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class NotesViewController: UIViewController, UISearchResultsUpdating,  UITableViewDataSource, UITableViewDelegate, NVActivityIndicatorViewable {

    let searchController = UISearchController(searchResultsController: nil)
    var Patientselected : Patient?
    var NotesList = [NotePatient]()
    var filteredNotes = [NotePatient]()
    var NoteSelected:NotePatient?
    @IBOutlet weak var NotesListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let x = 80
        let y = 80
        let frame = CGRect(x: x, y: y, width: 30, height: 30)
        let activityIndicatorView = NVActivityIndicatorView(frame: frame, type: .squareSpin, color: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1) , padding: CGFloat(0))
        self.view.addSubview(activityIndicatorView)
        loadNotes()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        NotesListView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        NotesListView.tableHeaderView = searchController.searchBar
        print("Patient connecté: ")
        print(Patientselected?.description)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotesListView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredNotes = NotesList.filter { candy in
            return (candy.remarque?.lowercased().contains(searchText.lowercased()))!
        }
        
        NotesListView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    
    func loadNotes(){
        
        print("Patient connecté: ")
        print(Patientselected?.description)
        let patId = (self.Patientselected?.id)!
        var url:String = "http://127.0.0.1:80/pim/loadNotes.php?patId="
        url += String(patId)
        
        print(url)
        
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
            response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSArray
                print(response)
                for item in response { // loop through data items
                    let obj = item as! NSDictionary
                    
                    let id = Int(obj.object(forKey: "id") as! String)
                    let fn = Int(obj.object(forKey: "id_doc")as! String)
                    let ln = Int(obj.object(forKey: "id_patient")as! String)
                    let rq = obj.object(forKey: "remarque")as! String
                    let datt = obj.object(forKey: "date_rq")as! String
                    //et dateFormatter = DateFormatter()
                    //dateFormatter.dateFormat =  "dd MMM yyyy hh:mm:ss" //Your date format
                    //let dateRR = dateFormatter.date(from: datt)
                    //print(datt)
                    let noteP = NotePatient(aId: id, id_doc: fn, id_pat: ln, req: rq, date_rq: datt)
                    //let happyhour = Patient (aId : id , aFN: fn , aLN: ln  ,Email: mail, Adresse: adr, Phone: phone , Cin: cin, sexe: sexe,  grp_sanguin: grp_sng, Poids: poids, Taille: taille, DocId: doc_id , password: passw )
                    print(noteP.description)
                    self.NotesList.append(noteP)
                    let size = CGSize(width: 30, height: 30)
                    
                    self.startAnimating(size, message: "Loading...")
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                        NVActivityIndicatorPresenter.sharedInstance.setMessage("Notes list...")
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                        self.stopAnimating()
                    }
                }
                self.NotesListView.reloadData()
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
            return filteredNotes.count
        }
        return NotesList.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        if searchController.isActive && searchController.searchBar.text != "" {
            NoteSelected = filteredNotes[indexPath.row]
        } else {
            NoteSelected = NotesList[indexPath.row]
        }
        performSegue(withIdentifier: "noteDeets", sender: self)
        
    }
    @IBAction func bt_addNote(_ sender: AnyObject) {
        performSegue(withIdentifier: "addNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "noteDeets" {
            
            let destination:NoteDeetsViewController = segue.destination as! NoteDeetsViewController
            destination.NoteSelected = NoteSelected
            
        }
        if segue.identifier == "addNote" {
            let destination: AddNoteViewController = segue.destination as! AddNoteViewController
            destination.patientCo = Patientselected
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let nootte: NotePatient = NotesList[indexPath.row]
            var url:String = "http://127.0.0.1:80/pim/RemoveNoteByid.php?id="
            url += String((nootte.id)!)
            
            print(url)
            
            
            
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
                response in switch response.result {
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    print(response)
                    self.NotesList.remove(at: indexPath.row)
                    self.NotesListView.deleteRows(at: [indexPath], with: .automatic)
                case .failure(let error):
                    print("Request failed with error: \(error)")
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)
        cell.backgroundColor = UIColor.clear;
        let nootte: NotePatient
        if searchController.isActive && searchController.searchBar.text != "" {
            nootte = filteredNotes[indexPath.row]
        } else {
            nootte = NotesList[indexPath.row]
        }
        
        
        let textNote:UITextView = cell.viewWithTag(10) as! UITextView
        let dateNote:UILabel = cell.viewWithTag(20) as! UILabel
        textNote.text = nootte.remarque
        textNote.isEditable = false
        dateNote.text = nootte.dateR!
        
        
        return cell
        
    }
    
}
