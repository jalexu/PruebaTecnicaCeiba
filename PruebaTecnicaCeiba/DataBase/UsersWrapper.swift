//
//  UsersWrapper.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Foundation
import CoreData

final class UsersWrapper {
    static func map(_ input: [NSManagedObject]?) -> [UserModel] {
        var users: [UserModel] = []
        
        if let data = input {
            for userData in data {
                users.append(UserModel(
                                id: userData.value(forKey: "id") as! Int,
                                name: userData.value(forKey: "name") as! String,
                                username: "",
                                email: userData.value(forKey: "email") as! String,
                                address: nil,
                                phone: userData.value(forKey: "phone") as! String,
                                website: "",
                                company: nil))
            }
            return users
        }
        
        return users
       
    }
}
