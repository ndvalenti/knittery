//
//  RootView.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-22.
//

import SwiftUI

enum TabID: Int, RawRepresentable {
    case home = 1
    case search = 2
    case library = 3
}

struct RootView: View {
    @StateObject var rootViewModel = RootViewModel()
    @State var tabID: TabID = .home
    
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
        TabView (selection: $tabID) {
            Group {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(TabID.home)
                    .environmentObject(rootViewModel.sessionData)
                
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag(TabID.search)
                    .environmentObject(rootViewModel.sessionData)
                
                LibraryView(tabID: $tabID)
                    .tabItem {
                        Label("Library", systemImage: "books.vertical")
                    }
                    .tag(TabID.library)
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
