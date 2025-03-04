//
//  ShopView.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 2/18/25.
//

import SwiftUI

struct ShopView: View {
    @State private var playerCurrency: Int = 1000 // Example starting currency
    @Environment(\.presentationMode) var presentationMode // Allows going back to the previous view
    
    let shopItems = [
        (name: "Laser Upgrade", cost: 500, color: Color.red, icon: "bolt.horizontal"),
        (name: "Shield Boost", cost: 750, color: Color.blue, icon: "shield"),
        (name: "New Ship Model", cost: 1000, color: Color.purple, icon: "airplane")
    ]
    
    var body: some View {
        ZStack {
            // Space-like gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.purple, Color.blue.opacity(0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                // Title: Shop
                Text("Shop")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .bold()
                    .shadow(radius: 10)
                
                // Currency display
                Text("Currency: \(playerCurrency) 💰")
                    .font(.title2)
                    .foregroundColor(.yellow)
                    .padding(.bottom, 30)
                    .shadow(radius: 10)

                // List of shop items with buttons to purchase
                ScrollView {
                    VStack(spacing: 25) {
                        ForEach(shopItems, id: \.name) { item in
                            HStack {
                                // Item name
                                Text(item.name)
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                // Item cost
                                Text("\(item.cost) 💰")
                                    .foregroundColor(.yellow)
                                    .font(.title3)
                                
                                // Buy button with customization
                                Button(action: {
                                    purchaseItem(cost: item.cost)
                                }) {
                                    HStack {
                                        // Adding icon to the button
                                        Image(systemName: item.icon)
                                            .foregroundColor(.white)
                                            .padding(.trailing, 5)
                                        
                                        Text("Buy")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                    }
                                    .padding()
                                    .background(item.color)
                                    .cornerRadius(15)
                                    .shadow(radius: 10)
                                }
                                .frame(width: 150)
                            }
                            .padding(.horizontal)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(15)
                            .padding(.horizontal, 10)
                        }
                    }
                    .padding(.bottom, 40) // Add bottom padding to avoid clipping
                }
                
                // Back to Menu button using presentationMode for dismissal
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss to go back to the main menu
                }) {
                    Text("Back to Menu")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding(.top, 20)
            }
            .padding(.top, 50)
        }
    }
    
    private func purchaseItem(cost: Int) {
        if playerCurrency >= cost {
            playerCurrency -= cost
            // TODO: Implement functionality to store purchased item for use in the game
        } else {
            // Handle insufficient funds, e.g., show an alert
        }
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
    }
}
