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
            Spacer()
            ZStack {
                Rectangle()
                    .fill(Color.KnitteryColor.darkBlueTranslucent)
                    .frame(height: 200)
                Image("KnLogo")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color.KnitteryColor.darkBlue, lineWidth: 2))
            }
            Text("Knittery")
                .font(.custom("Avenir", size: 90))
                .foregroundColor(.KnitteryColor.lightBlue)
                .shadow(color: .KnitteryColor.darkBlue, radius: 6, x: 0, y: 3)
                .padding()
            Button {
                signInAction()
            } label: {
                Text("Sign In")
            }
            .padding()
            Spacer()
        }
        .background(Color.KnitteryColor.backgroundDark)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView() { }
    }
}
