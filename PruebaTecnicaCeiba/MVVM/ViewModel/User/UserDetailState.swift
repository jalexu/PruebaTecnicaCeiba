//
//  UserDetailState.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import SwiftUI

final class UserDetailState: ObservableObject {
    @Published var users: [UserModel] = []
}
