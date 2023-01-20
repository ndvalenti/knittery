//
//  RootViewModel.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-22.
//

import Combine
import Foundation

enum LoginState: String {
    case loading
    case authenticated
    case unauthenticated
}

class RootViewModel: ObservableObject {
    @Published var sessionData = SessionData()
    @Published private(set) var state: LoginState = .loading
    @Published var selectedSearchMode: SearchModes = .advanced
    private var networkHandler = NetworkHandler()
    private var cancellables = Set<AnyCancellable>()
    
    func checkAuthenticationState() {
        networkHandler.refreshAccessToken() { [weak self] success in
            if success {
                self?.retrieveCurrentUser()
                self?.state = .authenticated
            } else {
                self?.state = .unauthenticated
            }
        }
    }
    
    func signIn() {
        sessionData.networkHandler = networkHandler
        networkHandler.signIn() { [weak self] success in
            if success {
                self?.retrieveCurrentUser()
                self?.state = .authenticated
            } else {
                self?.state = .unauthenticated
            }
        }
    }
    
    func retrieveCurrentUser() {
        NetworkHandler.requestCurrentUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Error fetching user: \(error)")
                default: return
                }
            }, receiveValue: { [weak self] user in
                self?.sessionData.currentUser = user
                self?.sessionData.signOutDelegate = self
                self?.sessionData.populateQueries()
				self?.sessionData.setUpDefaults()
            })
            .store(in: &cancellables)
    }
}

extension RootViewModel: SignOutDelegate {
    func signOut() {
        networkHandler.signOut()
        sessionData.clearData()
        KeychainHandler.deleteToken(.access)
        KeychainHandler.deleteToken(.refresh)
        KeychainHandler.deleteToken(.library)
        state = .unauthenticated
        print("Invalidated Session")
    }
}

public protocol SignOutDelegate: AnyObject {
    func signOut()
}
