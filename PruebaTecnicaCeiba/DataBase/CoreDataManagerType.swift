//
//  CoreDataManagerType.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Foundation
import Combine

protocol CoreDataManagerType {
    func save(with data: UserModel) -> AnyPublisher<Bool, Error>
    func retriveData() -> AnyPublisher<[UserModel], Error>
}
