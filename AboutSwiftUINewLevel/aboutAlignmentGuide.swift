//
//  aboutAlignmentGuide.swift
//  AboutSwiftUINewLevel
//
//  Created by Вадим Мартыненко on 15.12.2023.
//

import SwiftUI

struct aboutAlignmentGuide: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Hello World")
                .background(Color.blue)
                .alignmentGuide(.leading, computeValue: { dimension in
                    return dimension.width
                })
            
            Text("This is some other text")
                .background(Color.red)
        }
        .background(Color.orange)
    }
}

struct aboutAlignmentGuideChildren: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20, content: {
            row(title: "Row 1", showIcon: false)
            row(title: "Row 2", showIcon: true)
            row(title: "Row 3", showIcon: false)
        })
        .padding(16)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 15))
        .shadow(radius: 10)
        .padding(40)
    }
    
    private func row(title: String, showIcon: Bool) -> some View {
        HStack(spacing: 10) {
            if showIcon {
                Image(systemName: "info.circle")
                    .frame(width: 30, height: 30)
            }
            
            Text(title)
            
            Spacer()
        }
     //   .background(Color.red)
        .alignmentGuide(.leading, computeValue: { dimension in
            return showIcon ? 40 : 0
        })
    }
}

#Preview {
    aboutAlignmentGuideChildren()
}
