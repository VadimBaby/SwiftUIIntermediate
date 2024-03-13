//
//  aboutTimerWithAnimationCount.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 17.05.2023.
//

import SwiftUI

struct aboutTimerWithAnimationCount: View {
    // every - это интервал
    // on - это thread в которой будет выполнятся таймер
    // in - лучше всего использовать .common
    // .autoconnect() - таймер стартует когда экран полностью загрузится
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    @State var count: Int = 0
    
    var body: some View {
        ZStack{
            RadialGradient(
                gradient: Gradient(colors: [Color.red, Color.orange]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            HStack(spacing: 15){
                Circle()
                    .offset(y: count == 1 ? -20 : 0)
                Circle()
                    .offset(y: count == 2 ? -20 : 0)
                Circle()
                    .offset(y: count == 3 ? -20 : 0)
            }
            .frame(width: 150)
            .foregroundColor(Color.white)
        }
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                count = count == 3 ? 0 : count + 1
            }
        }
    }
}

struct aboutTimerWithAnimationCount_Previews: PreviewProvider {
    static var previews: some View {
        aboutTimerWithAnimationCount()
    }
}
