//
//  ContentView.swift
//  Storm Viewer SwiftUI
//
//  Created by Guillermo Lella on 8/30/20.
//

import SwiftUI

// model - should be in a separate file
struct Country: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String { return name }
}

// data
var countries = [Country(name: "estonia"),
               Country(name: "france"),
               Country(name: "germany"),
               Country(name: "ireland"),
               Country(name: "italy"),
               Country(name: "monaco"),
               Country(name: "nigeria"),
               Country(name: "poland"),
               Country(name: "russia"),
               Country(name: "spain"),
               Country(name: "uk"),
               Country(name: "us"),
]

// rows
struct ListRow: View {
    var item: Country
    var body: some View {
        HStack {
            Image(item.imageName)
                .resizable()
                .border(Color.gray, width: 1)
                .scaledToFit()
                .frame(width: 50)
            Text(item.name.uppercased())
                .font(.title2)
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(countries) { item in
                NavigationLink(destination: DetailView(country: item)) {
                    ListRow(item: item)
                }
            }
            .navigationTitle("Flag Viewer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
