//
//  AddContactViewController.swift
//  ContactBook
//
//  Created by Sanzhar Koshkarbayev on 06.04.2022.
//

import UIKit
import Realm

class AddContactViewController: UIViewController{

    public var persistance = PersistanceContact()//getting db from contact view controller
    var tableView: UITableView!//getting table view for reload data afted adding contact
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!//segmented control for define gender
    
    @IBOutlet weak var nameTextField: UITextField!//name field
    @IBOutlet weak var phoneNumberTextField: UITextField!//phone number field
    
    override func viewDidLoad() {//default funcion for loading view controller
        super.viewDidLoad()
    }

    @IBAction func saveTapped(_ sender: Any) {//save contact
        let name = nameTextField.text//convert name field to name: String
        let number = phoneNumberTextField.text//convert phine number field to number: String
        
        if number == "" || name == ""{//error if number or name is empty
            let alert = UIAlertController(title: "Error", message: "You did not fill some fields", preferredStyle: .alert)//creating alert
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))//add action OK to alert
            present(alert, animated: true, completion: nil)//present alert
        }
        else {
            self.persistance.addRealm(addNumber: number!, addName: name!, addGender: genderSegmentedControl.selectedSegmentIndex)//adding contact to db
            tableView.reloadData()//realod data of table view
            dismiss(animated: true, completion: nil)//closing view controller
        }
    }
    @IBAction func cancelTapped(_ sender: Any) {//close view controller
        dismiss(animated: true)
    }
    
}
