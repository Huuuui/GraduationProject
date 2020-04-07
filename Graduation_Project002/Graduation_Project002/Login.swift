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
    
    @Binding var userid:String
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        self.showLogin.toggle()
                        //self.caonima.toggle()
                        
                    }) {
                        Image(systemName:"xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                        
                    .padding(.trailing, 20)
                    .foregroundColor(Color.black)
                    
                }
                Spacer()
                VStack {
                    HStack {
                        Text("账号：")
                        
                        TextField("",text:$username) .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                    }
                    .padding(.bottom)
                    HStack {
                        Text("密码：")
                        SecureField("",text: $userpass)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width:200)
                    }
                    .padding(.bottom)
                    
                    Button(action: {
                        Api().to_Login(completion: { (gzy) in
                            if gzy[0].shenfen == "0"{
                                //self.showLogin.toggle()
                                self.studentshow = true
                                self.teachershow = false
                                self.showLogin.toggle()
                                self.loginreturn = gzy
                                self.userid = self.username
                                
                            }
                            else if gzy[0].shenfen == "1" {
                                self.studentshow = false
                                self.teachershow = true
                                self.showLogin.toggle()
                            }
                            
                        }, username: self.username, userpass: self.userpass)
                        
                        
                        //                    }
                    })
                    {
                        Image(systemName : "arrow.right.circle.fill")
                            .resizable()
                            .frame(width:50,height:50)
                    }
                    .offset(x : 15, y : 15)
                    Spacer()
                        .frame(height: 80)
                }
                    
                .padding()
                
                Spacer()
                
            }
            
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login( loginreturn: .constant([]), showLogin: .constant(false), teachershow: .constant(false), studentshow: .constant(false), userid: .constant("")) //.constant(false)
    }
}
