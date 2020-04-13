//
//  Teacher_Student_zeng.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/8.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI

struct Teacher_Student_zeng: View {
    @State var userid:String
    @State var userpass:String
    @State var username:String
    @State var userimg:String
    @State var warningshow:Bool = false
    @State var alertshow:Bool = false
    @State var returnstate:[isjieyue] = []
    var body: some View {
        ZStack {
            List {
                HStack {
                    Text("账号：")
                    SATextField(tag: 0, text:userid,placeholder: "学号为标准", changeHandler: { (newstr) in
                        self.userid = newstr
                    })
                }
                HStack {
                    Text("密码：")
                    SATextField(tag: 0, text:userpass,placeholder: "输入密码", changeHandler: { (newstr) in
                        self.userpass = newstr
                    })
                }
                HStack {
                    Text("姓名:  ")
                    SATextField(tag: 0, text:username,placeholder: "学生姓名", changeHandler: { (newstr) in
                        self.username = newstr
                    })
                }
                HStack {
                    Text("头像:  ")
                    SATextField(tag: 0, text:username,placeholder: "图片应为URL链接形式", changeHandler: { (newstr) in
                        self.userimg = newstr
                    })
                }
                
            }
            .blur(radius: self.warningshow ? 5 : 0)
            .animation(.default)
            Button(action: {
                //增加学生api
                if self.userid == "" || self.userpass == "" || self.username == "" || self.userimg == "" {
                    self.warningshow.toggle()
                }
                else{
                    Api().phpTeacherStudentzeng(completion: { (data) in
                        self.returnstate = data
                        self.alertshow.toggle()
                    }, studentid: self.userid, studentpass: self.userpass, studentname: self.username, studentimg: self.userimg)
                }
            }) {
                Text("提交")
                    .frame(width:230, height:45)
                //.foregroundColor(Color.white)
            }
                .blur(radius: self.warningshow ? 5 : 0)
                .animation(.default)
            .alert(isPresented: self.$alertshow) {
                Alert(title: Text("操作结果"), message: Text(self.returnstate[0].state))
            }
            .frame(width:230, height:45)
            .background(Color.white)
            .cornerRadius(13)
            .shadow(color:Color.gray, radius: 10, x: 0, y: 15)
            //自制弹窗
            VStack(spacing:0) {
                Spacer()
                VStack {
                    Text("警告⚠️")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .offset(y:-10)
                    Text("请完整填写完各项资料!")
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
        //.offset(y:-70)
    }
}

struct Teacher_Student_zeng_Previews: PreviewProvider {
    static var previews: some View {
        Teacher_Student_zeng(userid:"",userpass: "",username: "", userimg: "")
    }
}
