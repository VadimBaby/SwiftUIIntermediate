//
//  aboutTimerAnimateTabView.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 17.05.2023.
//

import SwiftUI

struct aboutTimerAnimateTabView: View {
    // every - это интервал
    // on - это thread в которой будет выполнятся таймер
    // in - лучше всего использовать .common
    // .autoconnect() - таймер стартует когда экран полностью загрузится
    let timer = Timer.publish(every: 2.0, on: .main, in: .common).autoconnect()
    
    @State var count: Int = 0
    
    var body: some View {
        ZStack{
            RadialGradient(
                gradient: Gradient(colors: [Color.red, Color.orange]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            TabView(selection: $count, content: {
                Rectangle()
                    .fill(Color.red)
                    .tag(1)
                Rectangle()
                    .fill(Color.gray)
                    .tag(2)
                Rectangle()
                    .fill(Color.green)
                    .tag(3)
                Rectangle()
                    .fill(Color.orange)
                    .tag(4)
                Rectangle()
                    .fill(Color.blue)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 2.0)) {
                count = count == 5 ? 0 : count + 1
            }
        }
    }
}

struct aboutTimerAnimateTabView_Previews: PreviewProvider {
    static var previews: some View {
        aboutTimerAnimateTabView()
    }
}
