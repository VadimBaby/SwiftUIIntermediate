//
//  aboutTimerToNextDay.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 17.05.2023.
//

import SwiftUI

struct aboutTimerToNextDay: View {
    // every - это интервал
    // on - это thread в которой будет выполнятся таймер
    // in - лучше всего использовать .common
    // .autoconnect() - таймер стартует когда экран полностью загрузится
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var timeRemaining: String = ""
    
    var futureDay: Date {
        var futureDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date()) ?? Date()
        
        return Calendar.current.date(byAdding: .day, value: 1, to: futureDate) ?? Date()
    }
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDay)
        let hours = remaining.hour ?? 0
        let minutes = remaining.minute ?? 0
        let seconds = remaining.second ?? 0
        timeRemaining = "\(hours):\(minutes):\(seconds)"
    }
    
    var body: some View {
        ZStack{
            RadialGradient(
                gradient: Gradient(colors: [Color.red, Color.orange]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
            Text(timeRemaining)
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                .foregroundColor(Color.white)
                .lineLimit(1)
                .minimumScaleFactor(0.1)
        }
        .onReceive(timer) { _ in
            updateTimeRemaining()
        }
    }
}

struct aboutTimerToNextDay_Previews: PreviewProvider {
    static var previews: some View {
        aboutTimerToNextDay()
    }
}
