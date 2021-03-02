//
//  TabBarScreen.swift
//  SwiftUIApp
//
//  Created by Iris on 2/28/21.
//

import SwiftUI
final class TabBarScreenViewModel: ObservableObject {
    @Published private(set) var items = [
        TabBarItem(name: "Main", image: Image(systemName: "star"), number: 0),
        TabBarItem(name: "Food", image: Image(systemName: "pills"), number: 1),
        TabBarItem(name: "About", image: Image(systemName: "graduationcap"), number: 2)
    ]
}

struct TabBarItem {
    let name: String
    let image: Image
    let number: Int
}

extension TabBarItem: Identifiable {
    var id: String {
        name
    }
}

struct TabBarScreen: View {
    @State private var selectionTab = 1
    @State private var tabMainButton = false
    @ObservedObject private var viewModel: TabBarScreenViewModel = .init()

    var body: some View {
        TabView(selection: $selectionTab) {
            ForEach(viewModel.items) { item in
                switch item.number {
                case 0:
                    MainScreen(tabMainButton: $tabMainButton)
                        .tabItem {
                            VStack {
                                Text(item.name)
                                item.image
                                    .font(Font.title.weight(.heavy))
                            }
                        }
                        .tag(item.number)
                case 1:
                    FoodScreen(tabMainButton: $tabMainButton)
                        .tabItem {
                            HStack {
                                Text(item.name)
                                Divider()
                                VStack {
                                    item.image
                                    Text("2")
                                }
                            }
                        }
                        .tag(item.number)
                case 2:
                    AboutScreen()
                        .tabItem {
                            Text(item.name)
                            item.image
                                .font(Font.footnote.weight(.ultraLight))
                        }
                        .tag(item.number)
                default:
                    EmptyView()
                }
            }
        }
        .onChange(of: tabMainButton, perform: { value in
            if value {
                selectionTab = 1
            }
        })
    }
}

struct TabBarScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabBarScreen()
    }
}
