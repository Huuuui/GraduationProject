//
//  Book.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/3/9.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Foundation
import CoreLocation

struct Book: View {
    @Binding var userid:String
    
    @State var bookimg: String
    @State var booktitle: String
    @State var bookauthor: String
    @State var bookclass: String
    @State var booktxt: String
    @State var bookfen: String
    @State var bookisbn: String
    @State var nownum: String = "-1"
    @State var isjieyue:Bool = false
    @State var state:String = ""
    @State var alertshow: Bool = false  //库存不足弹窗
    @State var alertshow1: Bool = false    //是否借阅、是否归还弹窗
    @State var sysalertshow: Bool = false //系统自带的alert
    var body: some View {
        ZStack {
            VStack {
                Color("light_gray").frame(height: 300) // 下拉时露出的灰色背景
                Spacer() // 避免到底部上拉出现背景
            }
            .blur(radius: self.alertshow ? 5 : 0)
            .animation(.default)
            ScrollView {
                VStack{
                    HStack {
                        
                            WebImage(url:URL(string: bookimg))
                            .resizable()
                            .frame(width:120, height:170)
                            .cornerRadius(5)
                            .padding(.all,5)
                            .background(Color.white)
                        
                        VStack(alignment: .leading ,spacing: 29) {
                            Text("作品名称：" + self.booktitle)
                            
                            Text("作者：" + self.bookauthor)
                            
                            Text("类别：" + self.bookclass)
                            
                            Text("豆瓣评分：" + self.bookfen)
                            
                            Text("库存：" + self.nownum)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    Text("简介：   \n" + "     " + self.booktxt)
                    Divider()
                    Spacer()
                    HStack {
                        Button(action: {
                            self.alertshow1 = true
                            
                        }) {
                            Image(systemName:"\(self.isjieyue ? "star.fill" : "star")")
                                .resizable()
                                .frame(width:40 , height:40)
                            Text("\(self.isjieyue ? "已借阅" : "未借阅")")
                        }
                        .alert(isPresented: self.$sysalertshow){
                            Alert(title: Text("提示"), message: Text(self.state))
                        }
                        Spacer()
                        
                        
                    }
                    .padding()
                    
                    
                }
                .onAppear{
                    Api().get_isjieyue(completion: { (state) in //进入book页面则自动调取api查询这本书的借阅状态
                        if state.count > 0 {
                            if state[0].state == "1" || state[0].state == "2"  {
                                self.isjieyue = true
                            }
                            else {
                                self.isjieyue = false
                            }
                        }
                        else {
                            self.isjieyue = false
                        }
                        
                    }, userid: self.userid, bookisbn: self.bookisbn)
                    Api().phpStudentGetbooknownum(bookisbn: self.bookisbn) { (nownum) in
                        self.nownum = nownum[0].booknum
                    }
                }
                .background(BlurView(style: .systemChromeMaterial))
                //.navigationBarTitle(self.booktitle)
                
            }
            .blur(radius: self.alertshow || self.alertshow1 ? 5 : 0)
            .animation(.default)
            //自制弹窗  是否借阅、是否归还弹窗
            VStack(spacing:0) {
                Spacer()
                VStack {
                    Text("提示")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .offset(y:-10)
                    Text("\(self.isjieyue ? "确定还书吗？" : "确定借阅吗？" )")
                        .font(.custom("FZKTJW.TTF", size: 13))
                }
                    .offset(y:5)
                Spacer()
                Divider()
                HStack(){
                    Button(action: {
                        self.alertshow1.toggle()
                    }) {
                        Text("取消")
                            .frame(width:140,height:47)
                    }
                    Button(action: {

                        self.alertshow1 = false
                        if self.isjieyue == false && self.nownum != "0" {//未被借阅并且当前库存量大于0
                            Api().student_getbook(username: self.userid, bookisbn: self.bookisbn, bookname: self.booktitle, bookimg: self.bookimg, bookauthor: self.bookauthor)
                            Api().phpStudentGetbooknum(isbn: self.bookisbn, tonum: "-1") { (state) in
                                self.state = state[0].state
                                if state.count == 1 {
                                    self.sysalertshow = true
                                }
                            }
                            Api().phpStudentGetbooknownum(bookisbn: self.bookisbn) { (num) in
                                self.nownum = num[0].booknum
                            }
                            self.sysalertshow = true
                            self.isjieyue = true
                        }
                        else if self.isjieyue == false && self.nownum == "0"{
                            //处于未借阅但是库存量为0
                            self.alertshow.toggle()
                            self.alertshow1 = false
                        }
                        else if self.isjieyue == true {//还书就比较简单了 只要处于借阅状态 就可以还书
                            
                            self.isjieyue = false
                            self.alertshow1 = false
                            Api().student_backbook(username: self.userid, bookisbn: self.bookisbn)
                            Api().phpStudentGetbooknum(isbn: self.bookisbn, tonum: "+1") { (state) in
                                
                                
                                self.state = state[0].state
                                if state.count == 1 {
                                    self.sysalertshow = true
                                }
                            }
                            Api().phpStudentGetbooknownum(bookisbn: self.bookisbn) { (num) in
                                self.nownum = num[0].booknum
                            }
                        }
                    }) {
                        Text("确定")
                            .frame(width:140,height:47)
                    }
                    
                }
            .overlay(
                Text("")
                    .frame(width:0.4 ,height:47)
                    .background(Color.gray)
                )
            }
            .frame(width:280,height: 120)
            .background(BlurView(style: .extraLight))
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: UnitPoint.top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(self.alertshow1 ? 1 : 0)
            .animation(.default)
            //自制弹窗 库存不足弹窗
            VStack(spacing:0) {
                Spacer()
                VStack {
                    Text("警告⚠️")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .offset(y:-10)
                    Text("库存不足")
                        .font(.custom("FZKTJW.TTF", size: 13))
                }
                    .offset(y:5)
                Spacer()
                Divider()
                HStack(){
                    Button(action: {
                        self.alertshow.toggle()
                    }) {
                        Text("确定")
                            .frame(width:280,height:47)
                    }
                }
            }
            .frame(width:280,height: 120)
            .background(BlurView(style: .extraLight))
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: UnitPoint.top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
            .opacity(self.alertshow ? 1 : 0)
            .animation(.default)
        }
        
        
        
    }
}

struct Book_Previews: PreviewProvider {
    static var previews: some View {
        Book( userid: .constant(""), bookimg: "", booktitle: "", bookauthor: "", bookclass: "", booktxt: "",bookfen:"", bookisbn: "")
    }
}
