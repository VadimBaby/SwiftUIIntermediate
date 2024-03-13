//
//  aboutScrollViewReader.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 20.04.2023.
//

import SwiftUI

struct aboutScrollViewReader: View {
    
    @State var indexTextField: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            TextField("Index", text: $indexTextField)
                .frame(height: 50)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Scroll Now") {
                if let index = Int(indexTextField) {
                    scrollToIndex = index
                }
            }
            
            ScrollView{
                ScrollViewReader { proxy in
                    Button("Scroll to 32") {
                        withAnimation(.easeOut){
                            proxy.scrollTo(32, anchor: .center)
                        }
                    }
                    
                    ForEach(0..<50) { index in
                        Text("\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { newValue in
                        withAnimation(.easeOut){
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

struct AboutScrollPositionView: View {
    @State private var scrollPosition: Int? = nil
    
    var body: some View {
        VStack {
            if let scrollPosition {
                Text("\(scrollPosition)")
            } else {
                    Text("nil")
            }
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(0...30, id: \.self) { index in
                        Rectangle()
                            .overlay {
                                Text("\(index)")
                                    .foregroundStyle(Color.white)
                            }
                            .frame(width: 80, height: 80)
                            .id(index)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $scrollPosition)
        }
    }
}

struct PositionObservingView<Content: View>: View {
    
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
            .background {
                GeometryReader { geo in
                    Color.clear.preference(
                        key: PreferenceKey.self,
                        value: geo.frame(in: coordinateSpace)
                            .origin                    
                    )
                }
            }
            .onPreferenceChange(PreferenceKey.self, perform: { value in
                position = value
            })
    }
}

extension PositionObservingView {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }

        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
            
        }
    }
}

struct PositionObservingTestView: View {
    @State private var position: CGPoint = .zero
    
    private let coordinateSpaceName = UUID()
    
    @State private var value: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            Text(value ? "Завтра" : "Сегодня")
            Text("position: \(position.debugDescription)")
            ScrollView(.horizontal) {
                PositionObservingView(
                    coordinateSpace: .named(coordinateSpaceName),
                    position: Binding(
                        get: { position }, set: { value in
                            position = .init(
                                x: -value.x,
                                y: -value.y
                            )
                        })) {
                        LazyHStack(spacing: 10) {
                            ForEach(1...50, id: \.self) { index in
                                Rectangle()
                                    .overlay {
                                        Text("\(index)")
                                            .foregroundStyle(Color.white)
                                    }
                                    .frame(width: 80, height: 80)
                                    .id(index)
                            }
                        }
                        .padding(.horizontal, 10)
                    }
            }
            .coordinateSpace(name: coordinateSpaceName)
            .frame(height: 80)
        }
        .onChange(of: position) { oldValue, newValue in
            if newValue.x > 1 * 90 - 45 {
                value = true
            } else {
                value = false
                
            }
        }
    }
}

#Preview {
    PositionObservingTestView()
}
