//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Iris on 2/28/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabBarScreen()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

final class Router: ObservableObject {
    @Published var selectionTab: Int = 1
    @Published var isAppleLinkShowed: Bool = false
}
