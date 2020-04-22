//
//  Teacher_Student_gai.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/23.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct Teacher_Student_gai: View {
    @State var userid:String//搜索用的学号
    //可以修改学生密码、姓名、头像
    @State var userpass:String
    @State var username:String
    @State var userimg:String
    
    @State var warningshow: Bool = false    //学号为空
    @State var warningshow1: Bool = false       //未作查询就提交
    @State var warningshow2: Bool = false       //未做修改提交
    @State var warningshow3: Bool = false //确认提交
    @State var warningshow4: Bool = false //结果提示
    @State var alertshow: Bool = false
    @State var userok: Bool = false
    @State var user:[user] = []
    @State var state: String = ""
    var body: some View {
        ZStack{
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
                                }
                                else {
                                    self.alertshow = true
                                    self.userok = true
                                    self.user = user
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
                            Text("学号：")
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
                    }
                }
                List {
                    HStack {
                        Text("密码：")
                        SATextField(tag: 0, text:userpass,placeholder: "新密码", changeHandler: { (newstr) in
                            self.userpass = newstr
                        })
                    }
                    HStack {
                        Text("姓名:  ")
                        SATextField(tag: 0, text:username,placeholder: "新姓名", changeHandler: { (newstr) in
                            self.username = newstr
                        })
                    }
                    HStack {
                        Text("头像:  ")
                        SATextField(tag: 0, text:username,placeholder: "新头像URL链接", changeHandler: { (newstr) in
                            self.userimg = newstr
                        })
                    }
                }
            }
            .background(Color.white)
            //.edgesIgnoringSafeArea(.all)
                .blur(radius: self.warningshow || self.warningshow1 || self.warningshow2 || self.warningshow3 || self.warningshow4 ? 5 : 0)
                .animation(.default)
            VStack{
                Spacer()
                    .frame(height:240)
                Button(action: {
                    if self.user.count == 0 {
                        self.warningshow1 = true
                    }
                    else if self.userpass == "" && self.username == "" && self.userimg == "" {
                        self.warningshow2 = true
                    }
                    else {
                        self.warningshow3 = true
                    }
                }) {
                    Text("确认修改并提交")
                    .frame(width:230, height:45)
                    .background(Color.white)
                    .cornerRadius(13)
                    .shadow(color:Color.gray, radius: 10, x: 0, y: 15)
                }
            }
            .blur(radius: self.warningshow || self.warningshow1 || self.warningshow2 || self.warningshow3 || self.warningshow4 ? 5 : 0)
            .animation(.default)
            
            //确认提交弹窗
            VStack(spacing:0) {
                Spacer()
                VStack {
                    Text("提示")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .offset(y:-10)
                    Text("确认修改？")
                        .font(.custom("FZKTJW.TTF", size: 13))
                }
                .offset(y:5)
                Spacer()
                Divider()
                HStack(){
                    Button(action: {
                        self.warningshow3.toggle()
                    }) {
                        Text("取消")
                            .frame(width:140,height:47)
                    }
                    Button(action: {
                        if self.userpass == "" {
                            self.userpass = self.user[0].userpass
                        }
                        if self.username == "" {
                            self.username = self.user[0].userxingming
                        }
                        if self.userimg == "" {
                            self.userimg = self.user[0].usertouxiang
                        }
                        Api().phpTeacherStudentgai(userid: self.userid, userpass: self.userpass, userxingming: self.username, usertouxiang: self.userimg) { (state) in
                            if state.count > 0 {
                                self.state = state[0].state
                                self.warningshow4.toggle()
                            }
                            
                        }
                        self.warningshow3.toggle()
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
            .offset(y: -30)
            .opacity(self.warningshow3 ? 1 : 0)
            .animation(.default)
            //修改结果
            VStack(spacing:0) {
                Spacer()
                VStack {
                    Text("提示")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .offset(y:-10)
                    Text("修改成功")
                        .font(.custom("FZKTJW.TTF", size: 13))
                }
                .offset(y:5)
                Spacer()
                Divider()
                HStack(){
                    Button(action: {
                        self.warningshow4.toggle()
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
            .opacity(self.warningshow4 ? 1 : 0)
            .animation(.default)
            //未查询则提交弹窗
            VStack(spacing:0) {
                Spacer()
                VStack {
                    Text("警告⚠️")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .offset(y:-10)
                    Text("未做任何修改")
                        .font(.custom("FZKTJW.TTF", size: 13))
                }
                .offset(y:5)
                Spacer()
                Divider()
                HStack(){
                    Button(action: {
                        self.warningshow2.toggle()
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
            .opacity(self.warningshow2 ? 1 : 0)
            .animation(.default)
            //未查询则提交弹窗
            VStack(spacing:0) {
                Spacer()
                VStack {
                    Text("警告⚠️")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .offset(y:-10)
                    Text("请先查询后再提交修改！")
                        .font(.custom("FZKTJW.TTF", size: 13))
                }
                .offset(y:5)
                Spacer()
                Divider()
                HStack(){
                    Button(action: {
                        self.warningshow1.toggle()
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
            .opacity(self.warningshow1 ? 1 : 0)
            .animation(.default)
            //学号为空弹窗
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

struct Teacher_Student_gai_Previews: PreviewProvider {
    static var previews: some View {
        Teacher_Student_gai(userid: "", userpass: "",username: "",userimg: "")
    }
}
