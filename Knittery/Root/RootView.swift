//
//  RootView.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-22.
//

import SwiftUI

struct RootView: View {
    @StateObject var rootViewModel = RootViewModel()
    
//    init() {
//        let appearance = UITabBar.appearance()
//        appearance.backgroundColor = UIColor.black
//        appearance.barStyle = UIBarStyle.black
//        appearance.isTranslucent = false
//        appearance.unselectedItemTintColor = UIColor.lightGray
//    }
    
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
            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }
            
            PatternsView()
                .tabItem {
                    Label("Patterns", systemImage: "square.grid.3x3.square")
                }
            
            YarnsView()
                .tabItem {
                    Label("Yarns", systemImage: "grid.circle")
                }
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
