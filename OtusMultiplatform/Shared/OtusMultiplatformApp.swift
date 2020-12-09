//
//  OtusMultiplatformApp.swift
//  Shared
//
//  Created by Vladyslav Pokryshka on 09.12.2020.
//

import SwiftUI
import TVShowsUIModule

@main
struct OtusMultiplatformApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            MainScreen()
        }
    }
}
