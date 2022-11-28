//
//  CurrentUserView.swift
//  Knittery
//
//  Created by Nick on 2022-11-24.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct CurrentUserView: View {
    @ObservedObject var sessionData: SessionData
    
    @ViewBuilder
    var body: some View {
        if let user = sessionData.currentUser {
            if let image = sessionData.profilePicture {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color.KnitteryColor.darkBlue, lineWidth: 1))
            } else if let photo = user.photoURL {
                Group {
                    AsyncImage(url: photo, content: { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                            .overlay(Circle()
                                .stroke(Color.KnitteryColor.darkBlue, lineWidth: 1))
                    }, placeholder: {
                        Circle().frame(width: 32, height: 32)
                            .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
                    })
                }
            } else {
                Circle().frame(width: 32, height: 32)
                    .foregroundColor(Color.KnitteryColor.darkBlueTranslucent)
            }
        }
    }
}

struct CurrentUserView_Previews: PreviewProvider {
    @State static var sessionData = SessionData()
    static var previews: some View {
        CurrentUserView(sessionData: sessionData)
    }
}
