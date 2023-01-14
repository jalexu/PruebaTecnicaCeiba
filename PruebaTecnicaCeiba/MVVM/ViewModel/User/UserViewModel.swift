//
//  UserViewModel.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Foundation
import Combine
import SwiftUI

final class UserViewModel: BaseViewModel {
    
    private let getUsersInteractor: AnyInteractor<Any?, [UserModel]>
    
    private var subscribers: Set<AnyCancellable> = []
    
    @Published var state = UserDetailState()
    
    init(getUsersInteractor: AnyInteractor<Any?, [UserModel]>) {
        self.getUsersInteractor = getUsersInteractor
    }
    
    private func updateState(updater: () -> Void) {
        updater()
        objectWillChange.send()
    }
    
    private func getUser() {
        getUsersInteractor.execute(params: nil)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.loading = false
            }, receiveValue: { [weak self] users in
                self?.loading = false
                self?.updateState {
                    self?.state.users = users
                }
            })
            .store(in: &subscribers)
    }
}

extension UserViewModel: UserViewModelType  {
    func getUserService() {
        getUser()
    }
}

