//
//  CurrentUserView.swift
//  Knittery
//
//  Created by Nick on 2022-11-24.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct CurrentUserView: View {
    @State var profilePicture: User? = SessionData.currentUser
    
    var body: some View {
        if let profilePicture {
            if let photo = profilePicture.photo {
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
    static var previews: some View {
        CurrentUserView()
    }
}
