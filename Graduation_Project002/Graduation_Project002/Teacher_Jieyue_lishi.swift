//
//  Teacher_Jieyue_lishi.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/13.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

import Foundation
import CoreLocation
struct Teacher_Jieyue_lishi: View {
    @State var textisbn:String
    @State var textname:String
    @State var textauthor:String
    @State var jieyuebooklist:[booklist] = []
    @State var alertshow:Bool = false
    @State var sheetshow:Bool = false
    
    
    //负责给分页传数据
    @State var bookisbn:String = ""
    @State var bookimg: String = ""
    @State var bookname: String = ""
    @State var bookauthor: String = ""
    @State var bookclass: String = ""
    @State var bookscore: String = ""
    @State var nownum:String = ""
    @State var state0:[managementjieyue] = []
    @State var state1:[managementjieyue] = []
    @State var state2:[managementjieyue] = []
    @State var item:Int = 0
    var body: some View {
        
        ZStack {
            VStack(alignment:.center) {
                VStack {
                    SATextField1(tag: 0, text:textisbn,placeholder: "ISBN", changeHandler: { (newstr) in
                        self.textisbn = newstr
                    })
                    SATextField1(tag: 0, text:textname,placeholder: "图书名字", changeHandler: { (newstr) in
                        self.textname = newstr
                    })
                    SATextField1(tag: 0, text:textauthor,placeholder: "作者名字", changeHandler: { (newstr) in
                        self.textauthor = newstr
                    })
                    Button(action: {
                        Api().phpTeacherJieyueSearch(completion: { (list) in
                            if list[0].bookisbn != "-1" {
                                self.jieyuebooklist = list
                            }
                            else {
                                self.jieyuebooklist = []
                                self.alertshow.toggle()
                            }
                        }, bookisbn: self.textisbn, bookname: self.textname, bookauthor: self.textauthor)
                    }) {
                        Text("搜索")
                            .frame(width:400,height:40)
                    }
                        //.frame(width:650,height:40)
                        .background(Color.white)
                        .cornerRadius(30)
                        .shadow(color:Color.gray, radius: 10, x: 0, y: 5)
                    
                    
                }
                .frame(width:400)
                .alert(isPresented: self.$alertshow){
                    Alert(title: Text("查询结果"), message: Text("查无此书"))
                }
                //Spacer()
                // .frame(height:10)
                List{
                    ForEach(0..<self.jieyuebooklist.count,id:\.self) { item in
                        HStack {
                            //Text(item.bookimg)
                            WebImage(url:URL(string: self.jieyuebooklist[item].bookimg))
                                .resizable()
                                .frame(width: 90, height: 130, alignment: .top)
                                .cornerRadius(10)
                            
                            VStack(alignment:.leading){
                                Text("\(self.jieyuebooklist[item].bookname)")
                                    .font(.title)
                                    .font(.system(size:20))
                                    .lineLimit(1)
                                Text("作者:\(self.jieyuebooklist[item].bookauthor)")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text("ISBN:\(self.jieyuebooklist[item].bookisbn)")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text(self.jieyuebooklist[item].booktext)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
                        .onTapGesture {
                            self.item = item
                            self.sheetshow.toggle()
                        }
                        
                    }
                    
                }
                .sheet(isPresented: self.$sheetshow) {
                    ExtractedView(
                        bookisbn: self.jieyuebooklist[self.item].bookisbn,
                        bookimg: self.jieyuebooklist[self.item].bookimg,
                        bookname: self.jieyuebooklist[self.item].bookname,
                        bookauthor: self.jieyuebooklist[self.item].bookauthor,
                        bookclass: self.jieyuebooklist[self.item].bookclass,
                        bookscore: self.jieyuebooklist[self.item].bookscore)
                }
            }
        }
    }
}

struct Teacher_Jieyue_lishi_Previews: PreviewProvider {
    static var previews: some View {
        Teacher_Jieyue_lishi(textisbn: "",textname: "",textauthor: "")
    }
}

struct ExtractedView: View {
    @State var bookisbn:String
    @State var bookimg:String
    @State var bookname:String
    @State var bookauthor:String
    @State var bookclass:String
    @State var bookscore:String
    @State var nownum:String = ""
    //用来返回结果这本书的人的学号、姓名
    @State var state0:[managementjieyue] = []
    @State var state1:[managementjieyue] = []
    @State var state2:[managementjieyue] = []
     //用来返回借过这本书得人的归还时间、借阅时间
    @State var state00:[managementjieyue2] = []
    @State var state11:[managementjieyue2] = []
    @State var state22:[managementjieyue2] = []
    
    @State var warningshow:Bool = false
    @State var alertshow:Bool = false
    @State var userid:String = ""
    @State var state:String = ""
    var body: some View {
        return
            ZStack {
                Color.white
                VStack{
                    HStack {
                        
                        WebImage(url:URL(string: self.bookimg))
                            .resizable()
                            .frame(width:120, height:170)
                            .cornerRadius(5)
                            .padding(.all,5)
                            .background(Color.white)
                        
                        VStack(alignment: .leading ,spacing: 29) {
                            Text("作品名称：" + self.bookname)
                            
                            Text("作者：" + self.bookauthor)
                            
                            Text("类别：" + self.bookclass)
                            
                            Text("豆瓣评分：" + self.bookscore)
                            
                            Text("库存：" + self.nownum)
                        }
                        Spacer()
                    }
                    List{
                        Section(header:Text("借阅中")){
                            if self.state1.count > 0 && self.state11.count > 0 {
                                ForEach(0..<self.state1.count,id: \.self) { state in
                                    
                                    HStack{
                                        Text("\(self.state1[state].username),\(self.state1[state].userxingming)    \(self.state11[state].get_date)借阅")//\(self.state11[state].get_date)借阅
                                    }
                                    .onTapGesture {
                                        self.userid = self.state1[state].username
                                        self.warningshow = true
                                    }
                                }
                            }
                            
                        }
                        Section(header:Text("超期")){
                            if self.state2.count > 0 && self.state22.count > 0 {
                                ForEach(0..<self.state2.count,id: \.self) { state in
                                    HStack{
                                        Text("\(self.state2[state].username),\(self.state2[state].userxingming) 罚金:\(self.state22[state].fine) 元")
                                    }
                                    .onTapGesture {
                                        self.userid = self.state2[state].username
                                        self.warningshow = true
                                    }
                                }
                            }
                            
                        }
                        Section(header:Text("借阅历史")){
                            if self.state0.count > 0 && self.state00.count > 0 {
                                ForEach(0..<self.state0.count,id: \.self) { state in
                                    HStack{
                                        Text("\(self.state0[state].username),\(self.state0[state].userxingming)   \(self.state00[state].get_date)借阅 | \(self.state00[state].real_back_date)归还")
                                    }
                                }
                            }
                            
                        }
                    }
                }
                .blur(radius: self.warningshow ? 5 : 0)
                .animation(.default)
                
                //弹窗警告
                VStack(spacing:0) {
                    Spacer()
                    VStack {
                        Text("提示")
                            .font(.system(size: 16, weight: .bold, design: .default))
                            .offset(y:-10)
                        Text("确定帮该生还书吗？")
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
                            Api().student_backbook(username: self.userid, bookisbn: self.bookisbn)
                            Api().phpStudentGetbooknum(isbn: self.bookisbn, tonum: "+1") { (state) in
                                self.state = state[0].state
                            }
                            self.warningshow = false
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
            .alert(isPresented: self.$alertshow){
                Alert(title: Text("提示"), message: Text(self.state), dismissButton: .default(Text("确认"), action: {
                    self.state0 = []
                    self.state1 = []
                    self.state2 = []
                    
                    self.state00 = []
                    self.state11 = []
                    self.state22 = []
                    Api().phpStudentGetbooknownum(bookisbn: self.bookisbn) { (nownum) in
                        self.nownum = nownum[0].booknum
                    }
                    Api().phpTeacherJieyueLishi(completion: { (state) in
                        if state.count > 0 {
                            self.state0 = state
                        }
                    }, bookisbn: self.bookisbn, state: "0")
                    Api().phpTeacherJieyueLishi2(completion: { (state) in
                        if state.count > 0 {
                            self.state00 = state
                        }
                    }, bookisbn: self.bookisbn, state: "0")

                    Api().phpTeacherJieyueLishi(completion: { (state) in
                        if state.count > 0 {
                            self.state1 = state
                        }
                    }, bookisbn: self.bookisbn, state: "1")
                    
                    Api().phpTeacherJieyueLishi2(completion: { (state) in
                        if state.count > 0 {
                            self.state11 = state
                        }
                    }, bookisbn: self.bookisbn, state: "1")
                    
                    Api().phpTeacherJieyueLishi(completion: { (state) in
                        if state.count > 0 {
                            self.state2 = state
                        }
                    }, bookisbn: self.bookisbn, state: "2")
                    
                    Api().phpTeacherJieyueLishi2(completion: { (state) in
                        if state.count > 0 {
                            self.state22 = state
                        }
                    }, bookisbn: self.bookisbn, state: "2")
                }))
            }
            .onAppear{
                Api().phpStudentGetbooknownum(bookisbn: self.bookisbn) { (nownum) in
                    self.nownum = nownum[0].booknum
                }

                Api().phpTeacherJieyueLishi(completion: { (state) in
                    if state.count > 0 {
                        self.state0 = state
                    }
                }, bookisbn: self.bookisbn, state: "0")
                Api().phpTeacherJieyueLishi2(completion: { (state) in
                    if state.count > 0 {
                        self.state00 = state
                    }
                }, bookisbn: self.bookisbn, state: "0")

                Api().phpTeacherJieyueLishi(completion: { (state) in
                    if state.count > 0 {
                        self.state1 = state
                    }
                }, bookisbn: self.bookisbn, state: "1")
                
                Api().phpTeacherJieyueLishi2(completion: { (state) in
                    if state.count > 0 {
                        self.state11 = state
                    }
                }, bookisbn: self.bookisbn, state: "1")
                Api().phpTeacherJieyueLishi(completion: { (state) in
                    if state.count > 0 {
                        self.state2 = state
                    }
                }, bookisbn: self.bookisbn, state: "2")
                
                Api().phpTeacherJieyueLishi2(completion: { (state) in
                    if state.count > 0 {
                        self.state22 = state
                    }
                }, bookisbn: self.bookisbn, state: "2")
        }
    }
}


