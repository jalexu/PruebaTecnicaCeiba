//
//  PruebaTecnicaCeibaApp.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import SwiftUI
import Resolver

@main
struct PruebaTecnicaCeibaApp: App {
    private var viewModel = Resolver.resolve(UserViewModel.self)
    
    var body: some Scene {
        WindowGroup {
            UsersView(viewModel: viewModel)
        }
    }
}
