//
//  HomeView.swift
//  Knittery
//
//  Created by Nick on 2022-09-22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
//                TitleBar("Home")
                Spacer()
            }
            .background(Color.KnitteryColor.backgroundLight)
            
        }
        .navigationTitle("Home")
    }
}

struct YarnsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
