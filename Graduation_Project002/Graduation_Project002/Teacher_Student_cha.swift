//
//  Teacher_Student_cha.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/8.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct Teacher_Student_cha: View {
    @State var userid:String
    @State var warningshow: Bool = false
    @State var alertshow: Bool = false
    @State var userok: Bool = false
    @State var user:[user] = []
    @State var guihuannum:[jieyuenum] = []
    @State var jieyuenum:[jieyuenum] = []
    @State var chaoqinum:[jieyuenum] = []
    
    @State var state0:[jieyuelist] = []
    @State var state1:[jieyuelist] = []
    @State var state2:[jieyuelist] = []
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("学号:")
                    TextField("学号", text: $userid)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        self.userok = false
                        if self.userid == "" {
                            self.warningshow = true
                        }
                        else {
                            Api().phpTeacherStudentcha(userid: self.userid) { (user) in
                                if user[0].username == "-1"
                                {
                                    self.alertshow = true
                                    self.guihuannum = []
                                    self.chaoqinum = []
                                    self.jieyuenum = []
                                    self.state0 = []
                                    self.state1 = []
                                    self.state2 = []
                                }
                                else {
                                    self.alertshow = true
                                    self.userok = true
                                    self.user = user
                                    Api().phpTeacherStudentchajieyue(userid: self.userid, state: "0") { (num) in
                                        self.guihuannum = num
                                    }
                                    Api().phpTeacherStudentchajieyue(userid: self.userid, state: "1") { (num) in
                                        self.jieyuenum = num
                                    }
                                    Api().phpTeacherStudentchajieyue(userid: self.userid, state: "2") { (num) in
                                        self.chaoqinum = num
                                    }
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
                            }
                        }
                    }) {
                        Text("查询")
                    }
                    .alert(isPresented: self.$alertshow) {
                        Alert(title: Text("操作结果"), message: Text(self.userok ? "查询成功":"查无此人"))
                    }
                    .frame(width:60, height:45)
                    .background(Color.white)
                    .cornerRadius(13)
                    .shadow(color:Color.gray, radius: 10, x: 0, y: 0)
                    
                    //.shadow(color:Color.red, radius: 10, x: 0, y: 15)
                }
                .padding(.horizontal)
                HStack {
                    WebImage(url: URL(string: self.userok  ? self.user[0].usertouxiang : ""))
                        .resizable()
                        .frame(width:130, height:170)
                        .cornerRadius(5)
                        .padding(.all,5)
                    //.background(Color.white)
                    Spacer()
                        .frame(width:30)
                    VStack(alignment:.leading ,spacing:18) {
                        HStack {
                            Text("账号：")
                            Text(self.userok  ? self.user[0].username : "")
                            
                        }
                        HStack {
                            Text("密码：")
                            Text(self.userok  ? self.user[0].userpass : "")
                        }
                        HStack {
                            Text("姓名：")
                            Text(self.userok  ? self.user[0].userxingming : "")
                        }
                        
                        HStack {
                            Text("正在借阅的图书数量：")
                            Text(self.jieyuenum.count == 1 ? self.jieyuenum[0].num : "")
                        }
                        HStack {
                            Text("已超期 | 已归还： ")
                            Text(self.chaoqinum.count == 1 && self.guihuannum.count == 1 ? "\(self.chaoqinum[0].num) | \(self.guihuannum[0].num)" : " | ")
                        }
                        
                        
                    }
                }
                Spacer()
                List {
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
                                        Text("你已超期，请立刻归还书籍")
                                            .font(.subheadline)
                                            .foregroundColor(Color.red)
                                    }
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
                                        Text("\(list.get_date)借阅 | \(list.back_date)归还")
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
            .background(Color.white)
            //.edgesIgnoringSafeArea(.all)
            
            
            //自制弹窗
            VStack(spacing:0) {
                Spacer()
                VStack {
                    Text("警告⚠️")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .offset(y:-10)
                    Text("请填写学号！")
                        .font(.custom("FZKTJW.TTF", size: 13))
                }
                .offset(y:5)
                Spacer()
                Divider()
                HStack(){
                    Button(action: {
                        self.warningshow.toggle()
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
            .offset(y: -30)
            .opacity(self.warningshow ? 1 : 0)
            .animation(.default)
        }
    }
}

struct Teacher_Student_cha_Previews: PreviewProvider {
    static var previews: some View {
        Teacher_Student_cha(userid:"")
    }
}
