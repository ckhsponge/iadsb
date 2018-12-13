//
//  TableViewController.swift
//  iADSB_Example
//
//  Created by Christopher Hobbs on 10/22/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import iADSB

class TableViewController: UITableViewController, IADSBDelegate {
    
    var manager:IADSB.Manager { return AppDelegate.instance.manager }
    var models = [IADSB.Model]()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.add(delegate: self)
        manager.start()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func update(manager:IADSB.Manager, provider:IADSB.Provider) {
        models = []
        models.append(contentsOf: manager.gpses.array)
        models.append(contentsOf: manager.ahrses.array)
        models.append(contentsOf: manager.barometers.array)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        if index < 0 || index >= models.count {
            return tableView.dequeueReusableCell(withIdentifier: "GPSTableViewCell", for: indexPath)
        }
        let model = models[index]
        var identifier:String
        switch model {
        case is IADSB.GPS:
            identifier = "GPSTableViewCell"
        case is IADSB.Barometer:
            identifier = "BarometerTableViewCell"
        case is IADSB.AHRS:
            identifier = "AHRSTableViewCell"
        default:
            identifier = "GPSTableViewCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let modelCell = cell as? ModelTableViewCell {
            modelCell.update(model)
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
