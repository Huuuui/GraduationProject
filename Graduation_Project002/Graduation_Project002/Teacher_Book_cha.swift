//
//  Teacher_Book_cha.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/8.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct Teacher_Book_cha: View {
    @State var isbn:String
    @State var bookname:String
    
    @State var bookauthor:String
    @State var booktext:String
    @State var bookimg:String
    @State var bookscore:String
    @State var booknum:String
    @State var book:[booklist] = []
    @State var userxingming:[tbchalishi] = []
    @State var alertshow: Bool = false
    @State var nownum:String = ""
    var body: some View {
        
            VStack {
                HStack {
                    Text("ISBN:")
                    TextField("ISBN", text: $isbn)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        //查询图书信息api
                        Api().phpTeacherBookCHAgai(bookisbn: self.isbn, completion: { (book) in
                            if book[0].bookisbn == "-1"{
                                self.alertshow.toggle()
                                self.book = []
                            }
                            else {
                                Api().phpStudentGetbooknownum(bookisbn: self.isbn) { (num) in
                                    self.nownum = num[0].booknum
                                }
                                self.book = book
                            }
                        })
                        
                        Api().phpTeacherBookchalishi(bookisbn:
                            self.isbn,completion: { (name) in
                            self.userxingming = name
                        }
                        )
                    }) {
                        Text("查询")
                    }
                    .alert(isPresented:$alertshow){
                        Alert(title: Text("警告⚠️"), message: Text("查无此书"))
                    }
                    .frame(width:60, height:45)
                        .background(Color.white)
                        .cornerRadius(13)
                        .shadow(color:Color.gray, radius: 10, x: 0, y: 0)
                    
                    //.shadow(color:Color.red, radius: 10, x: 0, y: 15)
                }
                .padding(.horizontal)
                List{
                    Group {
                        Section(header: Text("图书")) {
                            HStack {
                                WebImage(url: URL(string: self.book.count == 1 ? self.book[0].bookimg : "http://m300239h20.zicp.vip/bookimg.png"))
                                    .resizable()
                                    .frame(width:110, height:170)
                                    .cornerRadius(5)
                                    .padding(.all,5)
                                //.background(Color.white)
                                VStack(alignment:.leading ,spacing:18) {
                                    HStack {
                                        Text("书名：")
                                        Text(self.book.count == 0 ? "" : "\(self.book[0].bookname)")

                                    }
                                    HStack {
                                        Text("作者：")
                                        Text(self.book.count == 0 ? "" : "\(self.book[0].bookauthor)")
                                    }
                                    HStack {
                                        Text("分类：")
                                        Text(self.book.count == 0 ? "" : "\(self.book[0].bookclass)")
                                    }

                                    HStack {
                                        Text("评分：")
                                        Text(self.book.count == 0 ? "" : "\(self.book[0].bookscore)")
                                    }
                                    HStack {
                                        Text("库存： ")
                                        Text(self.nownum)
                                    }
                                }
                            }
                            
                            VStack(alignment:.leading) {
                                Text("简介：")
                            Text(self.book.count == 0 ? "" : "\(self.book[0].booktext)")
                                .lineLimit(200)
                            }
                        }
                        Section(header: Text("借阅历史")) {
                            if self.userxingming.count > 0 {
                                ForEach(self.userxingming){ index in
                                    Text("\(index.userxingming) \(index.get_date)借阅 | \(index.real_back_date)归还")
                                }
                            }
                        }

                    }
                    
                    
                }
                
            
            }
            
            
        
        //.offset(y:-70)
    }
}

struct Teacher_Book_cha_Previews: PreviewProvider {
    static var previews: some View {
        Teacher_Book_cha(isbn: "",bookname: "", bookauthor: "", booktext: "", bookimg: "", bookscore: "", booknum: "")
    }
}
