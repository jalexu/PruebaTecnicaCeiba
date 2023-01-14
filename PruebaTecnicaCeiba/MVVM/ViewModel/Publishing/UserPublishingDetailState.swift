//
//  UserPublishingDetailState.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 13/01/23.
//

import SwiftUI

final class UserPublishingDetailState: ObservableObject {
    @Published var listUserPublishig: [UserPublishig] = []
    @Published var alert: Bool = false
}
