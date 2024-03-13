//
//  aboutLongPressGesture.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 08.04.2023.
//

import SwiftUI

struct aboutLongPressGesture: View {
    @State var isCompleted: Bool = false
    
    @State var isSuccess: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        VStack{
            VStack{
                Rectangle()
                    .fill(isSuccess ? Color.green : Color.blue)
                    .frame(maxWidth: isLoading ? .infinity : 0)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.gray)
                
                HStack(spacing: 30){
                    Text("Click Me")
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .onLongPressGesture(minimumDuration: 1, maximumDistance: 50) {
                            // at the min duration
                            withAnimation(.easeInOut){
                                isSuccess = true
                            }
                            
                        } onPressingChanged: { isPressing in
                            // start of press -> min duration
                            // this func will work faster than perfom at min duration
                            if isPressing {
                                withAnimation(.easeInOut(duration: 1)){
                                    isLoading = true
                                }
                            } else {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                    if !isSuccess {
                                        withAnimation(.easeInOut){
                                            isLoading = false
                                        }
                                    }
                                })
                            }
                        }

                    
                    Text("Reset")
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                        .onTapGesture {
                            isSuccess = false
                            isLoading = false
                        }
                }
            }
            Spacer()
            
            Text(isCompleted ? "COMPLETED" : "NOT COMPLETE")
                .padding()
                .padding(.horizontal)
                .background(isCompleted ? Color.green : Color.gray)
                .onLongPressGesture(minimumDuration: 2, maximumDistance: 50) {
                    // maximumDistance is the max distance that u can move your finger when u pressin
                    isCompleted.toggle()
                }
    //            .onLongPressGesture {
    //                isCompleted.toggle()
    //            }
        }
        .padding()
    }
}

struct aboutLongPressGesture_Previews: PreviewProvider {
    static var previews: some View {
        aboutLongPressGesture()
    }
}
