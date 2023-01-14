//
//  UserContract.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import SwiftUI

protocol UserViewModelType: ObservableObject, Identifiable {
    var state: UserDetailState { get set }
    func getUserService()
}
