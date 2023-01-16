//
//  AlertMessageError.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Foundation
struct AlertMessageError {
    var title: String
    var message: String
    var cancelButtonMessage: String
    
    static var `default`: AlertMessageError {
        .init(title: "Error",
              message: "La aplicación presenta un error, Por favor intenta más tarde.",
              cancelButtonMessage: "Ok")
    }
}
