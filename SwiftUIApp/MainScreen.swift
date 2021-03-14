//
//  DashboardScreen.swift
//  SwiftUIApp
//
//  Created by Iris on 2/28/21.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var router: Router

    var body: some View {
        VStack {
            Text("Main")
            Spacer().frame(height: 20)
            Divider()
            Spacer().frame(height: 20)
            Button(action: {
                router.selectionTab = 1
                router.isAppleLinkShowed = true
            }) {
                Text("Show Apple Link")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
        }
    }
}

struct DashboardScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
