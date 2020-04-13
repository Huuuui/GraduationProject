//
//  Teacher_Book_gai.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/8.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
struct Teacher_Book_gai: View {
    @State var isbn: String
    @State var bookname:String
    
    @State var bookauthor:String
    @State var booktext:String
    @State var bookimg:String
    @State var bookscore:String
    @State var booknum:String
    @State var book:[booklist] = []
    @State var state:[isjieyue] = []
    @State var alertshow: Bool = false
    @State var warningshow: Bool = false
    @State var warningisbnnull: Bool = false
    @State var warningtextbool: Bool = false
    @State var warningtextnull: Bool = false
    @State var sele = 1
    @State var newbookclass:String
    var body: some View {
        
        ZStack {
            VStack {
                    HStack {
                        Text("ISBN:")
                        TextField("ISBN", text: $isbn)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        Button(action: {
                            if self.isbn == "" {
                                self.warningisbnnull = true //弹出 isbn不可为空 的提示
                                self.warningtextnull = false
                                self.warningtextbool = false
                                self.warningshow = true
                            }
                            else {
                                //查询图书信息api
                                Api().phpTeacherBookCHAgai(bookisbn: self.isbn, completion: { (book) in
                                    if book[0].bookisbn != "-1" {
                                        self.book = book
                                    }
                                    else {//弹出 查无此书 的提示
                                        self.warningshow = true
                                        self.warningisbnnull = false
                                        self.warningtextnull = true
                                        self.warningtextbool = false
                                    }
                                })
                            }
                            
                        }) {
                            Text("查询")
                        }
                        
                        //.shadow(color:Color.red, radius: 10, x: 0, y: 15)
                    }
                    .padding(.horizontal)
                    HStack {
                        WebImage(url: URL(string:self.book.count == 1 ? self.book[0].bookimg : "http://m300239h20.zicp.vip/bookimg.png"))
                            .resizable()
                            .frame(width:110, height:170)
                            .cornerRadius(5)
                            .padding(.all,5)
                            //.background(Color.white)
                        VStack(alignment:.leading ,spacing:5) {
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
                                Text("总库存 | 被借阅： ")
                                Text("10 | 7")
                            }
                            HStack {
                                Text("简介：")
                                Text(self.book.count == 0 ? "" : "\(self.book[0].booktext)")
                                .lineLimit(2)
                                
                            }
                            
                        }
                    }
                    List {
                        HStack {
                            Text("书名：")
                            SATextField(tag: 0, text:bookname,placeholder: "图书名字", changeHandler: { (newstr) in
                                self.bookname = newstr
                            })
                        }
                        HStack {
                            Text("作者：")
                            SATextField(tag: 0, text:bookauthor,placeholder: "作者名字", changeHandler: { (newstr) in
                                self.bookauthor = newstr
                            })
                        }
                        
                        HStack {
                            Text("简介：")
                            SATextField(tag: 0, text:booktext,placeholder: "简介", changeHandler: { (newstr) in
                                self.booktext = newstr
                            })
                        }
                        HStack {
                            Text("封面：")
                            SATextField(tag: 0, text:bookimg,placeholder: "图片URL链接", changeHandler: { (newstr) in
                                self.bookimg = newstr
                            })
                        }
                        HStack {
                            Text("评分：")
                            SATextField(tag: 0, text:bookscore,placeholder: "书籍评分", changeHandler: { (newstr) in
                                self.bookscore = newstr
                            })
                        }
                        HStack {
                            Text("库存：")
                            SATextField(tag: 0, text:booknum,placeholder: "该书馆藏数", changeHandler: { (newstr) in
                                self.booknum = newstr
                            })
                        }
                        Picker(selection: self.$sele, label: Text("分类")) {
                            Text("古典文学").tag(1)
                            Text("战争文学").tag(2)
                            Text("人文科普").tag(3)
                            Text("社会经济").tag(4)
                            Text("外国文学").tag(5)
                            Text("武侠经典").tag(6)
                            Text("中国文学").tag(7)
                        }
                    }
                    Button(action: {
                        if self.book.count == 0 { //意味着没有书的信息 没有查询过 弹出 请先查询 提示
                            self.warningshow = true
                            self.warningisbnnull = false
                            self.warningtextbool = true
                            self.warningtextnull = false
                        }
                        if self.sele == 1{ self.newbookclass = "古典文学" }
                        else if self.sele == 2{ self.newbookclass = "战争文学" }
                        else if self.sele == 3{ self.newbookclass = "人文科普" }
                        else if self.sele == 4{ self.newbookclass = "社会经济" }
                        else if self.sele == 5{ self.newbookclass = "外国文学" }
                        else if self.sele == 6{ self.newbookclass = "武侠经典" }
                        else if self.sele == 7{ self.newbookclass = "中国文学" }
                        if self.book.count == 1 {
                            //调用修改api
                            Api().phpTeacherBookgai(
                                bookisbn:self.book[0].bookisbn,
                                bookname: self.bookname == "" ? self.book[0].bookname : self.bookname,
                                bookauthor: self.bookauthor == "" ? self.book[0].bookauthor : self.bookauthor,
                                booktext: self.booktext == "" ? self.book[0].booktext : self.booktext,
                                bookimg: self.bookimg == "" ? self.book[0].bookimg : self.bookimg,
                                bookscore: self.bookscore == "" ? self.book[0].bookscore : self.bookscore,
                                newbookclass: self.newbookclass,
                                oldbookclass: self.book[0].bookclass,completion: { (state) in
                                    self.state = state
                                    if self.state.count == 1 {
                                        self.alertshow.toggle()
                                    }
                                })
                        }
                        
                    }) {
                        Text("确认修改并提交")
                    }
                        .alert(isPresented: self.$alertshow) {
                            Alert(title: Text("操作结果"), message: Text(self.state[0].state))
                        }
                    .frame(width:230, height:45)
                    .background(Color.white)
                    .cornerRadius(13)
                    .shadow(color:Color.gray, radius: 10, x: 0, y: 15)
            }
            .blur(radius: self.warningshow ? 5 : 0)
            .animation(.default)
            //自制弹窗
            VStack(spacing:0) {
                Spacer()
                VStack {
                    Text("警告⚠️")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .offset(y:-10)
                    if self.warningisbnnull {
                        Text("ISBN不可为空！")
                        .font(.custom("FZKTJW.TTF", size: 13))
                    }
                    else if self.warningtextbool {
                        Text("请先查询后，再修改并提交!")
                        .font(.custom("FZKTJW.TTF", size: 13))
                    }
                    else if self.warningtextnull {
                        Text( "查无此书！请核实ISBN!")
                        .font(.custom("FZKTJW.TTF", size: 13))
                    }
                    
                }
                    .offset(y:5)
                Spacer()
                Divider()
                HStack(){
                    Button(action: {
                        self.warningisbnnull = false
                        self.warningtextnull = false
                        self.warningtextbool = false
                        self.warningshow = false
                        
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
    //.offset(y: -30)
        
    }
}

struct Teacher_Book_gai_Previews: PreviewProvider {
    static var previews: some View {
        Teacher_Book_gai(isbn: "",bookname: "", bookauthor: "", booktext: "", bookimg: "", bookscore: "", booknum: "", newbookclass: "")
    }
}
