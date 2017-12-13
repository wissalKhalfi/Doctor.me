//
//  PatientSensorsValuesViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 18/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import Alamofire
import Charts

class PatientSensorsValuesViewController: UIViewController {

    
    var ChosenPatient : Patient?
    var ChosenSensor : Sensor?
    var ListeValeursCapteur : [SensorValue] = []
    var SensorValues = [Float]()
    @IBOutlet weak var barView: BarChartView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("chosen patient")
        print(ChosenPatient?.description)
        print("chosen sensor")
        print(ChosenSensor?.description())
        print("........................")
        loadSensorValue()
        updateChartWithData()
       // let view = [10, 20, 4, 8, 25, 18, 21, 24, 8, 15].lineGraph(GraphRange(min: 0, max: 30)).view(viewFrame)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) { 
        updateChartWithData()
    }

    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        //let visitorCounts = getVisitorCountsFromDatabase()
        for i in 0..<SensorValues.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(SensorValues[i]))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "GSR")
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
    }
    
 
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    /////////////////////////////////////
    
    func loadSensorValue(){
        
        //let patid  : Int = (ChosenPatient?.id)!
        let patid = (self.ChosenPatient?.id)!
        let captId = (self.ChosenSensor?.SensorId)!
        //let m: NSNumber = captId
        //let captId : Int = (ChosenSensor?.SensorId)!
        print("........................")
        print(patid)
        print(captId)
       // print(m)
        print("........................")
       /* let paramSens: Parameters = [
            "patient_id": patid ,
            "capteur_id": captId
        ]*/
        
        
        var url:String = "http://127.0.0.1:80/pim/SensorValue.php?patient_id="
        url += String(patid)
        url += "&capteur_id="
        url += String(captId)
        
        print(url)
        
        
        Alamofire.request(url, method: .get , parameters: nil, encoding: JSONEncoding.default).responseJSON{
            response in
            
            
            /*print("........................")
            print("request text")
            print("........................")
            print(response.request as Any)
            print("........................")
            print("........................")
            print("response text")
            print("........................")
            print(response.response as Any)
            print("........................")
            print("........................")
            print("data text")
            print("........................")
            print(response.data as Any)
            print("........................")
            print("........................")
            print("error text")
            print("........................")
            print(response.error as Any)
            print("........................")
            print("........................")*/
            
            /*response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // URL response
            print(response.result.value as Any)*/
            
            switch response.result {
            case .success(let JSON):
                
                 print("........................")
                 
                 print("........................")
                 print("Request successeded")
                 print("........................")
                 let sensVal1 = SensorValue(id: 1, val: 25, create: nil, captId: 1, patId: 1)
                 
                 self.ListeValeursCapteur.append(sensVal1!)
                 
                let response = JSON as! NSArray
                for item in response {
                    // loop through data items
                    let obj = item as! NSDictionary
                    
                    let Id = Int(obj.object(forKey: "Id")as! String)
                    let value = Float(obj.object(forKey: "value")as! String)
                    let capteur_id = Int(obj.object(forKey: "capteur_id")as! String)
                    let patient_id = Int(obj.object(forKey: "patient_id")as! String)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yy" //Your date format
                    let created_at = dateFormatter.date(from: obj.object(forKey: "CREATED_AT")as! String )
                    
                    
                    let sensVal = SensorValue(id: Id, val: value,  create: created_at, captId: capteur_id, patId: patient_id)
                    
                    print("........................")
                    print(sensVal?.description())
                    print("........................")
                    self.ListeValeursCapteur.append(sensVal!)
                    self.SensorValues.append((sensVal?.SensorVal!)!)
                    
                  //  let capteur = Sensor (aFN: nom, aActive: active, aId: idS)
                    //self.SensorsList.append(capteur!)
                }
                //self.SensorsGrid.reloadData()
                
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    /////////////////////////////////////

}
