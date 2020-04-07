//
//  Teacher_zeng.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/2.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//      Teacher_zeng

import SwiftUI

struct Teacher_zeng: View {
    @State var teacherbookisbn:String
    @State var teacherbookname:String
    @State var teacherbookauthor:String
    @State var teacherbooktext:String
    @State var teacherbookimg:String
    @State var teacherbookscore:String
    @State var sele = 1
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .center) {
                    HStack {
                        Text("ISBN：")
                        SATextField(tag: 0, text:teacherbookisbn,placeholder: "请输入isbn", changeHandler: { (newstr) in
                            
                        })
                            
                            .frame(width: 200)
                        
                        
                    }.padding(.bottom)
                    
                    HStack {
                        Text("书名：")
                        
                        SATextField(tag: 0, text:teacherbookname,placeholder: "请输入书名", changeHandler: { (newstr) in
                            
                        })
                            
                            .frame(width: 200)
                    }.padding(.bottom)
                    HStack {
                        Text("作者：")
                        
                        SATextField(tag: 0, text:teacherbookauthor,placeholder: "请输入作者", changeHandler: { (newstr) in
                            
                        })
                            
                            .frame(width: 200)
                    }.padding(.bottom)
                    HStack {
                        Text("简介：\(self.teacherbookname)")
                        
                        SATextField(tag: 0, text:teacherbooktext,placeholder: "请输入简介", changeHandler: { (newstr) in
                            
                        })
                            
                            .frame(width: 200)
                    }.padding(.bottom)
                    HStack {
                        Text("图片：")
                        
                        SATextField(tag: 0, text:teacherbookimg,placeholder: "URL链接", changeHandler: { (newstr) in
                            
                        })
                            
                            .frame(width: 200)
                    }
                    .padding(.bottom)
                    HStack {
                        Text("评分：")
                        
                        SATextField(tag: 0, text:teacherbookscore,placeholder: "请输入评分", changeHandler: { (newstr) in
                            
                        })
                            
                            .frame(width: 200)
                    }
                    
                }.padding()
               
                Picker(selection: $sele, label: Text("类别")) {
                    Text("古典文学").tag(1)
                    Text("战争文学").tag(2)
                    Text("人文科普").tag(3)
                    Text("社会经济").tag(4)
                    Text("外国文学").tag(5)
                    Text("武侠经典").tag(6)
                    Text("中国文学").tag(7)
                }
                
                
                Button(action: {}){
                    HStack {
                        Image(systemName : "paperplane")
                            .resizable()
                            .frame(width:50 ,height: 45)
                            .foregroundColor(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
                        Spacer()
                    }
                    .padding(.leading,30)
                    .padding(.trailing,20)
                    .frame(width:90, height:65)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color:Color.gray, radius: 5, x: 0, y: 15)
                    
                }
                //.offset(x:-70,y:70)
                
                Spacer()
            }
        }
    }
}

struct Teacher_zeng_Previews: PreviewProvider {
    static var previews: some View {
        Teacher_zeng(teacherbookisbn: "", teacherbookname: "", teacherbookauthor: "", teacherbooktext: "", teacherbookimg: "", teacherbookscore: "")
    }
}
