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
            ContentView(model: serverData)
        }
    }
}
