//
//  LoginView.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-22.
//

import SwiftUI
import OAuthSwift

struct LoginView: View {
    var signInAction: () -> Void
    var body: some View {
        
        VStack {
            Text("Knittery")
                .font(.title)
                .padding()
            Spacer()
            Button {
                signInAction()
            } label: {
                Text("Sign In")
            }
            .padding()
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView() { }
    }
}
