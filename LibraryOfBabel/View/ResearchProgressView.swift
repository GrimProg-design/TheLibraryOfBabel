//
//  ScrollView.swift
//  LibraryOfBabel
//
//  Created by Вавилов Илья on 21/2/26.
//

import SwiftUI


struct ResearchProgressView: View {
    @State private var progress: Double = 0
    
    var body: some View {
        ProgressView(value: progress)
            .padding()
            .tint(Color.gold)
            .shadow(color: .gold.opacity(0.8), radius: x: 10, y: 0)
        Button("More") {progress += 0.5}
    }
}

#Preview {
    ResearchProgressView()
}
