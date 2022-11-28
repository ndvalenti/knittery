//
//  KnitteryMultiPickerTab.swift
//  Knittery
//
//  Created by Nick on 2022-11-02.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct KnitteryMultiPickerTab: View {
    @State var title: String
    @State var isChecked: Bool
    @State var action: (Bool) -> Void
    
    var body: some View {
        Button {
            isChecked.toggle()
            action(isChecked)
        } label: {
            HStack {
                Text(title)
                Spacer()
                if isChecked {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct MultiPickerTab_Previews: PreviewProvider {
    static var previews: some View {
        KnitteryMultiPickerTab(title: "Test Tab", isChecked: true) { _ in
            
        }
    }
}
