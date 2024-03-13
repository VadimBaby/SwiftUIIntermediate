//
//  aboutTimerCount.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 17.05.2023.
//

import SwiftUI

struct aboutTimerCount: View {
    // every - это интервал
    // on - это thread в которой будет выполнятся таймер
    // in - лучше всего использовать .common
    // .autoconnect() - таймер стартует когда экран полностью загрузится
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var count: Int = 10
    @State var finishedText: String? = nil
    
    var body: some View {
        ZStack{
            RadialGradient(
                gradient: Gradient(colors: [Color.red, Color.orange]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            Text(finishedText ?? "\(count)")
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundColor(Color.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer) { _ in
            if count < 2 {
                finishedText = "Wow"
            } else {
                count -= 1
            }
        }
    }
}

struct aboutTimerCount_Previews: PreviewProvider {
    static var previews: some View {
        aboutTimerCount()
    }
}
