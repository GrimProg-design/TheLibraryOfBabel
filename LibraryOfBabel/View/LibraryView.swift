//
//  LibraryView.swift
//  LibraryOfBabel
//
//  Created by Вавилов Илья on 21/2/26.
//

import SwiftUI
import Combine

struct LibraryView: View {
    @State private var room = ""
    @State private var wall = ""
    @State private var shelf = ""
    @State private var book = ""
    @State private var showBook = false
    
    // Создаем один экземпляр движка на всё время работы
    @StateObject private var engineWrapper = EngineWrapper()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "1a1a2e"), Color(hex: "16213e")]),
                               startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    headerSection
                    
                    VStack(spacing: 20) {
                        customTextField(title: "НОМЕР ГЕКСАГОНА", text: $room, icon: "cube.transparent")
                        customTextField(title: "СТЕНА (1-4)", text: $wall, icon: "square.split.2x2")
                        customTextField(title: "ПОЛКА (1-5)", text: $shelf, icon: "books.vertical")
                        customTextField(title: "КНИГА (1-32)", text: $book, icon: "book.closed")
                    }
                    .padding(25)
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(25)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.gold.opacity(0.2), lineWidth: 1))
                    
                    Button(action: { if !room.isEmpty { showBook = true } }) {
                        Text("ИЗВЛЕЧЬ ТЕКСТ")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(hex: "1a1a2e"))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gold)
                            .cornerRadius(15)
                            .shadow(color: .gold.opacity(0.3), radius: 10)
                    }
                    .disabled(room.isEmpty)
                    .opacity(room.isEmpty ? 0.5 : 1)
                    
                    Spacer()
                }
                .padding(25)
            }
            .fullScreenCover(isPresented: $showBook) {
                BookDetailView(room: room, wall: wall, shelf: shelf, book: book, engine: engineWrapper.engine)
            }
        }
    }
    
    var headerSection: some View {
        VStack(spacing: 8) {
            Text("АРХИВ ВАВИЛОНА").font(.system(size: 28, weight: .thin, design: .serif)).tracking(5).foregroundColor(.gold)
            Rectangle().frame(height: 1).foregroundColor(.gold.opacity(0.3)).padding(.horizontal, 40)
        }.padding(.top, 40)
    }
    
    @ViewBuilder
    func customTextField(title: String, text: Binding<String>, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: icon).foregroundColor(.gold.opacity(0.7)).font(.system(size: 14))
                Text(title).font(.system(size: 12, weight: .semibold, design: .monospaced)).foregroundColor(.gold.opacity(0.6))
            }
            TextField("", text: text).keyboardType(.numberPad).foregroundColor(.white).font(.system(size: 18, weight: .medium, design: .monospaced)).tint(.gold)
            Rectangle().frame(height: 1).foregroundColor(.gold.opacity(0.3))
        }
    }
}

// Обертка для движка, чтобы он не пересоздавался при обновлении вью
class EngineWrapper: ObservableObject {
    let engine = BabylonEngine()
}

// Хелперы для цветов
extension Color {
    static let gold = Color(red: 0.83, green: 0.69, blue: 0.22)
    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        let r = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00ff00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000ff) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
