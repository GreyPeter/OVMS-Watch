//
//  OVMS_WatchApp.swift
//  OVMS-Watch Watch App
//
//  Created by Peter Harry on 6/8/2022.
//

import SwiftUI

@main
struct OVMS_Watch_Watch_AppApp: App {
    @StateObject private var serverData = ServerData.shared
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(model: serverData)
            }
            .onAppear {
                let defaults = UserDefaults.standard
                if userName == "" {
                    if let user = defaults.string(forKey: "username") {
                        userName = user
                        print("(WatchApp) Username = \(userName)")
                    } else {
                        print("(WatchApp) Error - Username not set")
                    }
                }
            }
        }
    }
}
