//
//  DoctorCalendarViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 13/05/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DoctorCalendarViewController: UIViewController {

   
    let formatter = DateFormatter()
    var testCalendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    }
    extension DoctorCalendarViewController:  JTAppleCalendarViewDelegate  {
        func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
            
            formatter.dateFormat = "yyyy MM dd"
            formatter.timeZone = testCalendar.timeZone
            formatter.locale = testCalendar.locale
            
            
            let startDate = formatter.date(from: "2017 01 01")!
            let endDate = formatter.date(from: "2018 02 01")!
            
            let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
            return parameters
        }
        
    }
    
    extension DoctorCalendarViewController:  JTAppleCalendarViewDataSource  {
        func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
            
            let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CalendarCellule", for: indexPath) as! CustomCell
            
            myCustomCell.dateLabel.text = cellState.text
            return myCustomCell
        }
        func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
            
            guard let validCell = cell as? CustomCell else {return }
            //validCell.SelectedView.layer.cornerRadius = 20
            //validCell.SelectedView.isHidden = false
            print("Selected cell")
        }
        
        
    }
    
   


