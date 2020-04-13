//
//  Teacher_Book_zeng.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/8.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI

struct Teacher_Book_zeng: View {
    @State var bookname:String = ""
    @State var bookisbn:String = ""
    @State var bookauthor:String = ""
    @State var booktext:String = ""
    @State var bookimg:String = ""
    @State var bookscore:String = ""
    @State var booknum:String = ""
    @State var bookclass:String = ""
    @State var state:[isjieyue] = []
    @State var alertshow:Bool = false
    @State var warningshow: Bool = false
    @State var sele = 1
    var body: some View {
        ZStack {
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
                    Text("ISBN:  ")
                    SATextField(tag: 0, text:bookisbn,placeholder: "ISBN号,必填", changeHandler: { (newstr) in
                        self.bookisbn = newstr
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
            .blur(radius: self.warningshow ? 5 : 0)
            .animation(.default)
            VStack {
                Spacer()
                    //.frame(height:650)
                Button(action: {
                    //增加书籍api
                    if self.sele == 1{ self.bookclass = "古典文学" }
                    else if self.sele == 2{ self.bookclass = "战争文学" }
                    else if self.sele == 3{ self.bookclass = "人文科普" }
                    else if self.sele == 4{ self.bookclass = "社会经济" }
                    else if self.sele == 5{ self.bookclass = "外国文学" }
                    else if self.sele == 6{ self.bookclass = "武侠经典" }
                    else if self.sele == 7{ self.bookclass = "中国文学" }
                    //Api().phpTeacherBookzeng(
                    if self.bookname == "" || self.bookauthor == "" || self.bookisbn == "" || self.booktext == "" || self.bookimg == "" || self.bookscore == "" || self.bookclass == "" || self.booknum == "" {
                        self.warningshow.toggle()
                    }
                    else {
                        Api().phpTeacherBookzeng(completion: { (state) in
                            self.state = state
                            if self.state.count == 1 {
                                self.alertshow.toggle()
                            }
                        },bookname: self.bookname, bookauthor: self.bookauthor, bookisbn: self.bookisbn, booktext: self.booktext, bookimg: self.bookimg, bookscore: self.bookscore, bookclass: self.bookclass,booknum:self.booknum)
                    }
                    
                }) {
                    Text("提交")
                    .frame(width:230, height:45)
                        //.foregroundColor(Color.white)
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
                    Text("请完整填写完各项资料!")
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
        .offset(y:-10)
        

    }
}

struct Teacher_Book_zeng_Previews: PreviewProvider {
    static var previews: some View {
        Teacher_Book_zeng()
    }
}
