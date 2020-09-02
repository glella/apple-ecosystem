//
//  ContentView.swift
//  MinimalCounter
//
//  Created by Guillermo Lella on 9/1/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var counter = 0
    
    var body: some View {
        VStack {
            Button(action: {
                self.counter += 1
            }) {
                HStack {
                    Image(systemName: "plus.app")
                        .font(.title)
                    Text("Increment")
                        .fontWeight(.semibold)
                        .font(.title)
                    }
            }
            .buttonStyle(GradientBackgroundStyle())
            
            Text("Counter: \(counter)")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
    
            
            Button(action: {
                self.counter -= 1
            }) {
                HStack {
                    Image(systemName: "minus.square")
                        .font(.title)
                    Text("Decrement")
                        .fontWeight(.semibold)
                        .font(.title)
                    }
            }
            .buttonStyle(GradientBackgroundStyle())
        }
    }
}

struct GradientBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.blue]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
