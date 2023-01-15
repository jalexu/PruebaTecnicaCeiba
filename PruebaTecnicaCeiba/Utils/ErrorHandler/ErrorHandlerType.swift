//
//  ErrorHandlerType.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Foundation

protocol ErrorHandlerType: AnyObject {
    func showError(error: Error)
    func hideConnectivityError()
    func showLostConnectionError()
    func hideLostConnectionError()
}
