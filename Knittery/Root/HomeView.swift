//
//  HomeView.swift
//  Knittery
//
//  Created by Nick on 2022-09-22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var sessionData: SessionData
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 50) {
                        PatternPreviewContentView(DefaultContent.hotPatterns.rawValue, results: $sessionData.defaultQueries[.hotPatterns], fullQuery: DefaultContent.hotPatterns.query)
                        .environmentObject(sessionData)
                        
                        if let categoryName = sessionData.sampleCategory?.longname {
                            VStack {
                                PatternPreviewContentView("Category: \(categoryName)", results: $sessionData.sampleCategoryResults, fullQuery: sessionData.sampleCategoryQuery)
                                    .environmentObject(sessionData)
                            }
                        }
                        
                        PatternPreviewContentView(DefaultContent.freePatterns.rawValue, results: $sessionData.defaultQueries[.freePatterns], fullQuery: DefaultContent.freePatterns.query)
                            .environmentObject(sessionData)
                        
                        PatternPreviewContentView(DefaultContent.debutPatterns.rawValue,  results: $sessionData.defaultQueries[.debutPatterns], fullQuery: DefaultContent.debutPatterns.query)
                        .environmentObject(sessionData)
                        
                        PatternPreviewContentView(DefaultContent.randomPatterns.rawValue, results: $sessionData.defaultQueries[.randomPatterns], fullQuery: DefaultContent.randomPatterns.query)
                        .environmentObject(sessionData)
                        
                        PatternPreviewContentView(DefaultContent.newPatterns.rawValue, results: $sessionData.defaultQueries[.newPatterns], fullQuery: DefaultContent.randomPatterns.query)
                        .environmentObject(sessionData)
                    }
                }
                .padding(.top)
                .frame(maxWidth: .infinity)
                .background(Color.KnitteryColor.backgroundLight)
            }
            .frame(maxWidth: .infinity)
            .background(Color.KnitteryColor.backgroundDark)
            .toolbar {
                NavigationToolbar(title: "Home", sessionData: sessionData)
            }
            .toolbar(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
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
