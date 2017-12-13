//
//  PatientDetailsViewController.swift
//  Pods
//
//  Created by MACBOOKPRO on 17/04/2017.
//
//



import UIKit
import Alamofire
import NVActivityIndicatorView

class PatientDetailsViewController: UIViewController , SideBarDelegate, UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout , UISearchResultsUpdating,  UITableViewDataSource, UITableViewDelegate,NVActivityIndicatorViewable {

    
    @IBOutlet weak var GroupeSanguin1: UILabel!
    @IBOutlet weak var Poids1: UILabel!
    @IBOutlet weak var Taille1: UILabel!
    @IBOutlet weak var Email1: UILabel!
    @IBOutlet weak var LN1: UILabel!
    @IBOutlet weak var FN1: UILabel!
    @IBOutlet weak var FN: UILabel!
    @IBOutlet weak var LN: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Taille: UILabel!
    @IBOutlet weak var Poids: UILabel!
    @IBOutlet weak var GroupeSanguin: UILabel!
    @IBOutlet weak var SensorsGrid: UICollectionView!
    @IBOutlet weak var TreatementView: UIView!
    @IBOutlet weak var MedicalRecord: UIView!
    @IBOutlet weak var TreatmentListView: UITableView!
    @IBOutlet weak var bt_call: UIButton!
    @IBOutlet weak var ajouterTrait: UIButton!
    
    
    let searchController = UISearchController(searchResultsController: nil)
    var TreatmentList = [Treatment]()
    var filteredTreatment = [Treatment]()
    var TreatmentSelected:Treatment?
    var SensorsList = [Sensor]()
    var ActiveSensorsList = [Sensor]()
    var sideBar:SideBar = SideBar()
    var Patient : Patient?
    var SensorSelected : Sensor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Patientselected : Patient? = Patient
        sideBar = SideBar(sourceView: self.view, menuItems: ["Medical Record", "Sensors", " Treatment"])
        sideBar.delegate = self
        print(" Patient: \((Patient?.description)!) ")
        FN.text = " Patient: \((Patient?.FirstName)!) \((Patient?.LastName)!)"
        LN.text = " Email: \((Patient?.Email)!) "
        Email.text = " Cin: \((Patient?.Cin)!) "
        Taille.text = " Height: \((Patient?.Taille)!), Weight: \((Patient?.Poids)!)  "
        Poids.text = " Gender: \((Patient?.sexe)!) "
        GroupeSanguin.text = " Groupe Sanguin: \((Patient?.groupe_sanguin)!) "
        SensorsGrid.isHidden = true
        MedicalRecord.addSubview(FN)
        MedicalRecord.addSubview(LN)
        MedicalRecord.addSubview(Email)
        MedicalRecord.addSubview(Taille)
        MedicalRecord.addSubview(Poids)
        MedicalRecord.addSubview(GroupeSanguin)
        MedicalRecord.addSubview(bt_call)
        TreatementView.addSubview(TreatmentListView)
        TreatementView.addSubview(ajouterTrait)
        SensorsGrid.isHidden = true
        MedicalRecord.isHidden = false
        TreatementView.isHidden = true
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
        
    }

    override func viewDidAppear(_ animated: Bool) {
        //loadSensors()
         TreatmentListView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    
    func sideBarDidSelectButtonAtIndex(_ index: Int) {
        if index == 0{
            MedicalRecord.isHidden = false
            SensorsGrid.isHidden = true
            TreatementView.isHidden = true
            
        } else if index == 1{
            MedicalRecord.isHidden = true
            SensorsGrid.isHidden = false
            TreatementView.isHidden = true
            loadSensors()
            loadSensorsPerPatient()
        }
        else if index == 2 {
            MedicalRecord.isHidden = true
            SensorsGrid.isHidden = true
            TreatementView.isHidden = false
            
        }
    }
    
    /////////////////////////////////////
    
    func loadSensors(){
        
       
        
        let url:String = "http://127.0.0.1:80/pim/Capteurs.php"
        //Alamofire.request(.GET, url, encoding:.JSON).responseJSON
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
            response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSArray
                for item in response { // loop through data items
                    let obj = item as! NSDictionary
                    
                    
                    let nom = obj.object(forKey: "Name")as! String
                    let active = Int(obj.object(forKey: "IsActive")as! String)
                    let idS = Int(obj.object(forKey: "Id")as! String)
                    
                    let capteur = Sensor (aFN: nom, aActive: active, aId: idS)
                    self.SensorsList.append(capteur!)
                }
                //self.SensorsGrid.reloadData()
                
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func loadSensorsPerPatient(){
        
        
        
        var url:String = "http://127.0.0.1:80/pim/SensorPerPatient.php?patId="
        url += String((self.Patient?.id)!)
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
            response in switch response.result {
            case .success(let JSON):
                let response = JSON as! NSArray
                for item in response { // loop through data items
                    let obj = item as! NSDictionary
                    
                    
                    let capteur_id = Int(obj.object(forKey: "capteur_id")as! String)
                    for item in self.SensorsList{
                        if item.SensorId == capteur_id {
                            self.ActiveSensorsList.append(item)
                        }
                        
                    }
                }
                self.SensorsGrid.reloadData()
                
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    /////////////////////////////////////
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ActiveSensorsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "sensorCell", for: indexPath) as! SensorCellCollectionViewCell
        
        let capt = ActiveSensorsList[indexPath.row]
        cell.titleCell.text = capt.SensorName
        cell.imgBG.image = UIImage (named: "dd")
        return cell;
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       /* print("You selected cell #\(indexPath.row)!")*/
         let ind = indexPath.row
         self.SensorSelected = ActiveSensorsList[ind]
        performSegue(withIdentifier: "PatientSensors", sender: self)
        
    }
    
    
    @IBAction func bt_notes(_ sender: AnyObject) {
        
        performSegue(withIdentifier: "notesPatient", sender: self)
    }
    
    
    @IBAction func ajouterTrait(_ sender: AnyObject) {
         performSegue(withIdentifier: "TreatmentAdd", sender: self)
    }
    
    
    @IBAction func bt_rdv(_ sender: AnyObject) {
        performSegue(withIdentifier: "AskRDV", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PatientSensors" {
            
            let destination: PatientSensorsValuesViewController = segue.destination as! PatientSensorsValuesViewController
            /*print("........................")
            print(self.SensorSelected?.description())
            print(Patient?.description)
            print("Fel segue 2 tawa: ......")*/
            destination.ChosenSensor = self.SensorSelected
            destination.ChosenPatient = Patient
            
        }
        else  if segue.identifier == "notesPatient" {
            
            let destination: NotesViewController = segue.destination as! NotesViewController
            destination.Patientselected = Patient
            
        } else  if segue.identifier == "TreatmentPat" {
            
            let destination: TreatmentPatViewController = segue.destination as! TreatmentPatViewController
            destination.Patientselected = Patient
            
        } else  if segue.identifier == "TreatmentDeets" {
            
            let destination: TreatmentDeetsViewController = segue.destination as! TreatmentDeetsViewController
            destination.TreatmentSelected = TreatmentSelected
            
        }  else  if segue.identifier == "TreatmentAdd" {
            
            let destination: AddTraitementViewController = segue.destination as! AddTraitementViewController
            destination.Pat = Patient
            
        } else  if segue.identifier == "AskRDV" {
            
            let destination: AskRDVViewController = segue.destination as! AskRDVViewController
            destination.Pattt = Patient
            
        }
        
        //TreatmAdd
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }

    
   
    @IBAction func bt_call(_ sender: AnyObject) {
        
        if let url = URL(string: "tel://\((self.Patient?.Phone)!)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
           
        }
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
        let patId = (self.Patient?.id)!
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
                     dateFormatter.dateStyle = DateFormatter.Style.long
                     dateFormatter.dateFormat = "yyyy-MM-dd"
                     let date_debut = dateFormatter.date(from: (obj.object(forKey: "date_debut")as! String) )
                     let date_fin = dateFormatter.date(from: (obj.object(forKey: "date_fin")as! String) )
                     
                     let created_at = dateFormatter.date(from: obj.object(forKey: "created_at")as! String)
                     let patientId = Int(obj.object(forKey: "patient_id")as! String)
                     let nbr_fois_jour = Int(obj.object(forKey: "nbr_fois_jour")as! String)
                    
                   

                    let trp = Treatment(aId: idd, Name: nameTr, dateDebut: date_debut, dateFin: date_fin, id_pat: patientId, nbrFois: nbr_fois_jour, createdAt: created_at)
                    print("treatment: \(trp.description)")
                    self.TreatmentList.append(trp)
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
         performSegue(withIdentifier: "TreatmentDeets", sender: self)
        
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
        
        print(treaa)
        let textNote:UILabel = cell.viewWithTag(2750) as! UILabel
        let dateNote:UILabel = cell.viewWithTag(1995) as! UILabel
        let dateDeb:UILabel = cell.viewWithTag(5027) as! UILabel
        let dateFin:UILabel = cell.viewWithTag(9519) as! UILabel
        textNote.text = ("\(treaa.id!)")
        dateNote.text = ("Name: \(treaa.name!)")
        dateDeb.text = ("Start: \(treaa.date_debut!)")
        dateFin.text = ("End: \(treaa.date_fin!)")
        
        return cell
        
    }

    @IBAction func bt_logout(_ sender: AnyObject) {
        
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "Patient_connected")
        print("Test patient session: My defaults removed \(UserDefaults.standard.object(forKey: "Patient_connected"))")
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
    
   
    
}
