//
//  Resolver+Test.swift
//  PruebaTecnicaCeibaTests
//
//  Created by Jaime Uribe on 15/01/23.
//

import Resolver
@testable import PruebaTecnicaCeiba

extension Resolver {
    static var mock = Resolver(child: .main)
    
    //MARK: Register stub or mock service
    static func registerMockServices() {
        root = Resolver.mock
        defaultScope = .application
        Resolver.mock.register { UserInteractorStub() }
          .implements(AnyInteractorStub<Any?, [UserModel]>.self)
        
    }
}
