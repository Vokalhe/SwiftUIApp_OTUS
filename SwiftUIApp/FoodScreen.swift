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
    @Binding var tabMainButton: Bool

    @State private var isActiveCell: Bool = false
    @State private var favesShowed: Bool = false
    @ObservedObject private var viewModel: FoodScreenViewModel = .init()

    var body: some View {
        NavigationView {
            List {
                FilterView(favesShowed: $favesShowed)
                
                ForEach(viewModel.foods.indices) { index in
                    let item = viewModel.foods[index]
                    
                    if !favesShowed || item.isFave {
                        FoodListCell(index: index, food: item, isActiveCell: $isActiveCell)
                    }
                }
                
//                let food = viewModel.foods.count > 1 ? viewModel.foods[1] : Food(name: "Apple", emoji: "🍏", isFave: true)
//                NavigationLink(
//                    destination: FoodView(name: food.name, emoji: food.emoji),
//                    isActive: $tabMainButton,
//                    label: {})
            }
            .navigationTitle(Text("Foods"))
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
    let index: Int
    let food: Food
    @Binding var isActiveCell: Bool

    var body: some View {
        HStack {
            NavigationLink(destination: FoodView(name: food.name, emoji: food.emoji), isActive: $isActiveCell) {
                Text(food.name)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isActiveCell = true
            print("___\(food.name)")
        }
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
        FoodScreen(tabMainButton: .constant(false))
    }
}

