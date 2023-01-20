//
//  RootView.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-22.
//

import SwiftUI

struct RootView: View {
    @StateObject var rootViewModel = RootViewModel()

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
        .onAppear {
            let standardAppearance = UITabBarAppearance()
            standardAppearance.configureWithDefaultBackground()
            standardAppearance.backgroundColor = UIColor(Color.KnitteryColor.backgroundDark)
            UITabBar.appearance().standardAppearance = standardAppearance
            
            let scrollEdgeAppearance = UITabBarAppearance()
            scrollEdgeAppearance.configureWithTransparentBackground()
            scrollEdgeAppearance.backgroundColor = UIColor(Color.KnitteryColor.backgroundDark)
            UITabBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance
        }
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
