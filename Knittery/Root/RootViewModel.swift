//
//  RootViewModel.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-22.
//

import Foundation

class RootViewModel: ObservableObject {
    var networkHandler = NetworkHandler()
    var sessionData = SessionData()
    
    enum State {
        case loading
        case authenticated
        case unauthenticated
    }
    
    @Published var state: State = .loading
    
    func checkAuthenticationState() {
        networkHandler.refreshAccessToken() { [weak self] success in
            if success {
                self?.state = .authenticated
            } else {
                self?.state = .unauthenticated
            }
        }
    }
    
    func signIn() {
        networkHandler.signIn() { [weak self] success in
            if success {
                self?.state = .authenticated
            } else {
                self?.state = .unauthenticated
            }
        }
    }
}
