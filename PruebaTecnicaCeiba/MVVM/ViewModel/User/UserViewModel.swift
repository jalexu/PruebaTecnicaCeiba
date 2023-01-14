//
//  UserViewModel.swift
//  PruebaTecnicaCeiba
//
//  Created by Jaime Uribe on 14/01/23.
//

import Foundation
import Combine
import SwiftUI
import Resolver

final class UserViewModel: BaseViewModel {
    
    private let getUsersInteractor: AnyInteractor<Any?, [UserModel]>
    private let coreDataInteractor: CoreDataRepositoryType
    
    private var subscribers: Set<AnyCancellable> = []
    
    @Published var state = UserDetailState()
    
    init(getUsersInteractor: AnyInteractor<Any?, [UserModel]>,
         coreDataInteractor: CoreDataRepositoryType) {
        self.getUsersInteractor = getUsersInteractor
        self.coreDataInteractor = coreDataInteractor
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
                self?.saveOnCoreData(with: users)
                self?.loading = false
                self?.updateState {
                    self?.state.users = users
                }
            })
            .store(in: &subscribers)
    }
    
    private func saveOnCoreData(with usersData: [UserModel]) {
        self.loading = true
        for data in usersData {
            coreDataInteractor.save(with: data)
                .sink(receiveCompletion: { [weak self] completion in
                    guard case .failure(let error) = completion else { return }
                    self?.loading = false
                    print(error.localizedDescription)
                }, receiveValue: { [weak self] _ in
                    self?.loading = false
                    print("User has been save on coreData")
                }).store(in: &subscribers)
        }
    }
    
    private func getUserFromCoreData() {
        coreDataInteractor.retriveData()
            .sink(receiveCompletion: { [weak self] completion in
                guard case .failure(let error) = completion else { return }
                self?.loading = false
                print(error.localizedDescription)
            }, receiveValue: { [weak self] dataUsers in
                self?.loading = false
                self?.validateUserOnCoreData(dataUsers)
            }).store(in: &subscribers)
    }
    
    private func validateUserOnCoreData(_ users: [UserModel]) {
        if users.isEmpty {
            getUser()
        } else {
            updateState {
                state.users = users
            }
        }
    }
}

extension UserViewModel: UserViewModelType  {
    func getUserService() {
        getUserFromCoreData()
    }
    
    func getUserPublishingViewModel(user: UserModel) -> UserPublishingViewModel {
        UserPublishingViewModel(user: user,
                                userPublishingInteractor: Resolver.resolve(UserPublishingInteractor.self))
    }
}

