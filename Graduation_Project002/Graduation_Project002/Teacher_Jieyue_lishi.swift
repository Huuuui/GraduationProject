//
//  Teacher_Jieyue_lishi.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/13.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

import Foundation
import CoreLocation
struct Teacher_Jieyue_lishi: View {
    @State var textisbn:String
    @State var textname:String
    @State var textauthor:String
    @State var jieyuebooklist:[booklist] = []
    @State var alertshow:Bool = false
    var body: some View {
        
        VStack(alignment:.center) {
            VStack {
                    SATextField1(tag: 0, text:textisbn,placeholder: "ISBN", changeHandler: { (newstr) in
                            self.textisbn = newstr
                    })
                    SATextField1(tag: 0, text:textname,placeholder: "图书名字", changeHandler: { (newstr) in
                            self.textname = newstr
                    })
                    SATextField1(tag: 0, text:textauthor,placeholder: "作者名字", changeHandler: { (newstr) in
                            self.textauthor = newstr
                    })
                Button(action: {
                    Api().phpTeacherJieyueSearch(completion: { (list) in
                        if list[0].bookisbn != "-1" {
                            self.jieyuebooklist = list
                        }
                        else {
                            self.jieyuebooklist = []
                            self.alertshow.toggle()
                        }
                    }, bookisbn: self.textisbn, bookname: self.textname, bookauthor: self.textauthor)
                }) {
                    Text("搜索")
                    .frame(width:400,height:40)
                }
                //.frame(width:650,height:40)
                .background(Color.white)
                .cornerRadius(30)
                .shadow(color:Color.gray, radius: 10, x: 0, y: 5)
                    

            }
            .frame(width:400)
            .alert(isPresented: self.$alertshow){
                    Alert(title: Text("查询结果"), message: Text("查无此书"))
            }
            //Spacer()
               // .frame(height:10)
            List(self.jieyuebooklist) { item in
                        HStack {
                            //Text(item.bookimg)
                            WebImage(url:URL(string: item.bookimg))
                                .resizable()
                                .frame(width: 90, height: 130, alignment: .top)
                                .cornerRadius(10)
                            
                            VStack(alignment:.leading,spacing: 10){
                                Text("\(item.bookname)")
                                    .font(.title)
                                    .font(.system(size:20))
                                    .lineLimit(1)
                                Text("作者:\(item.bookauthor)")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text("ISBN:\(item.bookisbn)")
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text(item.booktext)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                    .lineLimit(2)
                            }
                        }
            }
        }
    }
}

struct Teacher_Jieyue_lishi_Previews: PreviewProvider {
    static var previews: some View {
        Teacher_Jieyue_lishi(textisbn: "",textname: "",textauthor: "")
    }
}
