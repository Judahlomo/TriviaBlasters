//
//  ShopView.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 2/18/25.
//

import SwiftUI

struct ShopView: View {
    @State private var playerCurrency: Int = 1000 // Example starting currency
    
    let shopItems = [
        (name: "Laser Upgrade", cost: 500),
        (name: "Shield Boost", cost: 750),
        (name: "New Ship Model", cost: 1000)
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Shop")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                
                Text("Currency: \(playerCurrency) 💰")
                    .font(.title2)
                    .foregroundColor(.yellow)
                
                List(shopItems, id: \ .name) { item in
                    HStack {
                        Text(item.name)
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(item.cost) 💰")
                            .foregroundColor(.yellow)
                        Button("Buy") {
                            purchaseItem(cost: item.cost)
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                    }
                    .listRowBackground(Color.gray.opacity(0.2))
                }
                .frame(height: 200)
                .scrollContentBackground(.hidden)
                
                NavigationLink(destination: MainMenuView()) {
                    Text("Back to Menu")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        }
    }
    
    private func purchaseItem(cost: Int) {
        if playerCurrency >= cost {
            playerCurrency -= cost
            // TODO: Store purchased item for use in CustomizeView
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}
