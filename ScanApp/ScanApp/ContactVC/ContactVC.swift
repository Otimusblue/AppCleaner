//
//  ContactVC.swift
//  ScanApp
//
//  Created by Macintosh HD on 5/30/18.
//  Copyright © 2018 google. All rights reserved.
//

import UIKit
import Contacts
class ContactVC : UIViewController, UITableViewDelegate, UITableViewDataSource{
    var myContact : [CNContact] = []
    
    //fetch data from delegate
    override func viewDidLoad() {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        myContact = appdelegate.fetchDataContact
        
        
    }
    
    var array : [String] = ["Hieu","Ngoc","Tran"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myContact.count
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactCell
        let contact: CNContact = myContact[indexPath.row]
        cell.myImage.layer.cornerRadius = cell.myImage.frame.size.width / 2
        if let name: String = contact.givenName {
            //cell.myName.text = contact.givenName
            cell.myName.text = name
        }
        if let phoneObj:CNPhoneNumber = contact.phoneNumbers.first?.value {
            if let number:String = phoneObj.value(forKey: "digits") as? String {
                cell.myNumber.text = number
            }
        }
        
        if let imageData = contact.thumbnailImageData {
            cell.myImage.image = UIImage(data: imageData)
        } else {
            print("No image available")
        }
        
        
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show" {
            if let destination = segue.destination as? ScanVC{
                destination.array = array
//                destination.scanArray = myContact
            }
        }
    }
}
