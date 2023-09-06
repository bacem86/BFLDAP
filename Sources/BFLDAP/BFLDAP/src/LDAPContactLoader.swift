//
//  LDAPContactLoader.swift
//  BFLDAP
//
//  Created by BACEM FATNASSI on 5/9/2023.
//

import Foundation


public struct LDAPContactLoaderConfiguration {
   
    public init(binddn: String,
                password: String,
                host: String,
                scope:LDAP.Scope = .BASE,
                useTLS: Bool,
                base: String) {
        self.binddn = binddn
        self.scope = scope
        self.password = password
        self.host = host
        self.useTLS = useTLS        
        self.base = base
    }
    
    public var scope:LDAP.Scope = .BASE
    public var binddn:String
    public var password:String
    public var host:String
    public var useTLS:Bool
    public var filter:String?
    public var base:String
    
}

public class LDAPContactLoader {
    
    
    let queue  = DispatchQueue(label: "ldap_contact_loader")
    private var connection:LDAP?
    
    
    public private(set) var configuration:LDAPContactLoaderConfiguration
    
    public var filter:String?
    
    public var limitation:Int = 100 {
        didSet{
            self.connection?.limitation = limitation
        }
    }
    
    
    public init(configuration: LDAPContactLoaderConfiguration) {
        self.configuration = configuration
    }
    
    
    public func connect(completion: @escaping (Error?) -> Void) {
        self.queue.async {
            do {
                try self.setUp()
                completion(nil) // Success, so call the completion handler with no error.
            } catch {
                completion(error) // Pass any error encountered to the completion handler.
            }
        }
    }
    
    
    public func search(keyWord:String,completion:@escaping(_ contacts:[LDAPContact])->Void){
        
        self.queue.async {
            
            guard let connection = self.connection else {
                return
            }
            
            
            let defaultFilter = self.filter ?? "(&(objectClass=person)(|(cn=*\(keyWord)*)(mobile=*\(keyWord)*)))"
            
            
            
            connection.search(base:self.configuration.base,
                              filter:defaultFilter,
                              scope:self.configuration.scope,
                              completion:{ result in
                
                
                print(result)
                
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: result, options: .fragmentsAllowed)
                    
                    let contacts = data.parseJSONData() ?? []
                    
                    completion(contacts)
                }catch {
                    print(error)
                }
              
                
                
            })
            
        }
        
        
    }
    
    private func setUp() throws{
        
        let prefix = self.configuration.useTLS ? "ldaps://" : "ldap://"
        let credential = LDAP.Login(binddn: self.configuration.binddn, password: self.configuration.password)
        connection = try LDAP(url: "\(prefix)\(self.configuration.host)",loginData:credential)
        connection?.limitation = self.limitation
    }
    
}

