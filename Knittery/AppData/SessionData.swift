//
//  SessionData.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-23.
//

import Foundation
import UIKit

class SessionData: ObservableObject {
    weak var signOutDelegate: SignOutDelegate?
    
    @Published private var rootViewModel: RootViewModel?
    
    @Published var currentUser: User? { didSet {
        guard let currentUser, let photoURL = currentUser.photoURL else {
            profilePicture = nil
            return
        }
        
        NetworkHandler.loadImageFrom(url: photoURL) { image in
            self.profilePicture = image
        }
    } }
    
    @Published var profilePicture: UIImage? = nil
    
    func signOut() {
        signOutDelegate?.signOut()
    }
    
    func clearData() {
        currentUser = nil
    }
}


