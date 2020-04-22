//
//  TeacherManagement.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/2.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Foundation
import CoreLocation

struct TeacherManagement: View {
    //Teacher_zeng(teacherbookisbn: "", teacherbookname: "", teacherbookauthor: "", teacherbooktext: "", teacherbookimg: "", teacherbookscore: "")
    @Binding var xingming: String
    @Binding var touxiang: String
    @Binding var showlogin : Bool
    @Binding var teachershow : Bool
    @State var alertshow : Bool = false
    var body: some View {
        NavigationView {
            VStack{
                
                HStack{// 后台封面
                    WebImage(url: URL(string: self.touxiang))
                        //WebImage(url: URL(string: "asdw捱三顶五群多"))
                        .resizable()
                        .frame(width:120, height:170)
                        .cornerRadius(5)
                        .padding(.all,5)
                        .background(Color.white)
                        .offset(x:10)
                    Spacer()
                    VStack{
                        Text(self.xingming)
                            .font(.system(size: 20, design: .rounded))
                            //.underline()
                            .padding(.top,20)
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            
                            HStack {
                                Image(systemName: "arrow.left.circle")
                                    .resizable()
                                    .frame(width:30, height:30)
                                Text("退出登录")
                                    .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                                    .font(.system(size: 20, design: .rounded))
                            }
                            .onTapGesture {
                                self.alertshow.toggle()
                            }
                        }
                        .alert(isPresented: self.$alertshow){
                            Alert(title: Text("提示"), message: Text("确定退出吗？"), primaryButton: .cancel(Text("取消")), secondaryButton: .default(Text("确定"), action: {
                                self.showlogin.toggle()
                                self.teachershow.toggle()
                            }))
                        }
                        .padding(.bottom,20)
                        
                    }
                    
                    Spacer()
                }
                .frame(height:150)
                .padding(.bottom,20)
                Divider()
                List {
                    Section(header:Text("图文管理")) {
                        NavigationLink(destination: Teacher_Book_zeng()) {
                            
                            Text("      添加新书") //这个地方如果是按钮就会造成没有办法跳转页面，NavigationLink其实也是一个View可以用各种属性进行修饰
                        }
                        NavigationLink(destination: Teacher_Book_shan(isbn:"")) {
                            Text("      移除旧书")
                        }
                        
                        NavigationLink(destination: Teacher_Book_gai(isbn: "",bookname: "", bookauthor: "", booktext: "", bookimg: "", bookscore: "", booknum: "", newbookclass: "")) {
                            Text("      更新书籍")
                        }
                        
                        NavigationLink(destination: Teacher_Book_cha(isbn: "",bookname: "", bookauthor: "", booktext: "", bookimg: "", bookscore: "", booknum: "")) {
                            Text("      书籍检索")
                        }
                    }
                    Section(header:Text("学生管理")){
                        NavigationLink(destination: Teacher_Student_zeng(userid:"",userpass: "",username: "", userimg: "")) {
                            Text("      学生信息录入")
                        }
                        NavigationLink(destination: Teacher_Student_shan(userid: "")) {
                            Text("      学生信息移除")
                        }
                        NavigationLink(destination: Teacher_Student_gai(userid: "", userpass: "",username: "",userimg: "")) {
                            Text("      学生信息更新")
                        }
                        NavigationLink(destination: Teacher_Student_cha(userid:"")) {
                            Text("      学生信息检索")
                        }
                        
                    }
                    Section(header:Text("借阅管理")){
                        NavigationLink(destination: Teacher_Jieyue_lishi(textisbn: "",textname: "",textauthor: "")) {
                            Text("      书籍借阅管理")
                        }
                    }
                }
                
                
            }
            .navigationBarTitle(Text("系统后台"))
            
            //.navigationViewStyle(.)
            //.navigationBarHidden(true)
            //.padding(.top,150)
        }
        
    }
}

struct TeacherManagement_Previews: PreviewProvider {
    static var previews: some View {
        TeacherManagement(xingming: .constant(""), touxiang: .constant(""), showlogin: .constant(false), teachershow: .constant(false))
    }
}
