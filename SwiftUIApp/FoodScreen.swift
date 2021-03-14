//
//  FoodScreen.swift
//  SwiftUIApp
//
//  Created by Iris on 2/28/21.
//

import SwiftUI

final class FoodScreenViewModel: ObservableObject {
    @Published private(set) var foods = [
        Food(name: "Strawberry", emoji: "🍓", isFave: false),
        Food(name: "Apple", emoji: "🍏", isFave: true),
        Food(name: "Cheese", emoji: "🧀", isFave: false),
        Food(name: "Tomato", emoji: "🍅", isFave: true),
    ]
}

struct Food {
    let name: String
    let emoji: String
    let isFave: Bool
}

extension Food: Identifiable, Hashable {
    var id: String { name }
}

struct FoodScreen: View {
    @EnvironmentObject var viewModel: FoodScreenViewModel
    @EnvironmentObject var router: Router
    @State var favesShowed: Bool = false

    var body: some View {
        NavigationView {
            List {
                FilterView(favesShowed: $favesShowed)
                
                ForEach(viewModel.foods) { item in
                    if !favesShowed || item.isFave {
                        FoodListCell(food: item)
                    }
                }
            }
            .navigationTitle(Text("Foods"))
            .overlay(NavigationLink(destination: FoodView(name: viewModel.foods[1].name,
                                                          emoji: viewModel.foods[1].emoji),
                                    isActive: $router.isAppleLinkShowed) {})
        }
    }
}

//MARK: - Private View
private struct FoodView: View {
    let name: String
    let emoji: String
    
    var body: some View {
        VStack {
            Text(emoji)
                .font(Font.system(size: 200))
            Text(name)
        }
       
    }
}

private struct FoodListCell: View {
    let food: Food

    var body: some View {
        HStack {
            NavigationLink(destination: FoodView(name: food.name, emoji: food.emoji)) {
                Text(food.name)
            }
        }
        .contentShape(Rectangle())
    }
}

//MARK: - Filter View
private struct FilterView: View {
    @Binding var favesShowed: Bool
    
    var body: some View {
        Toggle(isOn: $favesShowed) {
            Text("Favorites")
        }
    }
    
}

struct FoodScreen_Previews: PreviewProvider {
    static var previews: some View {
        FoodScreen()
    }
}

