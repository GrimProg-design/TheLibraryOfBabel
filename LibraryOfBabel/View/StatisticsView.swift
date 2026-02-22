//
//  StatisticsView.swift
//  LibraryOfBabel
//
//  Created by Вавилов Илья on 22/2/26.
//

import SwiftUI

struct StatisticsView: View {
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "1a1a2e"), Color(hex: "16213e")]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
         
            HeaderView(title: "Исследование библиотеки")
        }
    }
}
