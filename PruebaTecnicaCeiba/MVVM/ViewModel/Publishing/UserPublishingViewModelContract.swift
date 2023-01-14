//
//  UserPublishingViewModelContract.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import Foundation

protocol UserPublishingViewModelType: ObservableObject, Identifiable {
    var state: UserPublishingDetailState { get set }
    func getUserPublishing()
}
