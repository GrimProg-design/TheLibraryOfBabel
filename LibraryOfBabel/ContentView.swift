//
//  ContentView.swift
//  LibraryOfBabel
//
//  Created by Вавилов Илья on 21/2/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Library", systemImage: "building.columns") {
                LibraryView()
            }
            
            Tab("Map", systemImage: "map") {
                
            }
            
            Tab("Statistics", systemImage: "chart.bar.xaxis") {
                StatisticsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
