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
                
            }
            
            Tab("Map", systemImage: "map") {
                
            }
        }
    }
}

#Preview {
    ContentView()
}
