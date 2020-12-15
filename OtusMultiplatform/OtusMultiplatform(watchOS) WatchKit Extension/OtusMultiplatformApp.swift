//
//  OtusMultiplatformApp.swift
//  OtusMultiplatform(watchOS) WatchKit Extension
//
//  Created by Vladyslav Pokryshka on 13.12.2020.
//

import SwiftUI

@main
struct OtusMultiplatformApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
