//
//  TreatmentDeetsViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 17/05/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit

class TreatmentDeetsViewController: UIViewController {

    var TreatmentSelected:Treatment?
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label1.text = "id: \((TreatmentSelected?.id)!)"
        label2.text = "Name: \((TreatmentSelected?.name)!)"
        label3.text = "Starting date: \((TreatmentSelected?.date_debut)!)"
        label4.text = "Ending dat: \((TreatmentSelected?.date_fin)!)"
        label5.text = "Takes per day: \((TreatmentSelected?.nbr_fois_jour)!)"
         label6.text = ""
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
