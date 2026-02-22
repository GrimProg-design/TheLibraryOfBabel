//
//  HeaderView.swift
//  LibraryOfBabel
//
//  Created by Вавилов Илья on 22/2/26.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 28, weight: .thin, design: .serif))
                .multilineTextAlignment(.center)
                .tracking(5)
                .foregroundStyle(Color.gold)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gold.opacity(0.3))
                .padding(.horizontal, 40)
        }
        .padding(.top, 40)
    }
}

