//
//  Book.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/3/9.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Foundation
import CoreLocation

struct Book: View {
    @Binding var userid:String
    
    @State var bookimg: String
    @State var booktitle: String
    @State var bookauthor: String
    @State var bookclass: String
    @State var booktxt: String
    @State var bookfen: String
    @State var bookisbn: String
    
    @State var isjieyue:Bool = false
    var body: some View {
        ZStack {
            VStack {
                Color("light_gray").frame(height: 300) // 下拉时露出的灰色背景
                Spacer() // 避免到底部上拉出现背景
            }
            ScrollView {
                VStack{
                    HStack {
                        
                            WebImage(url:URL(string: bookimg))
                            .resizable()
                            .frame(width:120, height:170)
                            .cornerRadius(5)
                            .padding(.all,5)
                            .background(Color.white)
                        
                        VStack(alignment: .leading ,spacing: 29) {
                            Text("作品名称：" + self.booktitle)
                            
                            Text("作者：" + self.bookauthor)
                            
                            Text("类别：" + self.bookclass)
                            
                            Text("豆瓣评分：" + self.bookfen)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    Text("简介：   \n" + "     " + self.booktxt)
                    Divider()
                    Spacer()
                    HStack {
                        Button(action: {
                            if self.isjieyue == false {
                                Api().student_getbook(username: self.userid, bookisbn: self.bookisbn, bookname: self.booktitle, bookimg: self.bookimg, bookauthor: self.bookauthor)
                                self.isjieyue = true
                            }
                            else if self.isjieyue == true {
                                Api().student_backbook(username: self.userid, bookisbn: self.bookisbn)
                                self.isjieyue = false
                            }
                            
                        }) {
                            Image(systemName:"\(self.isjieyue ? "star.fill" : "star")")
                                .resizable()
                                .frame(width:40 , height:40)
                            Text("\(self.isjieyue ? "已借阅" : "未借阅")")
                        }
                        Spacer()
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            Image(systemName:"star")
                                .resizable()
                                .frame(width:40 , height:40)
                            Text("收藏")
                        }
                        
                    }
                    .padding()
                    
                    
                }
                .onAppear{
                    Api().get_isjieyue(completion: { (state) in
                        if state.count > 0 {
                            if state[0].state == "1" || state[0].state == "2"  {
                                self.isjieyue = true
                            }
                            else {
                                self.isjieyue = false
                            }
                        }
                        else {
                            self.isjieyue = false
                        }
                        
                    }, userid: self.userid, bookisbn: self.bookisbn)
                }
                .background(BlurView(style: .systemChromeMaterial))
                //.navigationBarTitle(self.booktitle)
                
            }
        }
        
        
        
    }
}

struct Book_Previews: PreviewProvider {
    static var previews: some View {
        Book( userid: .constant(""), bookimg: "", booktitle: "", bookauthor: "", bookclass: "", booktxt: "",bookfen:"", bookisbn: "")
    }
}
