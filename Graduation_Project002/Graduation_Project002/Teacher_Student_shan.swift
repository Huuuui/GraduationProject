//
//  Teacher_Student_shan.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/8.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI

struct Teacher_Student_shan: View {
    @State var userid:String
    @State var warningshow:Bool = false
    @State var alertshow:Bool = false
    @State var idnull:Bool = false
    @State var state:[isjieyue] = []
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("学号:")
                    TextField("慎重考虑", text: self.$userid)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width:250)
                }
                Spacer()
                    .frame(height:70)
                Button(action: {
                    if self.userid == "" {
                        self.idnull = true
                    }
                    self.warningshow.toggle()
                }) {
                    Text("删除")
                    .frame(width:230, height:45)
                }
                .frame(width:230, height:45)
                .background(Color.white)
                .cornerRadius(13)
                .shadow(color:Color.red, radius: 10, x: 0, y: 15)
            }
                .blur(radius: self.warningshow ? 5 : 0)
                .animation(.default)
            .offset(y:-100)
            .alert(isPresented: self.$alertshow) {
                Alert(title: Text("操作结果"), message: Text(self.state[0].state))
            }
            //自制弹窗
            
            VStack(spacing:0) {
                Spacer()
                VStack {
                    Text("警告⚠️")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .offset(y:-10)
                    Text(self.idnull ? "学号不可为空！" : "确定删除吗？")
                        .font(.custom("FZKTJW.TTF", size: 13))
                }
                .offset(y:5)
                Spacer()
                Divider()
                HStack(){
                    Button(action: {
                        //调用删除Api
                        if self.idnull == true {
                            self.idnull = false
                            self.warningshow.toggle()
                        }
                        else if self.idnull == false {
                            Api().phpTeacherStudentshan(completion: { (state) in
                                self.state = state
                                self.alertshow.toggle()
                            }, studentid: self.userid)
                            self.warningshow.toggle()
                            self.idnull = false
                        }
                        
                        //self.alertshow.toggle()
                    }) {
                        Text("确定")
                            .frame(width:140,height:47)
                    }
                    Button(action: {
                        self.idnull = false
                        self.warningshow.toggle()
                    }) {
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
                
            .background(BlurView(style: .extraLight))
            .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)),Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))]), startPoint: UnitPoint.top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(0.2), radius: 20, x: 0, y: 20)
            .frame(width:280,height:  120 )
            .offset(y: -30)
            .opacity(self.warningshow ? 1 : 0)
            .animation(.default)
        }
    }
}

struct Teacher_Student_shan_Previews: PreviewProvider {
    static var previews: some View {
        Teacher_Student_shan(userid: "")
    }
}
