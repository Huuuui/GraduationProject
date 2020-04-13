//
//  MenuView.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/3/5.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct MenuView: View {
    @Binding var showlogin : Bool
    @Binding var studentshow: Bool
    @Binding var jieyueshow : Bool
    @Binding var menuviewshow : Bool
    @Binding var searchshow : Bool
    @State var alertshow : Bool = false
    @Binding var xingming: String
    @Binding var touxiang: String
    var body: some View {
        VStack {
            Spacer()
            VStack() {
                Text(self.xingming)
                    .offset(y: -20)
                    .font(.system(size : 20))
                MenuRow(title: "我的借阅", icon: "star.circle.fill")
                    .onTapGesture {
                       
                        self.jieyueshow.toggle()
                }
                Spacer()
                    .frame(height:30)
                MenuRow(title: "书籍检索", icon: "magnifyingglass.circle")
                    .onTapGesture {
                        self.searchshow.toggle()
                }
                Spacer()
                    .frame(height:30)
                MenuRow(title: "退出登录", icon: "arrow.uturn.down")
                    .onTapGesture {
                        self.alertshow.toggle()
                }
                .alert(isPresented: self.$alertshow){
                    Alert(title: Text("提示"), message: Text("确定退出吗？"), primaryButton: .default(Text("确定"), action: {
                        self.menuviewshow.toggle()
                        self.showlogin.toggle()
                        self.studentshow = false
                    }), secondaryButton: .cancel(Text("取消"), action: {}))
                }
                
            }
            .frame(maxWidth: 414)
            .frame(height: 300)
            .background(BlurView(style: .systemMaterial))
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: UnitPoint.top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
            .padding(.horizontal, 30)
            .overlay(
                WebImage(url: URL(string: self.touxiang))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                    .offset(y: -150)
            )
            .offset(y: -30)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView( showlogin: .constant(false), studentshow: .constant(false), jieyueshow: .constant(false), menuviewshow: .constant(false), searchshow: .constant(false), xingming: .constant(""), touxiang: .constant(""))
    }
}

struct MenuRow: View {
    var title: String
    var icon: String
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .light))
                .imageScale(.medium)
                .foregroundColor(Color(#colorLiteral(red: 0.662745098, green: 0.7333333333, blue: 0.831372549, alpha: 1)))
                .frame(width: 32, height: 32)
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .frame(width: 120, alignment: .leading)
            
        }
    }
}
