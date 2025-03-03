//
//  CustomizeView.swift
//  TriviaBlasters
//
//  Created by Judah Lomo on 2/18/25.
//

import SwiftUI

struct CustomizeView: View {
    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all) // Placeholder background
            
            Text("Customize Your Ship")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct CustomizeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeView()
    }
}
