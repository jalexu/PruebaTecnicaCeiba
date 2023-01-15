//
//  ConnectionRetryable.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Foundation

protocol ConnectionRetryable: AnyObject {
    func tryAgain()
}
