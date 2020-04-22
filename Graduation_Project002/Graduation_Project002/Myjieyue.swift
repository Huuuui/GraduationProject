//
//  MyJieyue.swift
//  demotest
//
//  Created by gzy on 2020/4/3.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyJieyue: View {
    @Binding var userid: String
    @Binding var jieyueshow: Bool
    @Binding var menuvieshow: Bool
    @State var warningshow: Bool = false
    @State var alertshow: Bool = false
    @State var username: String = ""
    @State var state:String = ""
    @State var bookisbn : String = ""
    @State var state0:[jieyuelist] = []
    @State var state1:[jieyuelist] = []
    @State var state2:[jieyuelist] = []
    var body: some View {
            //Color.white
        ZStack{
            VStack() {
                        HStack {
                            VStack{
                                Spacer()
                                    .frame(height:40)
                                Text("君不见高堂明镜悲白发朝如青丝暮成雪")
                                .font(.system(size:15))
                                .foregroundColor(Color.gray)
                            }
                            Spacer()
                            Button(action: {
                                self.jieyueshow.toggle()
                                self.menuvieshow.toggle()
                            }) {
                                VStack{
                                    Image(systemName:"arrowshape.turn.up.right")
                                    .resizable()
                                    .frame(width: 25, height: 20)
                                    Text("返回")
                                    .font(.subheadline)
                                }
                                .offset(y:10)
                                
                            }
                            
                        }
                        .padding(.horizontal,30)
                        Divider()
                List() {
                            Group{
                                Section(header: Text("借阅中")) {
                                    ForEach(self.state1) { list in
                                        HStack {
                                            WebImage(url:URL(string: list.bookimg))
                                            .resizable()
                                            .frame(width:60, height:90)
                                            .cornerRadius(5)
                                            .padding(.all,5)
                                                .background(Color.white)
                                            Spacer()
                                                .frame(width:30)
                                            VStack(alignment:.leading) {
                                                Text(list.bookname)
                                                .font(.system(size:23))
                                                    .fontWeight(.bold)
                                                Spacer()
                                                Text(list.bookauthor)
                                                .font(.subheadline)
                                                .foregroundColor(Color.gray)
                                                Text("ISBN:\(list.bookisbn)")
                                                    .font(.subheadline)
                                                    .foregroundColor(Color.gray)
                                                Text("\(list.get_date)借阅 | 限\(list.back_date)归还")
                                                .font(.subheadline)
                                                .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                                            }
                                        }
                                        .onTapGesture {
                                            self.warningshow = true
                                            self.username = self.userid
                                            self.bookisbn = list.bookisbn
                                        }
                                    }
                                }
                                
                                Section(header: Text("超期未归还")) {
                                    ForEach(self.state2) { list in
                                        HStack {
                                            WebImage(url:URL(string: list.bookimg))
                                            .resizable()
                                            .frame(width:60, height:90)
                                            .cornerRadius(5)
                                            .padding(.all,5)
                                                .background(Color.white)
                                            Spacer()
                                                .frame(width:30)
                                            VStack(alignment:.leading) {
                                                Text(list.bookname)
                                                .font(.system(size:23))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(Color.red)
                                                Spacer()
                                                Text(list.bookauthor)
                                                .font(.subheadline)
                                                .foregroundColor(Color.gray)
                                                Text("ISBN:\(list.bookisbn)")
                                                    .font(.subheadline)
                                                    .foregroundColor(Color.gray)
                                                Text("超期罚款: \(list.fine) 元")
                                                .font(.subheadline)
                                                .foregroundColor(Color.red)
                                            }
                                        }
                                        .onTapGesture {
                                            self.warningshow = true
                                            self.username = self.userid
                                            self.bookisbn = list.bookisbn
                                        }
                                    }
                                }
                                Section(header: Text("借阅历史")) {
                                    ForEach(self.state0) { list in
                                        HStack {
                                            WebImage(url:URL(string: list.bookimg))
                                            .resizable()
                                            .frame(width:60, height:90)
                                            .cornerRadius(5)
                                            .padding(.all,5)
                                                .background(Color.white)
                                            Spacer()
                                                .frame(width:30)
                                            VStack(alignment:.leading) {
                                                Text(list.bookname)
                                                .font(.system(size:23))
                                                    .fontWeight(.bold)
                                                .foregroundColor(Color.gray)
                                                Spacer()
                                                Text(list.bookauthor)
                                                .font(.subheadline)
                                                .foregroundColor(Color.gray)
                                                Text("ISBN:\(list.bookisbn)")
                                                    .font(.subheadline)
                                                    .foregroundColor(Color.gray)
                                                Text("\(list.get_date)借阅 | \(list.real_back_date)归还")
                                                .font(.subheadline)
                                                .foregroundColor(Color.gray)
                                            }
                                        }
                                        
                                    }
                                }
                            }
                        }
            .lineSpacing(0)
                    }
                .alert(isPresented: self.$alertshow){
                    Alert(title: Text("提示"), message: Text(self.state))
                }
                    .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .onAppear{
                Api().get_jieyuelist(completion: { (list) in
                    self.state0 = list
                }, userid: self.userid, state: "0")
                
                Api().get_jieyuelist(completion: { (list) in
                    self.state1 = list
                }, userid: self.userid, state: "1")

                Api().get_jieyuelist(completion: { (list) in
                    self.state2 = list
                }, userid: self.userid, state: "2")

            }
            .blur(radius: self.warningshow ? 5 : 0)
            .animation(.default )
            //弹窗警告
            VStack(spacing:0) {
                Spacer()
                VStack {
                    Text("提示")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .offset(y:-10)
                    Text("是否还书？")
                        .font(.custom("FZKTJW.TTF", size: 13))
                }
                .offset(y:5)
                Spacer()
                Divider()
                HStack(){
                    Button(action: {
                        self.warningshow = false
                    }) {
                        Text("取消")
                            .frame(width:140,height:47)
                    }
                    Button(action: {
                        Api().student_backbook(username: self.username, bookisbn: self.bookisbn)
                        Api().phpStudentGetbooknum(isbn: self.bookisbn, tonum: "+1") { (state) in
                            self.state = state[0].state
                        }
                        self.warningshow = false
                        Api().get_jieyuelist(completion: { (list) in
                            self.state0 = list
                        }, userid: self.userid, state: "0")
                        
                        Api().get_jieyuelist(completion: { (list) in
                            self.state1 = list
                        }, userid: self.userid, state: "1")

                        Api().get_jieyuelist(completion: { (list) in
                            self.state2 = list
                        }, userid: self.userid, state: "2")
                        self.alertshow = true
                    }) {
                        Text("确定")
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
            .offset(y:-30)
            .opacity(self.warningshow ? 1 : 0)
            .animation(.default)
        }
        
    }
}

struct MyJieyue_Previews: PreviewProvider {
    static var previews: some View {
        MyJieyue(userid: .constant(""), jieyueshow: .constant(false) ,menuvieshow: .constant(false))
    }
}
