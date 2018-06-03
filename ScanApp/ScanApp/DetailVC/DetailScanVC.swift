//
//  DetailScanVC.swift
//  ScanApp
//
//  Created by Macintosh HD on 5/31/18.
//  Copyright © 2018 google. All rights reserved.
//

import UIKit
import Contacts

class DetailScanVC : UIViewController,UITableViewDelegate,UITableViewDataSource{
    var detailPerson = [[Person]]()
    var number: Int = 0
    var selectedIndexPath : Int?
    
    @IBOutlet var tbvContact: UITableView!
    @IBAction func deletePerson(_ sender: Any) {
        let store = CNContactStore()
        let req = CNSaveRequest()
        let mutableContact = personParam![selectedIndexPath!].info.mutableCopy() as! CNMutableContact
        
        req.delete(mutableContact)
        do{
            try store.execute(req)
            print("Success, You deleted the user")
        } catch let e{
            print("Error = \(e)")
        }

        personParam?.remove(at: selectedIndexPath!)
        tbvContact.reloadData()

    }
    var personParam : [Person]?
    override func viewDidLoad() {
    
     
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return (personParam?.count)!
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showdetail", for: indexPath) as! DetailScanCell
        cell.name.text = personParam![indexPath.row].info.givenName
        print(personParam![indexPath.row].info.givenName)
        cell.phone.text = personParam![indexPath.row].numberPhone
        if let emailValue : CNLabeledValue = personParam![indexPath.row].info.emailAddresses.first
        {
            cell.email.text = emailValue.value as String
            
        }
        
        
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath.row
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
