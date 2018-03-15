//
//  AgendaViewController.swift
//  fnfa
//
//  Created by JBARA Omar on 15/02/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit

class AgendaViewController: UITableViewController {

    private var days = [
        Date(timeIntervalSince1970: 1522836000), // 4 Avril 2018, 12:00
        Date(timeIntervalSince1970: 1522922400), // 5 Avril 2018, 12:00
        Date(timeIntervalSince1970: 1523008800), // 6 Avril 2018, 12:00
        Date(timeIntervalSince1970: 1523095200), // 7 Avril 2018, 12:00
        Date(timeIntervalSince1970: 1523181600)  // 8 Avril 2018, 12:00
    ]
    private var eventsDays: [Date] = []
    private let dateFormatter = DateFormatter()
    private let locale = Locale(identifier: "fr_FR")
    
    override func awakeFromNib() {
        refresh()
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .FAVORITE_ADD, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .FAVORITE_REMOVE, object: nil)
    }
    
    @objc func refresh() {
        eventsDays = []
        for day in days {
            if let firstEventOfDay = DataMapper.instance.getSavedFavorites().soonest(forDay: day) {
                print("\(day) : \(firstEventOfDay)")
                eventsDays.append(firstEventOfDay.startingDate.getDate())
            }
        }
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        dateFormatter.locale = locale
        tableView.register(UINib(nibName: String(describing: AgendaTableViewCell.self), bundle: nil),
                forCellReuseIdentifier: String(describing: AgendaTableViewCell.self))
        NotificationCenter.default.addObserver(self, selector: #selector(onEventTapped), name: .AGENDA_EVENT_TAPPED, object: nil)
    }

    @objc
    func onEventTapped(_ notification: Notification) {
        performSegue(withIdentifier: "eventDetail", sender: notification.object)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "eventDetail") {
            let destination = segue.destination as! ProgrammeDetailViewController
            destination.event = sender as! Event
        }
    }
}

extension AgendaViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = tableView.dequeueReusableCell(withIdentifier: String(describing: AgendaTableViewCell.self),
                                                for: indexPath) as! AgendaTableViewCell
        row.day = eventsDays[indexPath.section]
        return row
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return eventsDays.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if (view is UITableViewHeaderFooterView) {
            let header = view as! UITableViewHeaderFooterView
            dateFormatter.setLocalizedDateFormatFromTemplate("EEEE d")
            header.textLabel?.text = dateFormatter.string(from: eventsDays[section]).capitalized(with: locale)
            header.textLabel?.textAlignment = .center
            header.backgroundView?.backgroundColor = #colorLiteral(red: 0.2236568574, green: 0.2233459969, blue: 0.4078362944, alpha: 1)
            header.backgroundView?.alpha = 0.9
            header.textLabel?.textColor = #colorLiteral(red:1.0, green:1.0, blue:1.0, alpha:1.0)
        }
    }
}
