//
//  Home.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/3/5.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Foundation
import CoreLocation

struct Home: View {
    @State var showMenuBtn = true
    @State var showProfile = false
    @State var qubook = false
    @State var qubook1 = false
    @State var qubook2 = false
    @State var qubook3 = false
    @State var qubook4 = false
    @State var qubook5 = false
    @State var qubook6 = false
    @State var scrollVlaue = CGSize.zero
    @State var showlogin : Bool = false
    @State var jieyueshow : Bool = false
    @State var searchshow : Bool = false
    
    
    @State var loginreturn : [loginreturn] = []
    @State var userid:String = ""
    
    
    @State var allbooklistshow: Bool = false
    @State var allbookshowwhich: String = ""
    @State var studenshow: Bool = false
    @State var teachershow: Bool = false
    
    
    var body: some View {
        
        
        ZStack {
            if self.loginreturn.count == 1 && self.studenshow {
                Color("background2")
                ScrollView {
                    VStack {
                        
                        ForEach(bclass) { item in
                            if item.classname == "古典文学" {Booklist_gdwx(classname: "古典文学", qubook: self.$qubook, userid:self.userid,allbookshow: self.$allbooklistshow, allbookshowwhich: self.$allbookshowwhich)}
                            if item.classname == "战争文学" {Booklist_js(classname: "战争文学", qubook: self.$qubook1, userid:self.userid,allbookshow: self.$allbooklistshow, allbookshowwhich: self.$allbookshowwhich)}
                            if item.classname == "人文科普" {Booklist_rwkp(classname: "人文科普", qubook: self.$qubook2, userid:self.userid,allbookshow: self.$allbooklistshow, allbookshowwhich: self.$allbookshowwhich)}
                            if item.classname == "社会经济" {Booklist_shjj(classname: "社会经济", qubook: self.$qubook3, userid:self.userid,allbookshow: self.$allbooklistshow, allbookshowwhich: self.$allbookshowwhich)}
                            if item.classname == "外国文学" {Booklist_wgwx(classname: "外国文学", qubook: self.$qubook4, userid:self.userid,allbookshow: self.$allbooklistshow, allbookshowwhich: self.$allbookshowwhich)}
                            if item.classname == "武侠经典" {Booklist_wx(classname: "武侠经典", qubook: self.$qubook5, userid:self.userid,allbookshow: self.$allbooklistshow, allbookshowwhich: self.$allbookshowwhich)}
                            if item.classname == "中国文学" {Booklist_zgwx(classname: "中国文学", qubook: self.$qubook6, userid:self.userid, allbookshow: self.$allbooklistshow, allbookshowwhich: self.$allbookshowwhich)}
                        }
                    }
                    .frame(width:screen.width)
                }
                .blur(radius: self.showProfile ? 20 : 0)
                .animation(.default)
                
                MenuButton(test: $showProfile)
                    .offset(x: showMenuBtn ?  70 : 0)
                    .offset(x: showProfile ?  70 : 0)
                    .animation(.default)
                
                MenuView(showlogin: self.$showlogin, studentshow: $studenshow,jieyueshow: self.$jieyueshow,menuviewshow:self.$showProfile, searchshow: self.$searchshow, xingming: self.$loginreturn[0].userxingming, touxiang: self.$loginreturn[0].usertouxiang)
                    .onTapGesture { self.showProfile.toggle() }
                    .offset(y: self.showProfile ? 0 : 500)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                if self.jieyueshow {
                    MyJieyue(userid: self.$userid,jieyueshow: self.$jieyueshow ,menuvieshow: self.$showProfile)
                    .offset(y: self.jieyueshow ? 0 : 700)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                }
                
                SearchBook(userid: self.$userid, searchstr: "", searchshow: self.$searchshow, menuvieshow: self.$showProfile)
                    .offset(y: self.searchshow ? 0 : 700)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                Allbooklist(userid:self.$userid, showwhich: self.$allbookshowwhich, showallbooklist: self.$allbooklistshow)
                    .offset(x:self.allbooklistshow ? 0 : 700)
                    .animation(.spring(response: 0.8, dampingFraction: 1, blendDuration: 0))
            }
            if self.loginreturn.count == 1 && self.teachershow {
                TeacherManagement( xingming:self.$loginreturn[0].userxingming,touxiang: self.$loginreturn[0].usertouxiang, showlogin: self.$showlogin,teachershow:self.$teachershow )
                    .offset(x: self.showlogin ? 0 : 700)
                    .animation(.default)
            }
            Login(loginreturn: $loginreturn, showLogin: $showlogin, teachershow: $teachershow, studentshow: $studenshow, userid:$userid)
                
                .offset(x: self.showlogin ? 700 : 0)
                .animation(.spring(response: 0.8, dampingFraction: 1, blendDuration: 0))
        }
            //.offset(x: self.showlogin ? 0 : -600)
            //.animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            .gesture(
                DragGesture().onChanged{    value in
                    if value.translation.height > 10{
                        
                        self.showMenuBtn = false
                    }
                    if value.translation.height < -10 {
                        self.showMenuBtn = true
                    }
                    
                }
        )
        
    }
    
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct MenuButton: View {
    @Binding var test : Bool
    var body: some View {
        return HStack{
            Spacer()
            VStack {
                Spacer()
                Button(action: {self.test.toggle()}){
                    HStack {
                        Image(systemName : "list.dash")
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                    .padding(.leading,30)
                    .padding(.trailing,20)
                    .frame(width:90, height:65)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color:Color.gray, radius: 10, x: 0, y: 15)
                    
                }
            }
            .padding(.bottom,190)
        }
        .padding(.trailing,-30)
    }
}




struct booksclass:Identifiable {
    var id = UUID()
    var classname:String
}
let bclass = [
    booksclass(classname:"古典文学"),
    booksclass(classname:"战争文学"),
    booksclass(classname:"人文科普"),
    booksclass(classname:"社会经济"),
    booksclass(classname:"外国文学"),
    booksclass(classname:"武侠经典"),
    booksclass(classname:"中国文学"),
]



struct Booklist_gdwx: View {
    var classname: String
    @Binding var qubook: Bool
    @State var userid:String = ""
    @Binding var allbookshow: Bool
    @Binding var allbookshowwhich: String
    
    @State var bookindex = 0
    var body: some View {
        return
            VStack {
                HStack {
                    Text(classname)
                        .font(.system(size:13))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .shadow(color: Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)).opacity(0.4), radius: 20, x: 0, y: 10)
                    Spacer()
                    Button(action: {
                        self.allbookshow.toggle()
                        self.allbookshowwhich = "gdwx"
                        
                    }) {
                        Image(systemName:"ellipsis.circle")
                            .resizable()
                            .frame(width:20 , height: 20)
                            .foregroundColor(Color.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    }
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(1), radius: 30, x: 0, y: 30)
                    //booklist()
                }
                .padding(.horizontal,10)
                .padding(.top,5)
                .offset(y:5)
                
                Divider()
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(0..<bookdata_gdwx.count,id:\.self) { book in
                            GeometryReader {    geometry in
                                HStack {
                                    VStack {
                                        WebImage(url:URL(string: bookdata_gdwx[book].bookimg))
                                            .resizable()
                                            //.aspectRatio(contentMode: .fit) .fit长宽等比例缩放 fill填满
                                            .frame(width: 90, height: 130, alignment: .top)
                                            .cornerRadius(10)
                                        //.shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 20)
                                        
                                        Text(bookdata_gdwx[book].bookname)
                                            .foregroundColor(Color.black)
                                            .font(.system(size:12))
                                            //.fontWeight(.bold)
                                            .lineLimit(3)
                                            .frame(width:110,height:40)
                                        
                                    }
                                    .onTapGesture {
                                        self.bookindex = book
                                        self.qubook.toggle()
                                    }
                                        
                                    .sheet(isPresented: self.$qubook) {
                                        Book(userid:self.$userid,bookimg: bookdata_gdwx[self.bookindex].bookimg, booktitle:bookdata_gdwx[self.bookindex].bookname,
                                        bookauthor: bookdata_gdwx[self.bookindex].bookauthor,
                                        bookclass: bookdata_gdwx[self.bookindex].bookclass,
                                        booktxt: bookdata_gdwx[self.bookindex].booktext,
                                        bookfen: bookdata_gdwx[self.bookindex].bookscore,
                                        bookisbn:bookdata_gdwx[self.bookindex].bookisbn)
                                    }
                                    .padding(.leading,14)
                                }
                                .rotation3DEffect(Angle(degrees:
                                    Double(geometry.frame(in : .global).minX - 70) / -20
                                ), axis: (x: 0, y: 30, z: 0))
                            }
                            .frame(width:110 , height: 190)
                            .padding(.leading, 5)
                            //.background(Color.blue)
                        }
                    }
                }
            }
            .background(BlurView(style: .prominent))
            .background(Color.white)
            .cornerRadius(15)
    }
}

struct Booklist_js: View {
    var classname: String
    @Binding var qubook: Bool
    @State var userid:String = ""
    @State var bookindex = 0
    
    @Binding var allbookshow: Bool
    @Binding var allbookshowwhich: String
    
    var body: some View {
        return
            VStack {
                HStack {
                    Text(classname)
                        .font(.system(size:13))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .shadow(color: Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)).opacity(0.4), radius: 20, x: 0, y: 10)
                    Spacer()
                    Button(action: {
                        self.allbookshow.toggle()
                        self.allbookshowwhich = "js"
                    }) {
                        Image(systemName:"ellipsis.circle")
                            .resizable()
                            .frame(width:20 , height: 20)
                            .foregroundColor(Color.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    }
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(1), radius: 30, x: 0, y: 30)
                    //booklist()
                }
                .padding(.horizontal,10)
                .padding(.top,5)
                .offset(y:5)
                
                Divider()
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(0..<bookdata_js.count,id:\.self) { book in
                            GeometryReader {    geometry in
                                HStack {
                                    VStack {
                                        WebImage(url:URL(string: bookdata_js[book].bookimg))
                                            .resizable()
                                            //.aspectRatio(contentMode: .fit) .fit长宽等比例缩放 fill填满
                                            .frame(width: 90, height: 130, alignment: .top)
                                            .cornerRadius(10)
                                        //.shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 20)
                                        
                                        Text(bookdata_js[book].bookname)
                                            .foregroundColor(Color.black)
                                            .font(.system(size:12))
                                            //.fontWeight(.bold)
                                            .lineLimit(3)
                                            .frame(width:110,height:40)
                                        
                                    }
                                    .onTapGesture {
                                        self.bookindex = book
                                        self.qubook.toggle()
                                    }
                                        
                                    .sheet(isPresented: self.$qubook) {
                                        Book(userid:self.$userid,bookimg: bookdata_js[self.bookindex].bookimg, booktitle:bookdata_js[self.bookindex].bookname,
                                        bookauthor: bookdata_js[self.bookindex].bookauthor,
                                        bookclass: bookdata_js[self.bookindex].bookclass,
                                        booktxt: bookdata_js[self.bookindex].booktext,
                                        bookfen: bookdata_js[self.bookindex].bookscore,
                                        bookisbn:bookdata_js[self.bookindex].bookisbn)
                                    }
                                    .padding(.leading,14)
                                }
                                .rotation3DEffect(Angle(degrees:
                                    Double(geometry.frame(in : .global).minX - 70) / -20
                                ), axis: (x: 0, y: 30, z: 0))
                            }
                            .frame(width:110 , height: 190)
                            .padding(.leading, 5)
                            //.background(Color.blue)
                        }
                    }
                }
            }
            .background(BlurView(style: .prominent))
            .background(Color.white)
            .cornerRadius(15)
    }
}

struct Booklist_rwkp: View {
    var classname: String
    @Binding var qubook: Bool
    @State var userid:String = ""
    @State var bookindex = 0
    @Binding var allbookshow: Bool
    @Binding var allbookshowwhich: String
    var body: some View {
        return
            VStack {
                HStack {
                    Text(classname)
                        .font(.system(size:13))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .shadow(color: Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)).opacity(0.4), radius: 20, x: 0, y: 10)
                    Spacer()
                    Button(action: {
                        self.allbookshow.toggle()
                        self.allbookshowwhich = "rwkp"
                        
                    }) {
                        Image(systemName:"ellipsis.circle")
                            .resizable()
                            .frame(width:20 , height: 20)
                            .foregroundColor(Color.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    }
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(1), radius: 30, x: 0, y: 30)
                    //booklist()
                }
                .padding(.horizontal,10)
                .padding(.top,5)
                .offset(y:5)
                
                Divider()
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(0..<bookdata_rwkp.count,id:\.self) { book in
                            GeometryReader {    geometry in
                                HStack {
                                    VStack {
                                        WebImage(url:URL(string: bookdata_rwkp[book].bookimg))
                                            .resizable()
                                            //.aspectRatio(contentMode: .fit) .fit长宽等比例缩放 fill填满
                                            .frame(width: 90, height: 130, alignment: .top)
                                            .cornerRadius(10)
                                        //.shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 20)
                                        
                                        Text(bookdata_rwkp[book].bookname)
                                            .foregroundColor(Color.black)
                                            .font(.system(size:12))
                                            //.fontWeight(.bold)
                                            .lineLimit(3)
                                            .frame(width:110,height:40)
                                        
                                    }
                                    .onTapGesture {
                                        self.bookindex = book
                                        self.qubook.toggle()
                                    }
                                        
                                    .sheet(isPresented: self.$qubook) {
                                        Book(userid:self.$userid,bookimg: bookdata_rwkp[self.bookindex].bookimg, booktitle:bookdata_rwkp[self.bookindex].bookname,
                                             bookauthor: bookdata_rwkp[self.bookindex].bookauthor,
                                             bookclass: bookdata_rwkp[self.bookindex].bookclass,
                                             booktxt: bookdata_rwkp[self.bookindex].booktext,
                                             bookfen: bookdata_rwkp[self.bookindex].bookscore,
                                             bookisbn:bookdata_rwkp[self.bookindex].bookisbn)
                                    }
                                    .padding(.leading,14)
                                }
                                .rotation3DEffect(Angle(degrees:
                                    Double(geometry.frame(in : .global).minX - 70) / -20
                                ), axis: (x: 0, y: 30, z: 0))
                            }
                            .frame(width:110 , height: 190)
                            .padding(.leading, 5)
                            //.background(Color.blue)
                        }
                    }
                }
            }
            .background(BlurView(style: .prominent))
            .background(Color.white)
            .cornerRadius(15)
    }
}

struct Booklist_shjj: View {
    var classname: String
    @Binding var qubook: Bool
    @State var userid:String = ""
    @State var bookindex = 0
    @Binding var allbookshow: Bool
    @Binding var allbookshowwhich: String
    var body: some View {
        return
            VStack {
                HStack {
                    Text(classname)
                        .font(.system(size:13))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .shadow(color: Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)).opacity(0.4), radius: 20, x: 0, y: 10)
                    Spacer()
                    Button(action: {
                        self.allbookshow.toggle()
                        self.allbookshowwhich = "shjj"
                        
                    }) {
                        Image(systemName:"ellipsis.circle")
                            .resizable()
                            .frame(width:20 , height: 20)
                            .foregroundColor(Color.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    }
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(1), radius: 30, x: 0, y: 30)
                    //booklist()
                }
                .padding(.horizontal,10)
                .padding(.top,5)
                .offset(y:5)
                
                Divider()
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(0..<bookdata_shjj.count,id:\.self) { book in
                            GeometryReader {    geometry in
                                HStack {
                                    VStack {
                                        WebImage(url:URL(string: bookdata_shjj[book].bookimg))
                                            .resizable()
                                            //.aspectRatio(contentMode: .fit) .fit长宽等比例缩放 fill填满
                                            .frame(width: 90, height: 130, alignment: .top)
                                            .cornerRadius(10)
                                        //.shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 20)
                                        
                                        Text(bookdata_shjj[book].bookname)
                                            .foregroundColor(Color.black)
                                            .font(.system(size:12))
                                            //.fontWeight(.bold)
                                            .lineLimit(3)
                                            .frame(width:110,height:40)
                                        
                                    }
                                    .onTapGesture {
                                        self.bookindex = book
                                        self.qubook.toggle()
                                    }
                                        
                                    .sheet(isPresented: self.$qubook) {
                                        Book(userid:self.$userid,bookimg: bookdata_shjj[self.bookindex].bookimg, booktitle:bookdata_shjj[self.bookindex].bookname,
                                        bookauthor: bookdata_shjj[self.bookindex].bookauthor,
                                        bookclass: bookdata_shjj[self.bookindex].bookclass,
                                        booktxt: bookdata_shjj[self.bookindex].booktext,
                                        bookfen: bookdata_shjj[self.bookindex].bookscore,
                                        bookisbn:bookdata_shjj[self.bookindex].bookisbn)
                                    }
                                        
                                    .padding(.leading,14)
                                }
                                .rotation3DEffect(Angle(degrees:
                                    Double(geometry.frame(in : .global).minX - 70) / -20
                                ), axis: (x: 0, y: 30, z: 0))
                            }
                            .frame(width:110 , height: 190)
                            .padding(.leading, 5)
                            //.background(Color.blue)
                        }
                    }
                }
                
            }
                
            .background(BlurView(style: .prominent))
            .background(Color.white)
            .cornerRadius(15)
    }
}

struct Booklist_wgwx: View {
    var classname: String
    @Binding var qubook: Bool
    @State var userid:String = ""
    @State var bookindex = 0
    @Binding var allbookshow: Bool
    @Binding var allbookshowwhich: String
    var body: some View {
        return
            VStack {
                HStack {
                    Text(classname)
                        .font(.system(size:13))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .shadow(color: Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)).opacity(0.4), radius: 20, x: 0, y: 10)
                    Spacer()
                    Button(action: {
                        self.allbookshow.toggle()
                        self.allbookshowwhich = "wgwx"
                        
                    }) {
                        Image(systemName:"ellipsis.circle")
                            .resizable()
                            .frame(width:20 , height: 20)
                            .foregroundColor(Color.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    }
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(1), radius: 30, x: 0, y: 30)
                    //booklist()
                }
                .padding(.horizontal,10)
                .padding(.top,5)
                .offset(y:5)
                
                Divider()
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(0..<bookdata_wgwx.count,id:\.self) { book in
                            GeometryReader {    geometry in
                                HStack {
                                    VStack {
                                        WebImage(url:URL(string: bookdata_wgwx[book].bookimg))
                                            .resizable()
                                            //.aspectRatio(contentMode: .fit) .fit长宽等比例缩放 fill填满
                                            .frame(width: 90, height: 130, alignment: .top)
                                            .cornerRadius(10)
                                        //.shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 20)
                                        
                                        Text(bookdata_wgwx[book].bookname)
                                            .foregroundColor(Color.black)
                                            .font(.system(size:12))
                                            //.fontWeight(.bold)
                                            .lineLimit(3)
                                            .frame(width:110,height:40)
                                        
                                    }
                                    .onTapGesture {
                                        self.bookindex = book
                                        self.qubook.toggle()
                                    }
                                        
                                    .sheet(isPresented: self.$qubook) {
                                        Book(userid:self.$userid,bookimg: bookdata_wgwx[self.bookindex].bookimg, booktitle:bookdata_wgwx[self.bookindex].bookname,
                                        bookauthor: bookdata_wgwx[self.bookindex].bookauthor,
                                        bookclass: bookdata_wgwx[self.bookindex].bookclass,
                                        booktxt: bookdata_wgwx[self.bookindex].booktext,
                                        bookfen: bookdata_wgwx[self.bookindex].bookscore,
                                        bookisbn:bookdata_wgwx[self.bookindex].bookisbn)
                                    }
                                    .padding(.leading,14)
                                }
                                .rotation3DEffect(Angle(degrees:
                                    Double(geometry.frame(in : .global).minX - 70) / -20
                                ), axis: (x: 0, y: 30, z: 0))
                            }
                            .frame(width:110 , height: 190)
                            .padding(.leading, 5)
                            //.background(Color.blue)
                        }
                    }
                }
            }
                
            .background(BlurView(style: .prominent))
            .background(Color.white)
            .cornerRadius(15)
    }
}

struct Booklist_wx: View {
    var classname: String
    @Binding var qubook: Bool
    @State var userid:String = ""
    @State var bookindex = 0
    @Binding var allbookshow: Bool
    @Binding var allbookshowwhich: String
    var body: some View {
        return
            VStack {
                HStack {
                    Text(classname)
                        .font(.system(size:13))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .shadow(color: Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)).opacity(0.4), radius: 20, x: 0, y: 10)
                    Spacer()
                    Button(action: {
                        self.allbookshow.toggle()
                        self.allbookshowwhich = "wx"
                        
                    }) {
                        Image(systemName:"ellipsis.circle")
                            .resizable()
                            .frame(width:20 , height: 20)
                            .foregroundColor(Color.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    }
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(1), radius: 30, x: 0, y: 30)
                    //booklist()
                }
                .padding(.horizontal,10)
                .padding(.top,5)
                .offset(y:5)
                
                Divider()
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(0..<bookdata_wx.count,id:\.self) { book in
                            GeometryReader {    geometry in
                                HStack {
                                    VStack {
                                        WebImage(url:URL(string: bookdata_wx[book].bookimg))
                                            .resizable()
                                            //.aspectRatio(contentMode: .fit) .fit长宽等比例缩放 fill填满
                                            .frame(width: 90, height: 130, alignment: .top)
                                            .cornerRadius(10)
                                        //.shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 20)
                                        Text(bookdata_wx[book].bookname)
                                            .foregroundColor(Color.black)
                                            .font(.system(size:12))
                                            //.fontWeight(.bold)
                                            .lineLimit(3)
                                            .frame(width:110,height:40)
                                    }
                                    .onTapGesture {
                                        self.bookindex = book
                                        self.qubook.toggle()
                                    }
                                    .sheet(isPresented: self.$qubook) {
                                        Book(userid:self.$userid,bookimg: bookdata_wx[self.bookindex].bookimg, booktitle:bookdata_wx[self.bookindex].bookname,
                                        bookauthor: bookdata_wx[self.bookindex].bookauthor,
                                        bookclass: bookdata_wx[self.bookindex].bookclass,
                                        booktxt: bookdata_wx[self.bookindex].booktext,
                                        bookfen: bookdata_wx[self.bookindex].bookscore,
                                        bookisbn:bookdata_wx[self.bookindex].bookisbn)
                                    }
                                    .padding(.leading,14)
                                }
                                .rotation3DEffect(Angle(degrees:
                                    Double(geometry.frame(in : .global).minX - 70) / -20
                                ), axis: (x: 0, y: 30, z: 0))
                            }
                            .frame(width:110 , height: 190)
                            .padding(.leading, 5)
                            //.background(Color.blue)
                        }
                    }
                }
            }
                
            .background(BlurView(style: .prominent))
            .background(Color.white)
            .cornerRadius(15)
    }
}

struct Booklist_zgwx: View {
    var classname: String
    @Binding var qubook: Bool
    @State var userid:String = ""
    @Binding var allbookshow: Bool
    @Binding var allbookshowwhich: String
    @State var bookindex = 0
    var body: some View {
        return
            VStack {
                
                HStack {
                    Text(classname)
                        .font(.system(size:13))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .shadow(color: Color(#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)).opacity(0.4), radius: 20, x: 0, y: 10)
                    Spacer()
                    Button(action: {
                        self.allbookshow.toggle()
                        self.allbookshowwhich = "zgwx"
                        
                    }) {
                        Image(systemName:"ellipsis.circle")
                            .resizable()
                            .frame(width:20 , height: 20)
                            .foregroundColor(Color.init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    }
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).opacity(1), radius: 30, x: 0, y: 30)
                    //booklist()
                }
                .padding(.horizontal,10)
                .padding(.top,5)
                .offset(y:5)
                
                Divider()
                
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack{
                        ForEach(0..<bookdata_zgwx.count,id:\.self) { book in
                            GeometryReader {    geometry in
                                HStack {
                                    VStack {
                                        WebImage(url:URL(string: bookdata_zgwx[book].bookimg))
                                            .resizable()
                                            //.aspectRatio(contentMode: .fit) .fit长宽等比例缩放 fill填满
                                            .frame(width: 90, height: 130, alignment: .top)
                                            .cornerRadius(10)
                                        //.shadow(color: Color.red.opacity(0.3), radius: 20, x: 0, y: 20)
                                        Text(bookdata_zgwx[book].bookname)
                                            .foregroundColor(Color.black)
                                            .font(.system(size:12))
                                            //.fontWeight(.bold)
                                            .lineLimit(3)
                                            .frame(width:110,height:40)
                                    }
                                    .onTapGesture {
                                        self.bookindex = book
                                        self.qubook.toggle()
                                    }
                                        
                                    .sheet(isPresented: self.$qubook) {
                                        Book(userid:self.$userid,bookimg: bookdata_zgwx[self.bookindex].bookimg, booktitle:bookdata_zgwx[self.bookindex].bookname,
                                        bookauthor: bookdata_zgwx[self.bookindex].bookauthor,
                                        bookclass: bookdata_zgwx[self.bookindex].bookclass,
                                        booktxt: bookdata_zgwx[self.bookindex].booktext,
                                        bookfen: bookdata_zgwx[self.bookindex].bookscore,
                                        bookisbn:bookdata_zgwx[self.bookindex].bookisbn)
                                    }
                                    .padding(.leading,14)
                                    
                                }
                                .rotation3DEffect(Angle(degrees:
                                    Double(geometry.frame(in : .global).minX - 70) / -20
                                ), axis: (x: 0, y: 30, z: 0))
                            }
                            .frame(width:110 , height: 190)
                            .padding(.leading, 5)
                            //.background(Color.blue)
                        }
                    }
                }
                
            }
                
            .background(BlurView(style: .prominent))
            .background(Color.white)
            .cornerRadius(15)
    }
}
