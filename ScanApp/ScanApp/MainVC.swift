//
//  MainVC.swift
//  ScanApp
//
//  Created by Macintosh HD on 5/30/18.
//  Copyright © 2018 google. All rights reserved.
//

import UIKit
import Contacts

class MainVC : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var results: [CNContact] = []
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactMiddleNameKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor,CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactImageDataAvailableKey as CNKeyDescriptor,CNContactThumbnailImageDataKey as CNKeyDescriptor])
        
        fetchRequest.sortOrder = CNContactSortOrder.userDefault
        
        let store = CNContactStore()
        
        
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { (contact, stop) -> Void in
                //      print(contact.phoneNumbers.first?.value ?? "no")
                results.append(contact)
                
            })
        }
        catch let error as NSError {
            //   print(error)
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.fetchDataContact.append(contentsOf: results)
}
    
}
