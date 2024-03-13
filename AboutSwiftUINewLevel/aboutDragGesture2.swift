//
//  aboutDragGesture2.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 16.04.2023.
//

import SwiftUI

struct aboutDragGesture2: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.84
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack{
            Color.green.ignoresSafeArea()
            
            SignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged{ value in
                            withAnimation(.spring()){
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded{ value in
                            withAnimation(.spring()){
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                        }
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct aboutDragGesture2_Previews: PreviewProvider {
    static var previews: some View {
        aboutDragGesture2()
    }
}

struct SignUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description for our app. This is my favorite SwiftUI. How i can be homohobic. My bitch is gay. Hit the man in the top, try to see a man topless, even stick is gay")
                .multilineTextAlignment(.center)
            
            Text("created account".uppercased())
                .foregroundColor(Color.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            Spacer()
        }
        .background(Color.white, ignoresSafeAreaEdges: .bottom)
        .cornerRadius(10)
    }
}
