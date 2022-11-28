//
//  KnitteryApp.swift
//  Knittery
//
//  Created by Nicholas Valenti on 2022-09-22.
//

import SwiftUI
import OAuthSwift

@main
struct KnitteryApp: App {

    var body: some Scene {
        WindowGroup {
            RootView()
                .onOpenURL { url in
                    if url.host == "oauth-callback" {
                        OAuthSwift.handle(url: url)
                    }
                }
        }
    }
}
