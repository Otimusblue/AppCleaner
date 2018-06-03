//
//  Person.swift
//  ScanApp
//
//  Created by Macintosh HD on 5/31/18.
//  Copyright © 2018 google. All rights reserved.
//


import UIKit
import Contacts

class Person{
    var info : CNContact
    var id : Int
    var numberPhone : String?
    
    init(info : CNContact, numberPhone : String,id : Int){
        self.id = id
        self.numberPhone = numberPhone
        self.info = info
    }
}
var myPerson = [Person]()
