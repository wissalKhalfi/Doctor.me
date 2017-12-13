//
//  CalendrierRDVViewController.swift
//  Doctor.me
//
//  Created by MACBOOKPRO on 17/05/2017.
//  Copyright © 2017 ESPRIT. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendrierRDVViewController: UIViewController {

    let formatter = DateFormatter()
    var testCalendar = Calendar.current
    let OutsideMonthColor = UIColor.lightGray
    let MonthColor = UIColor.white
    let SelectedMonthColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    let CurrentDateSelectedViewColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)

    @IBOutlet weak var CalendarView: JTAppleCalendarView!
    @IBOutlet weak var MonthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CalendarView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
       // CalendarView.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleCellSelection(view: JTAppleCell?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarCelulle else {return }
       
        if myCustomCell.isSelected {
            myCustomCell.SelectedView.layer.cornerRadius =  20
            myCustomCell.SelectedView.isHidden = false
        } else {
            myCustomCell.SelectedView.isHidden = true
        }
    }

    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarCelulle  else {
            return
        }
        
        if cellState.isSelected {
            myCustomCell.dateLabel.textColor = CurrentDateSelectedViewColor
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                myCustomCell.dateLabel.textColor = MonthColor
            } else {
                myCustomCell.dateLabel.textColor = OutsideMonthColor
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if let firstDateInfo = CalendarView.visibleDates().indates.first {
            CalendarView.viewWillTransition(to: size, with: coordinator, focusDateIndexPathAfterRotate: firstDateInfo.indexPath)
        } else {
            let firstDateInfo = CalendarView.visibleDates().monthDates.first!
            CalendarView.viewWillTransition(to: size, with: coordinator, focusDateIndexPathAfterRotate: firstDateInfo.indexPath)
        }
        
        
        
    }
}

extension CalendrierRDVViewController:  JTAppleCalendarViewDelegate  {
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

extension CalendrierRDVViewController:  JTAppleCalendarViewDataSource  {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let myCustomCell = calendar.dequeueReusableCell(withReuseIdentifier: "CalndrierCell", for: indexPath) as! CalendarCelulle
        
        myCustomCell.dateLabel.text = cellState.text
        
        
        if testCalendar.isDateInToday(date) {
            myCustomCell.backgroundColor = #colorLiteral(red: 0.5896322727, green: 0.7361348867, blue: 0.7528523207, alpha: 1)
        } else {
            myCustomCell.backgroundColor = #colorLiteral(red: 0.03127952665, green: 0.4629898667, blue: 0.5797452927, alpha: 1)
        }

        
        self.handleCellTextColor(view: myCustomCell, cellState: cellState)
        self.handleCellSelection(view: myCustomCell, cellState: cellState)
        
        
        return myCustomCell
    }
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        print("dateSelected: ")
        print(date.description)
        self.handleCellSelection(view: cell, cellState: cellState)
        self.handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        
        self.handleCellSelection(view: cell, cellState: cellState)
        self.handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
    }
    
    func scrollDidEndDecelerating(for calendar: JTAppleCalendarView) {
        let visibleDates = self.CalendarView.visibleDates()
        self.setupViewsOfCalendar(from: visibleDates)
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        let month = testCalendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month-1) % 12]
        // 0 indexed array
        let year = testCalendar.component(.year, from: startDate)
        MonthLabel.text = monthName
        yearLabel.text = String(year)
    }
   
    
}




