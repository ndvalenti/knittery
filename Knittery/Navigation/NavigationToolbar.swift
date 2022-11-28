//
//  NavigationToolbar.swift
//  Knittery
//
//  Created by Nick on 2022-11-27.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct NavigationToolbar: ToolbarContent {
    let title: String
    @ObservedObject var sessionData: SessionData
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            CurrentUserView(sessionData: sessionData)
        }
        ToolbarItem(placement: .navigationBarLeading) {
            Text(title)
                .foregroundColor(.KnitteryColor.darkBlue)
                .font(.custom("Avenir", size: 30, relativeTo: .largeTitle).weight(.medium))
        }
    }
}
