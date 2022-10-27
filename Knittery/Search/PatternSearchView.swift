//
//  PatternSearchView.swift
//  Knittery
//
//  Created by Nick on 2022-10-27.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct PatternSearchView: View {
    var body: some View {
        HStack {
            VStack {
                Text("Pattern Search")
                Spacer()
            }
            .padding()
            Spacer()
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct PatternSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PatternSearchView()
    }
}
