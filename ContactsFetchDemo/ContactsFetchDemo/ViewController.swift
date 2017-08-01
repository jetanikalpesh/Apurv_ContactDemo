//
//  ViewController.swift
//  ContactsFetchDemo
//
//  Created by Apurv on 28/02/17.
//  Copyright © 2017 Apurv. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
               // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        (UIApplication.shared.delegate as! AppDelegate).requestForAccess { (status) in
            if status == true{
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactEmailAddressesKey, CNContactBirthdayKey]
                
                // Get all the containers
                var allContainers: [CNContainer] = []
                do {
                    allContainers = try (UIApplication.shared.delegate as! AppDelegate).contactStore.containers(matching: nil)
                } catch {
                    print("Error fetching containers")
                }
                
                var results: [CNContact] = []
                
                // Iterate all containers and append their contacts to our results array
                for container in allContainers {
                    let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
                    
                    do {
                        let containerResults = try (UIApplication.shared.delegate as! AppDelegate).contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keys as [CNKeyDescriptor])
                        results.append(contentsOf: containerResults)
                        print(results)
                        print(results[0].givenName)
                        
                        
                    } catch {
                        print("Error fetching results for container")
                    }
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

