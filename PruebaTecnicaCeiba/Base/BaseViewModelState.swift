//
//  BaseViewModelState.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import SwiftUI

open class BaseViewModelState: ObservableObject {
    //MARK: show error
    @Published var alert: Bool = false
    @Published var showConnectionError: Bool = false
    var alertMessageError: AlertMessageError?
}
