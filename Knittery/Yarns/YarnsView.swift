//
//  YarnView.swift
//  Knittery
//
//  Created by Nick on 2022-09-22.
//

import SwiftUI

struct YarnsView: View {
    var body: some View {
        VStack {
            TitleBar("Yarns")
            Spacer()
        }
        .background(Color.KnitteryColor.backgroundLight)
    }
}

struct YarnsView_Previews: PreviewProvider {
    static var previews: some View {
        YarnsView()
    }
}
