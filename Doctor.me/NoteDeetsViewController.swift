//
//  NoteDeetsViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 29/04/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit

class NoteDeetsViewController: UIViewController {

    var NoteSelected: NotePatient?
    @IBOutlet weak var textnote: UITextView!
    @IBOutlet weak var datenote: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        textnote.text = NoteSelected?.remarque
        textnote.isEditable = false
        datenote.text = NoteSelected?.dateR
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
