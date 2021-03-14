//
//  AboutScreen.swift
//  SwiftUIApp
//
//  Created by Iris on 2/28/21.
//

import SwiftUI

struct AboutScreen: View {
    @State var showModalView: Bool = false
    @State var showPickerView: Bool = false
    @State var pickedMedia: [UIImage] = []
    @State var imageView: Image = Image(systemName: "star")

    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            Divider()
            imageView
                .resizable()
                .frame(width: 150, height: 150)
                .aspectRatio(contentMode: .fill)
                .background(Color.green)
            Spacer().frame(height: 50)
            Button(action: { showModalView.toggle() }) {
                Text("Show Modal View")
            }
            Spacer().frame(height: 50)
            Button(action: { showPickerView.toggle() }) {
                Text("Show Picker View")
            }
            Divider()
            Spacer().frame(height: 20)
        }
        .sheet(isPresented: $showModalView, content: {
            ModalView()
        })
        .sheet(isPresented: $showPickerView) {
            MediaPickerView(pickedMedia: $pickedMedia)
                .onDisappear {
                    if let pickedImage = pickedMedia.first  {
                        imageView = Image(uiImage: pickedImage)
                    }
                }
        }
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
