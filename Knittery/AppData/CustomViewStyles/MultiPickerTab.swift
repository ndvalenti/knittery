//
//  MultiPickerTab.swift
//  Knittery
//
//  Created by Nick on 2022-11-02.
//  Copyright © 2022 Nicholas Valenti. All rights reserved.
//

import SwiftUI

struct CheckListItem: Identifiable {
    let id = UUID()
    var title: String
    var isChecked: Bool
}

struct MultiPickerTab: View {
    @State var checkListItem: CheckListItem
    
//    init(_ checkListItem: CheckListItem) {
//        self.checkListItem = checkListItem
//    }
    
    var body: some View {
        Button {
            checkListItem.isChecked.toggle()
        } label: {
            HStack {
                Text(checkListItem.title)
                Spacer()
                if checkListItem.isChecked {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

struct MultiPickerTab_Previews: PreviewProvider {
    static var previews: some View {
        MultiPickerTab(checkListItem: CheckListItem(title: "TestItem", isChecked: false))
    }
}
