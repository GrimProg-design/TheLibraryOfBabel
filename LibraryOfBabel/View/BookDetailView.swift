//
//  BookDetailView.swift
//  LibraryOfBabel
//
//  Created by Вавилов Илья on 21/2/26.
//
import SwiftUI

struct BookDetailView: View {
    let room: String; let wall: String; let shelf: String; let book: String
    let engine: BabylonEngine
    
    @State private var currentPage = 1
    @Environment(\.dismiss) var dismiss
    
    @State private var isOpen = true
    @State private var page = ""
    
    
    var body: some View {
        ZStack {
            Color(hex: "1a1a2e").ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: Хедер
                HStack {
                    VStack(alignment: .leading) {
                        Text("КНИГА №\(book)").font(.caption.monospaced().bold())
                        Text("ГЕКСАГОН \(room) / СТЕНА \(wall)").font(.system(size: 10).monospaced())
                    }.foregroundColor(.gold.opacity(0.8))
                    Spacer()
                    
                    Menu {
                        Button("Найти слова", systemImage: "magnifyingglass") {
                            
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle").font(.title3).foregroundColor(.gold)
                    }
                    .padding(.trailing, 10)
                    
                    Button("ЗАКРЫТЬ") { dismiss() }.font(.caption.monospaced()).foregroundColor(.gold)
                }
                .padding().background(Color.black.opacity(0.3))
                
                // MARK: Ленивая прокрутка страниц
                TabView(selection: $currentPage) {
                    ForEach(1...engine.totalPagesInBook, id: \.self) { pageNum in
                        PageContentView(pageNum: pageNum, room: room, wall: wall, shelf: shelf, book: book, engine: engine)
                            .tag(pageNum)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                // MARK:  Футер
                
                HStack {
                    Button {
                        if currentPage <= 1 {
                            currentPage = 1
                        } else {
                            currentPage -= 1
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                isOpen.toggle()
                            }
                        } label: {
                            if isOpen {
                                Text("СТРАНИЦА \(currentPage) ИЗ \(engine.totalPagesInBook)")
                                    .animation(.easeInOut, value: isOpen)
                            } else {
                                Image(systemName: "text.page")
                                    .font(.title2)
                                    .animation(.easeInOut, value: isOpen)
                            }
                        }
                        Button {
                            withAnimation {
                                isOpen.toggle()
                            }
                        } label: {
                            if isOpen {
                                Image(systemName: "magnifyingglass")
                                    .font(.title2)
                                    .animation(.easeInOut, value: isOpen)
                            } else {
                                TextField("Введите номер страницы", text: $page) {
                                    if currentPage > 410 {
                                        currentPage = 410
                                    } else if currentPage < 1 {
                                        currentPage = 1
                                    } else {
                                        currentPage = Int(page) ?? 1
                                    }
                                }
                                .frame(width: 100)
                                .textFieldStyle(.roundedBorder)
                                .border(Color.gold, width: 1)
                                .cornerRadius(20)
                                .animation(.easeInOut, value: isOpen)
                                .foregroundStyle(.black)
                                .keyboardType(.numberPad)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        if currentPage >= 410 {
                            currentPage = 410
                        } else {
                            currentPage += 1
                        }
                    } label: {
                        Image(systemName: "arrow.right")
                            .font(.title2)
                    }
                }
                .font(.system(size: 10, weight: .bold).monospaced())
                .foregroundColor(.gold.opacity(0.7))
                .padding().frame(maxWidth: .infinity).background(Color.black.opacity(0.2))
            }
        }
    }
}

struct PageContentView: View {
    let pageNum: Int
    let room: String; let wall: String; let shelf: String; let book: String
    let engine: BabylonEngine
    @State private var pageText: String = ""
    
    var body: some View {
        ScrollView {
            if pageText.isEmpty {
                ProgressView().tint(.gold).padding(.top, 50)
            } else {
                Text(pageText)
                    .font(.system(size: 14, design: .monospaced))
                    .foregroundColor(.white.opacity(0.85))
                    .lineSpacing(6).padding(30)
            }
        }
        .onAppear {
            if pageText.isEmpty {
                DispatchQueue.global(qos: .userInitiated).async {
                    let raw = engine.generatePageText(room: room, wall: wall, shelf: shelf, book: book, page: pageNum)
                    let formatted = format(raw)
                    DispatchQueue.main.async { self.pageText = formatted }
                }
            }
        }
    }
    
    func format(_ input: String) -> String {
        var res = ""; let chars = Array(input)
        for i in stride(from: 0, to: chars.count, by: 40) {
            let end = min(i + 40, chars.count)
            res += String(chars[i..<end])
        }
        return res
    }
}
