//
//  DetailView.swift
//  FlagViewer
//
//  Created by Guillermo Lella on 8/30/20.
//

import SwiftUI

struct DetailView: View {
    var country: Country
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Image(country.imageName)
                .resizable()
                .border(Color.gray, width: 1)
                .scaledToFit()
        
            Button(action: {
                self.showingAlert = true
            }) {
                HStack {
                    Image(systemName: "bolt.circle")
                        .font(.title)
                    Text("Shazam")
                        .fontWeight(.semibold)
                        .font(.title)
                    }
            }
            .buttonStyle(GradientBackgroundStyle())
        }
        .alert(isPresented: $showingAlert, content: {
            Alert(title: Text("Country Name"), message: Text("The country is \(country.name.uppercased())"), dismissButton: .cancel(Text("OK")))
        })
    }
}

struct GradientBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(country: Country(name: "estonia"))
    }
}
