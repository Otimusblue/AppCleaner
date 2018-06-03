//
//  ScanVC.swift
//  ScanApp
//
//  Created by Macintosh HD on 5/30/18.
//  Copyright © 2018 google. All rights reserved.
//

import UIKit
import Contacts

class ScanVC : UIViewController{
    var dupArray : [String] = []
    var scanArray : [CNContact] = []
    var duplicateNumber : [String] = []
    var dataPerson = [[Person]]()
    
    @IBOutlet var tbvScanVC: UITableView!
    var email = ["1","2","3"]
    var name = ["1","2","3"]
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var selected = 0
    var personParamater : [Person]?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getContacts()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //them data vao Person
    }
    
    func getContacts() {
        var results: [CNContact] = []
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactMiddleNameKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor,CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactImageDataAvailableKey as CNKeyDescriptor,CNContactThumbnailImageDataKey as CNKeyDescriptor])
        
        fetchRequest.sortOrder = CNContactSortOrder.userDefault
        
        let store = CNContactStore()
        
        
        do {

            try store.enumerateContacts(with: fetchRequest, usingBlock: { (contact, stop) -> Void in
                //      print(contact.phoneNumbers.first?.value ?? "no")
                results.append(contact)
                //
            })
        }
        catch let error as NSError {
            //   print(error)
        }

        scanArray.removeAll()
        dataPerson.removeAll()
        myPerson.removeAll()
        duplicateNumber.removeAll()
        dupArray.removeAll()
        scanArray.append(contentsOf: results)
        self.prepareDatas()
    }
    
    func prepareDatas() {
        
        
        for number in 0...scanArray.count - 1{
            let mycontact = scanArray[number]
            for ContctNumVar: CNLabeledValue in mycontact.phoneNumbers
            {
                let MobNumVar  = (ContctNumVar.value as! CNPhoneNumber).value(forKey: "digits") as? String
                myPerson.append(Person(info: mycontact, numberPhone: MobNumVar!, id: number))
            }
        }
        //doi numberPhone sang String
        for number in 0..<myPerson.count{
            
            let string = myPerson[number].numberPhone
            let newstring = string?.digits
            myPerson[number].numberPhone = newstring!
            // print(myPerson[number].numberPhone!)
        }
        //tach lay number sang mang String
        for i in 0..<myPerson.count{
            duplicateNumber.append(myPerson[i].numberPhone!)
        }
        // sap xep
        var sorted = duplicateNumber.sorted {$0.localizedStandardCompare($1) == .orderedAscending}
        //
        sorted.append("0")
        var i = 0, j = 1
        while (j < sorted.count - 1){
            if(sorted[i] == sorted[j] && sorted[i] != sorted[j+1]){
                dupArray.append(sorted[i])
                i += 1
                j += 1
            } else if(sorted[i] == sorted[j] && sorted[i] == sorted[j+1]){
                i += 1
                j += 1
            } else if(sorted[i] != sorted[j]){
                i += 1
                j += 1
            }
        }
        //kiem tra cac so trung
        for _ in dupArray
        {
            dataPerson.append([Person]())
        }
        for i in 0..<dupArray.count{
            for j in 0..<myPerson.count{
                if(dupArray[i] == myPerson[j].numberPhone){
                    dataPerson[i].append(myPerson[j])
                }
            }
        }
        tbvScanVC.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    @IBOutlet var tbv: UITableView!
    @IBOutlet var myBtn: UIButton!
    @IBAction func Choose(_ sender: Any) {
        let ac = UIAlertController(title: nil,
                                   message: nil,
                                   preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let phoneNumberAlert = UIAlertAction(title: "Phone Number", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.selected = 0
            self.myBtn.setTitle("Phone Number", for:.normal)
            self.tbv.reloadData()
        })
        let emailAlert = UIAlertAction(title: "Email", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.selected = 1
            self.myBtn.setTitle("Email", for:.normal)
            self.tbv.reloadData()
        })
        let nameAlert = UIAlertAction(title: "Name", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.myBtn.setTitle("Name", for:.normal)
            self.selected = 2
            self.tbv.reloadData()
        })
        
        
        ac.addAction(cancelAction)
        ac.addAction(phoneNumberAlert)
        ac.addAction(emailAlert)
        ac.addAction(nameAlert)
        // ac.addAction()
        
        present(ac, animated: true, completion: nil)
        
    }
    //xong phan choices
    
    var array : [String] = []
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "hello"{
            if let destination = segue.destination as? DetailScanVC{
             //   destination.personParam? = personParamater!
                let row = (sender as! NSIndexPath).row;
                personParamater = dataPerson[row]
                destination.personParam = personParamater
            }
        }
    }
    
}

//MARK: - tableview delegate
extension ScanVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selected {
        case 0:
            return dataPerson.count
            
        case 1:
            return email.count
        case 2:
            return name.count
        default:
            return array.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scancell", for: indexPath) as! ScanCell
        switch selected {
        case 0:
            // cell.Number.text = array[indexPath.row]
            cell.Number.text = dataPerson[indexPath.row][0].numberPhone?.digits
            cell.count.text = "\(dataPerson[indexPath.row].count)"
            
        case 1:
            cell.Number.text = email[indexPath.row]
        case 2:
            cell.Number.text = name[indexPath.row]
        default:
            // cell.Number.text = array[indexPath.row]
            cell.Number.text = dataPerson[indexPath.row][0].numberPhone?.digits
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "hello", sender: indexPath)
    }
}
