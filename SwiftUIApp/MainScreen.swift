//
//  DashboardScreen.swift
//  SwiftUIApp
//
//  Created by Iris on 2/28/21.
//

import SwiftUI

struct MainScreen: View {
    @Binding var tabMainButton: Bool

    var body: some View {
        VStack {
            Text("Main")
            Spacer().frame(height: 20)
            Divider()
            Spacer().frame(height: 20)
            Button(action: { tabMainButton = true }) {
                Text("Show Food Screen with the second item of list")
            }
        }
//        .onDisappear { tabMainButton = false }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(tabMainButton: .constant(false))
    }
}
