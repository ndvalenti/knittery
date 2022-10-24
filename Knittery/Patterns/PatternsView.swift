//
//  PatternsView.swift
//  Knittery
//
//  Created by Nick on 2022-09-22.
//

import SwiftUI

struct PatternsView: View {
    var body: some View {
        VStack {
            TitleBar("Patterns")
            Spacer()
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct PatternsView_Previews: PreviewProvider {
    static var previews: some View {
        PatternsView()
    }
}
