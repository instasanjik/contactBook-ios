//
//  Persistance.swift
//  ContactBook
//
//  Created by Sanzhar Koshkarbayev on 06.04.2022.
//


//db- database

import Foundation
import RealmSwift

class Contacts: Object{//creating object for realm
    @objc dynamic var phoneNumber:String = ""
    @objc dynamic var name:String = ""
    @objc dynamic var gender: Int = 0
}

class PersistanceContact {//class for adding realm
    
    let realm = try! Realm()
    
    var arrayPhone = [Contacts().phoneNumber]//db arrays
    var arrayName = [Contacts().name]
    var arrayGender = [Contacts().gender]
    
    var allData: Results<Contacts> {//get data
        let realm = try! Realm()
        return realm.objects(Contacts.self)
    }
    
    
    func addRealm(addNumber:String, addName: String, addGender: Int) {//add to db
        let add = Contacts()
        add.name = addName
        add.phoneNumber = addNumber
        add.gender = addGender

        try! realm.write{
            realm.add(add)
        }
    }

    func loadRealm() {//reload db
        arrayPhone = []
        arrayName = []
        arrayGender = []

        let allRealm = realm.objects(Contacts.self)
    
        for note in allRealm {
            arrayPhone.append(note.phoneNumber)
            arrayName.append(note.name)
            arrayGender.append(note.gender)
        }
    }
        
    func deleteRealm(delete: Contacts) {//delete from db
        try! realm.write{
            realm.delete(delete)
        }
    }
    
}
