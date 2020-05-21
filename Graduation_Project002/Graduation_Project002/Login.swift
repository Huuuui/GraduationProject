//
//  Login.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/3/22.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import Alamofire
let netModel = CFNetHelper()

struct Login: View {
    @ObservedObject var model = netModel
    @State var warningshow:Bool = false
    @State var textshow:Bool = false
    @State var warningtext1:String = "账号或密码为空!"
    @State var warningtext2:String = "网络连接已断开!"
    
    @State var username : String = ""
    @State var userpass : String = ""
    @State var shenfen: String = "-1"
    @Binding var loginreturn:[loginreturn]
    //@State var caonima:Bool = false
    @State var viewState = CGSize.zero
    @Binding var showLogin : Bool
    @Binding var teachershow: Bool
    @Binding var studentshow: Bool
    @State var jieyueshow: Bool = true
    @State var txt = "123"
    @State var alertshow: Bool = false
    @State var loginstate: String = ""
    @Binding var userid:String
    var body: some View {
        ZStack {
            Color.white
            Image("login1")
                .resizable()
                .frame(width:screen.width,height:720)
                .blur(radius: self.warningshow ? 5 : 0)
                .animation(.default)
            VStack {
                Spacer()
                VStack {
                    HStack {
                        
                        SATextField(tag: 0, text:userid,placeholder: "账号", changeHandler: { (newstr) in
                            self.userid = newstr
                        })
                            .frame(width: 230)
                        //                        TextField("账号",text:$username) .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                    }
                    .padding(.bottom)
                    HStack {
                        
                        SecureField("密码",text: $userpass)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width:230)
                    }
                    .padding(.bottom)
                    
                    Button(action: {
                        if self.userid == "" || self.userpass ==  "" {
                            self.textshow = false
                            self.warningshow.toggle();
                        }
                        else {
                            if self.model.netok {
                                Api().to_Login(completion: { (gzy) in
                                    if gzy[0].shenfen == "-10"{
                                        self.loginstate = "账号或密码错误"
                                        self.alertshow.toggle()
                                    }
                                    else {
                                        if gzy[0].shenfen == "0"{
                                            //self.showLogin.toggle()
                                            self.studentshow = true
                                            self.teachershow = false
                                            self.showLogin.toggle()
                                            self.loginreturn = gzy
                                            //self.userid = self.username//主要用于学生页面，把账号提出去，用于以后的一些API访问带参
                                            Api().JieyueJiance(username:self.userid)
                                            
                                        }
                                        else if gzy[0].shenfen == "1" {
                                            self.studentshow = false
                                            self.teachershow = true
                                            self.showLogin.toggle()
                                            self.loginreturn = gzy
                                        }
                                    }
                                    
                                    
                                }, username: self.userid, userpass: self.userpass)
                            }
                            else {
                                self.textshow = true
                                self.warningshow.toggle()
                            }
                        }
                        
                        
                        
                        //                    }
                    })
                    {
                        Image(systemName : "chevron.right.circle")
                            .resizable()
                            .frame(width:50,height:50)
                            .foregroundColor(Color.gray)
                    }
                    .alert(isPresented: self.$alertshow){
                        Alert(title: Text("提示"), message: Text(self.loginstate))
                    }
                    //.offset(x : 15, y : 15)
                    Spacer()
                        .frame(height: 80)
                }
                    
                .padding()
                
                Spacer()
                    .frame(height:190)
                
            }
            .blur(radius: self.warningshow ? 5 : 0)
            .animation(.default)
            
            
            //弹窗
            VStack(spacing:0) {
                Spacer()
                VStack {
                    Text("提示")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .offset(y:-10)
                    Text(self.textshow ? self.warningtext2 : self.warningtext1)
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

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login( loginreturn: .constant([]), showLogin: .constant(false), teachershow: .constant(false), studentshow: .constant(false), userid: .constant("")) //.constant(false)
    }
}
