//
//  RootView.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-22.
//

import SwiftUI

struct RootView: View {
    @StateObject var rootViewModel = RootViewModel()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.KnitteryColor.backgroundDark)
    }
    
    @ViewBuilder var body: some View {
        Group {
            switch rootViewModel.state {
            case .loading:
                ProgressView()
            case .authenticated:
                rootView
            case .unauthenticated:
                loginView
            }
        }
        .onAppear {
            rootViewModel.checkAuthenticationState()
        }
    }
    
    var rootView: some View {
        TabView {
            Group {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .environmentObject(rootViewModel.sessionData)
                
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .environmentObject(rootViewModel.sessionData)
                
                LibraryView()
                    .tabItem {
                        Label("Library", systemImage: "books.vertical")
                    }
                    .environmentObject(rootViewModel.sessionData)
            }
        }
        .toolbar(.visible, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(Color.KnitteryColor.backgroundDark, for: .tabBar)
    }
    
    var loginView: some View {
        LoginView() {
            rootViewModel.signIn()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
