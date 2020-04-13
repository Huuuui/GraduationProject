//
//  Login.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/3/22.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import Alamofire


struct Login: View {
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
            VStack {
                Spacer()
                VStack {
                    HStack {
                       
                        
                        TextField("账号",text:$username) .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 230)
                    }
                    .padding(.bottom)
                    HStack {
                        
                        SecureField("密码",text: $userpass)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width:230)
                    }
                    .padding(.bottom)
                    
                    Button(action: {
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
                                    self.userid = self.username//主要用于学生页面，把账号提出去，用于以后的一些API访问带参
                                    
                                }
                                else if gzy[0].shenfen == "1" {
                                    self.studentshow = false
                                    self.teachershow = true
                                    self.showLogin.toggle()
                                    self.loginreturn = gzy
                                }
                            }
                            
                            
                        }, username: self.username, userpass: self.userpass)
                        
                        
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
            
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login( loginreturn: .constant([]), showLogin: .constant(false), teachershow: .constant(false), studentshow: .constant(false), userid: .constant("")) //.constant(false)
    }
}
