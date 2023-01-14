//
//  PruebaTecnicaCeiba+inject.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerCoreDataDependencies()
        registerUserDependencies()
        registerUserPublishingDependencies()
    }
}

