//
//  aboutTimerDate.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 17.05.2023.
//

import SwiftUI

struct aboutTimerDate: View {
    // every - это интервал
    // on - это thread в которой будет выполнятся таймер
    // in - лучше всего использовать .common
    // .autoconnect() - таймер стартует когда экран полностью загрузится
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var currentDate: Date = Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    
    var body: some View {
        ZStack{
            RadialGradient(
                gradient: Gradient(colors: [Color.red, Color.orange]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            Text(dateFormatter.string(from: currentDate))
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundColor(Color.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer) { value in
            currentDate = value
        }
    }
}

struct aboutTimerDate_Previews: PreviewProvider {
    static var previews: some View {
        aboutTimerDate()
    }
}
