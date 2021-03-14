//
//  SwiftUIAppApp.swift
//  SwiftUIApp
//
//  Created by Iris on 2/28/21.
//

import SwiftUI

@main
struct SwiftUIAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Router())
                .environmentObject(FoodScreenViewModel())
        }
    }
}
