//
//  AboutScreen.swift
//  SwiftUIApp
//
//  Created by Iris on 2/28/21.
//

import SwiftUI

struct AboutScreen: View {
    @State var showModalView: Bool = false

    var body: some View {
        VStack {
            Divider()
            Image(systemName: "star")
                .font(Font.system(size: 100).weight(.light))
            Spacer().frame(height: 80)
            Button(action: { showModalView.toggle() }) {
                Text("Show Modal View")
            }
            Divider()
        }.sheet(isPresented: $showModalView, content: {
            ModalView()
        })
    }
}

//MARK: - Filter View
private struct ModalView: View {
    var body: some View {
        Text("Modal View")
            .font(.largeTitle)
    }
}

struct AboutScreen_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen()
    }
}
