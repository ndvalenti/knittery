//
//  RootViewModel.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-22.
//

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
    var networkHandler = NetworkHandler()
    
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
        NetworkHandler.requestCurrentUser() { [weak self] (result: Result<User, ApiError>) in
            switch result {
            case .success (let user):
                DispatchQueue.main.async {
                    self?.sessionData.currentUser = user
                    self?.sessionData.signOutDelegate = self
                    self?.sessionData.setUpDefaults()
                }
            case .failure (let error):
                print(error)
            }
        }
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
