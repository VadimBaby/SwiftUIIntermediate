//
//  aboutSubcriber.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 17.05.2023.
//

import SwiftUI
import Combine

class SubcriberViewModel: ObservableObject {
    @Published var count: Int = 0
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var buttonDisabled: Bool = true
    
    var cancellables = Set<AnyCancellable>()
    
   // var timer: AnyCancellable?
    
    init() {
        setUpTimer()
        addTextFieldSubcriber()
        addButtonSubscriber()
    }
    
    func addButtonSubscriber() {
        $textIsValid
        // c помощью combineLatest мы можем добавить еще одну переменную 
            .combineLatest($count)
            .sink { [weak self] (isValid, count) in
                guard let self = self else { return }
                
                if isValid && count >= 10 {
                    self.buttonDisabled = false
                } else {
                    self.buttonDisabled = true
                }
            }
            .store(in: &cancellables)
    }
    
    func addTextFieldSubcriber() {
        $textFieldText
        // логика в map срабатывает каждый раз когда пользователь вводит символ, если у нас большая логика в map, чтобы оптимизировать этот процесс, мы можем использовать .debounce(), с ним логика в map и все остальное будет срабатывать только тогда, когда пользователь остановиться печатать на 0.5 секунд в нашем примере
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text) -> Bool in
                if text.count > 3 {
                    return true
                }
                
                return false
            }
            // .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                guard let self = self else { return }
                
                self.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        // тут мы наш timer помещаем в set под названием cancellables, в котором можно хранить все наши subcribers
        Timer
             .publish(every: 1, on: .main, in: .common)
             .autoconnect()
             .sink { [weak self] _ in

                 guard let self = self else { return }

                 self.count += 1

             // способ как оcтановаить таймер
 //                if count >= 10 {
 //                    for item in self.cancellables {
 //                        item.cancel()
 //                    }
 //                }
             }
             .store(in: &cancellables)
        
        //
        
        // тут мы создаем отдельно перемеенную AnyCancellable под названием timer, в которой будет хранится именно этот subcriber, с помощью этой переменной timer мы можеи остановить подписку на timer publisher
//       timer = Timer
//            .publish(every: 1, on: .main, in: .common)
//            .autoconnect()
//            .sink { [weak self] _ in
//
//                guard let self = self else { return }
//
//                self.count += 1
//
//            // способ как сотановаить таймер
//             //   if count >= 10 {
//             //       timer?.cancel()
//             //   }
//            }.
    }
}

struct aboutSubcriber: View {
    
    @StateObject var vm = SubcriberViewModel()
    
    var body: some View {
        VStack{
            Text("\(vm.count)")
                .font(.largeTitle)
            TextField("type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .overlay(
                    ZStack{
                        Image(systemName: "xmark")
                            .foregroundColor(Color.red)
                            .font(.title)
                            .opacity(vm.textFieldText.count < 1 ? 0 :
                                        vm.textIsValid ? 0 : 1)
                        
                        Image(systemName: "checkmark")
                            .foregroundColor(Color.green)
                            .font(.title)
                            .opacity(vm.textIsValid ? 1 : 0)
                    }
                    .padding(.trailing)
                    , alignment: .trailing
                )
            
            Button(action: {}) {
                Text("Submit".uppercased())
                    .foregroundColor(Color.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.buttonDisabled ? 0.5 : 1)
            }
            .disabled(vm.buttonDisabled)
        }
        .padding()
    }
}

struct aboutSubcriber_Previews: PreviewProvider {
    static var previews: some View {
        aboutSubcriber()
    }
}
