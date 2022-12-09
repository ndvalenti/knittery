//
//  HomeView.swift
//  Knittery
//
//  Created by Nick on 2022-09-22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @EnvironmentObject var sessionData: SessionData
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 50) {
                        KnitteryPatternPreviewBlock()
                    }
                }
                .padding(.top)
                .frame(maxWidth: .infinity)
                .background(Color.KnitteryColor.backgroundLight)
            }
            .frame(maxWidth: .infinity)
            .toolbar {
                NavigationToolbar(title: "Home", sessionData: sessionData)
            }
            .toolbar(.visible, for: .navigationBar)
            .background(Color.KnitteryColor.backgroundDark)
        }
        .environmentObject(sessionData)
    }
}

struct YarnsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SessionData())
    }
}
