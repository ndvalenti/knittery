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
                    .frame(height: 150)
                Image("KnLogo")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
                    .clipShape(Circle())
            }
            
            Text("Knittery")
                .font(.custom("Avenir", size: 90).weight(.medium))
                .foregroundColor(.KnitteryColor.lightBlue)
                .shadow(color: .KnitteryColor.darkBlueTranslucent, radius: 6, x: 0, y: 3)
                .padding(.top)
            
            Text("for Ravelry")
                .textCase(.uppercase)
                .foregroundColor(.KnitteryColor.darkBlue).shadow(color: .KnitteryColor.darkBlueTranslucent, radius: 6, x: 0, y: 3)
                .font(.subheadline)
            
            Spacer()
            
            Button {
                signInAction()
            } label: {
                Text("SIGN IN")
            }
            .buttonStyle(StandardButton(width: 300, height: 70))
            
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
