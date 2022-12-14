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
                        PatternPreviewContentView(DefaultContent.hotPatterns.rawValue,
                                                  results: $sessionData.defaultQueries[.hotPatterns])
                        .environmentObject(sessionData)
                        
                        PatternPreviewContentView(DefaultContent.debutPatterns.rawValue,
                                                  results: $sessionData.defaultQueries[.debutPatterns])
                        .environmentObject(sessionData)
                        
                        PatternPreviewContentView(DefaultContent.randomPatterns.rawValue,
                                                  results: $sessionData.defaultQueries[.randomPatterns])
                        .environmentObject(sessionData)
                        
                        PatternPreviewContentView(DefaultContent.newPatterns.rawValue,
                                                  results: $sessionData.defaultQueries[.newPatterns])
                        .environmentObject(sessionData)
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
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.KnitteryColor.backgroundDark)
            .onAppear {
                sessionData.populateQueries()
            }
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
