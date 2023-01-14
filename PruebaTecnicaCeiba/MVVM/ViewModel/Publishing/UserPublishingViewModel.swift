//
//  UserPublishingViewModel.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Foundation
import Combine
import Resolver

final class UserPublishingViewModel: BaseViewModel {
    private let user: UserModel
    private let userPublishingInteractor: AnyInteractor<Int, [UserPublishig]>
    private var subscribers: Set<AnyCancellable> = []
    
    @Published var state = UserPublishingDetailState()
    
    init(user: UserModel,
         userPublishingInteractor: AnyInteractor<Int, [UserPublishig]>) {
        self.user = user
        self.userPublishingInteractor = userPublishingInteractor
    }
    
    private func updateState(updater: () -> Void) {
        updater()
        objectWillChange.send()
    }
    
    private func getPublishing() {
        loading = true
        userPublishingInteractor.execute(params: user.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.loading = false
            }, receiveValue: { [weak self] publishigValues in
                self?.loading = false
                self?.updateState {
                    self?.state.listUserPublishig = publishigValues
                }
            })
            .store(in: &subscribers)
    }
}

extension UserPublishingViewModel: UserPublishingViewModelType {
    func getUserPublishing() {
        getPublishing()
    }
}
