//
//  NavigationToolbar.swift
//  Knittery
//
//  Created by Nick on 2022-11-27.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct NavigationToolbar: ToolbarContent {
    let title: String?
    @ObservedObject var sessionData: SessionData
    
    init(title: String? = nil, sessionData: SessionData) {
        self.title = title
        self.sessionData = sessionData
    }
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            CurrentUserView(sessionData: sessionData)
        }
        if let title {
            ToolbarItem(placement: .navigationBarLeading) {
                Text(title)
                    .foregroundColor(.KnitteryColor.darkBlue)
                    .font(.custom("Avenir", size: 30, relativeTo: .largeTitle).weight(.medium))
            }
        }
    }
}
