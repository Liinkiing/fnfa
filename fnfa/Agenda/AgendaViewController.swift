//
//  AgendaViewController.swift
//  fnfa
//
//  Created by JBARA Omar on 15/02/2018.
//  Copyright © 2018 JBARA Omar. All rights reserved.
//

import UIKit

class AgendaViewController: UITableViewController {

    
    private let reuseIdentifier = UUID().uuidString

    private var days = [
        Date(timeIntervalSince1970: 1522792800), // 4 Février 2018, 00:00
        Date(timeIntervalSince1970: 1522879200), // 5 Février 2018, 00:00
        Date(timeIntervalSince1970: 1522965600), // 6 Février 2018, 00:00
        Date(timeIntervalSince1970: 1523052000), // 7 Février 2018, 00:00
        Date(timeIntervalSince1970: 1523138400)  // 8 Février 2018, 00:00
    ]
    private let dateFormatter = DateFormatter()
    private let locale = Locale(identifier: "fr_FR")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        dateFormatter.locale = locale
        tableView.register(UINib(nibName: "AgendaTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! AgendaTableViewCell
        cell.day = days[indexPath.section]
        print(dateFormatter.string(from: days[indexPath.section]))
        return cell
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = super.tableView(tableView, viewForHeaderInSection: section)
        view?.backgroundColor = #colorLiteral(red:0.1175380871, green:0.1734368503, blue:0.310670346, alpha:1)

        return view
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if (view is UITableViewHeaderFooterView) {
            let header = view as! UITableViewHeaderFooterView
            dateFormatter.setLocalizedDateFormatFromTemplate("EEEE d")
            header.textLabel?.text = dateFormatter.string(from: days[section]).capitalized(with: locale)
            header.textLabel?.textAlignment = .center
            header.textLabel?.textColor = #colorLiteral(red:1.0, green:1.0, blue:1.0, alpha:1.0)
        }
    }

}
