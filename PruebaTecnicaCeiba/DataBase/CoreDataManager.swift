//
//  CoreDataManager.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import CoreData
import Combine

final class CoreDataManager: CoreDataManagerType {
    
    func save(with data: UserModel) -> AnyPublisher<Bool, Error> {
        return Future { promise in
            let context = CoreDataService.context
            let entity = NSEntityDescription.entity(forEntityName: "User", in: context)!
            let table = NSManagedObject(entity: entity, insertInto: context)
            
            table.setValue(Int64(data.id), forKey: "id")
            table.setValue(data.name, forKey: "name")
            table.setValue(data.email, forKey: "email")
            table.setValue(data.phone, forKey: "phone")
            do {
                try context.save()
                print("We have been save your user")
                promise(.success(true))
                
            } catch {
                print("Error with data — \(error)")
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
        
    }
    
    func retriveData() -> AnyPublisher<[UserModel], Error> {
        return Future { promise in
            let context = CoreDataService.context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            
            do {
                let result = try context.fetch(fetchRequest)
                let usersData = UsersWrapper.map(result as? [NSManagedObject])
                promise(.success(usersData))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
