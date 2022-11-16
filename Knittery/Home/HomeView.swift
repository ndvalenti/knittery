//
//  HomeView.swift
//  Knittery
//
//  Created by Nick on 2022-09-22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            TitleBar("Home")
            Spacer()
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct YarnsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
