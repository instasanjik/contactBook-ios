//
//  TableViewController.swift
//  ContactBook
//
//  Created by Sanzhar Koshkarbayev on 06.04.2022.
//

import UIKit

class TableViewController: UITableViewController {
    
    public var persistance = PersistanceContact()//creating db
    
    @IBAction func addButtom(_ sender: Any) {//add contact button
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {//loading data after load view controller
        super.viewDidLoad()
        self.persistance.loadRealm()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {//number of cells in table view
        return persistance.allData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//creating cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "book", for: indexPath) as! TableViewCell
        cell.nameLabel.text = persistance.allData[indexPath.row].name//filling name
        cell.phoneLabel.text = persistance.allData[indexPath.row].phoneNumber//filling phone number
        if persistance.allData[indexPath.row].gender == 0{//filling main photo
            cell.photoImageView.image = UIImage(named: "womanIcon")
        }else{
            cell.photoImageView.image = UIImage(named: "manIcon")
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {//deleting contact
        if editingStyle == .delete {
            persistance.deleteRealm(delete: persistance.allData[indexPath.row])
            persistance.loadRealm()
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {//deactivate cell after select
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {//heigth for cells
        return 71.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {//sending data to another view controller(add contact)
        guard segue.identifier == "goToAddContact" else { return }
        guard let destination = segue.destination as? AddContactViewController else { return }
        destination.persistance = persistance
        destination.tableView = tableView
    }
}
