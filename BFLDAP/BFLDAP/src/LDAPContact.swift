//
//  LDAPContact.swift
//  BFLDAP
//
//  Created by BACEM FATNASSI on 5/9/2023.
//

import Foundation

public struct LDAPContact: Decodable {
    public let uid: String
    public let homeDirectory: String
    public let uidNumber: String
    public let objectClass: [String]
    public let userPassword: String
    public let loginShell: String
    public let sn: String
    public let cn: String
    public let mail: String
    public let mobile: String
    public let gidNumber: String
    public let gecos: String
}


extension Data {
    
    func parseJSONData() -> [LDAPContact]? {
        do {
            // Parse the JSON data into an array of LDAPContact objects
            let contacts = try JSONDecoder().decode([String: LDAPContact].self, from: self)
            
            // Convert the dictionary of contacts to an array
            let contactArray = Array(contacts.values)
            
            return contactArray
        } catch {
            print("Error parsing JSON data: \(error)")
            return nil
        }
    }

}
