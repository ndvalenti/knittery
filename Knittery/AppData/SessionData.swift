//
//  SessionData.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-23.
//

import Foundation
import SwiftUI

class SessionData: ObservableObject {
    @Published var currentUser: User? = nil
    
    var profilePicture: Image? = nil
}
