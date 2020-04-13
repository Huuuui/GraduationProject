//
//  AlertTest.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/9.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI

struct AlertTest: View {
    var body: some View {
        VStack(spacing:0) {
            Spacer()
            VStack {
                Text("警告⚠️")
                    .font(.system(size: 16, weight: .bold, design: .default))
                    .offset(y:-10)
                Text("确定删除吗？")
                    .font(.custom("FZKTJW.TTF", size: 13))
            }
                .offset(y:5)
            Spacer()
            Divider()
            HStack(){
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("确定")
                        .frame(width:140,height:47)
                }
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("取消")
                        .frame(width:140,height:47)
                }
            }
            .overlay(
                Text("")
                    .frame(width: 0.4, height: 47)
                    .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
            )
        }
        .frame(width:280,height: 120)
        .background(BlurView(style: .extraLight))
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: UnitPoint.top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
        
        
        
    }
}

struct AlertTest_Previews: PreviewProvider {
    static var previews: some View {
        AlertTest()
    }
}
