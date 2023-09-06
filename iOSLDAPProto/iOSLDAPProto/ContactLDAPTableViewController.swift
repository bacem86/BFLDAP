//
//  ContactLDAPTableViewController.swift
//  iOSLDAPProto
//
//  Created by BACEM FATNASSI on 5/9/2023.
//

import UIKit
import BFLDAP

class ContactLDAPTableViewController: UITableViewController,UISearchBarDelegate {

    var contacts:[LDAPContact] = []
    let searchBar:UISearchBar = UISearchBar()
    var loader:LDAPContactLoader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let configuration = LDAPContactLoaderConfiguration(binddn: "your biddn here",
                                                           password: "your password here",
                                                           host: "your host ip here",
                                                           scope: .SUBTREE,                                                           
                                                           useTLS: false,
                                                           base: "your base here")
        
        
        self.loader = LDAPContactLoader(configuration: configuration)
        self.loader?.limitation = 10
        
        self.loader?.connect(completion: { error in
            
        })
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        
        
        searchBar.frame = CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: 44))
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        tableView.tableHeaderView = searchBar
        

    }

    
    // Implement the UISearchBarDelegate methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            search(keyWord: searchText)
    }

    
    func search(keyWord:String){
        
        guard let loader else {
            return
        }
        
            
        
        
        loader.search(keyWord: keyWord) { contacts in
            
            DispatchQueue.main.async {
                self.contacts = contacts
                self.tableView.reloadData()
            }
            
        }
            
        
          

        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if self.contacts.count == 0 {
            return 1
        }
        
        return self.contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        if self.contacts.count > indexPath.row {
            let contact = self.contacts[indexPath.row]
            cell.textLabel?.textAlignment = .natural
            cell.textLabel?.text = contact.cn
            cell.textLabel?.textColor = .label
        }else{
            cell.textLabel?.textColor = .gray
            cell.textLabel?.textColor = .gray
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.text = "No contact found"
        }
        
        
        
        
        return cell
    }
    

    
}
