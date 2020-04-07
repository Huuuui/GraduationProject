//
//  MyJieyue.swift
//  demotest
//
//  Created by gzy on 2020/4/3.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyJieyue: View {
    @Binding var userid: String
    @Binding var jieyueshow: Bool
    @Binding var menuvieshow: Bool
    @State var state0:[jieyuelist] = []
    @State var state1:[jieyuelist] = []
    @State var state2:[jieyuelist] = []
    var body: some View {
            //Color.white
        VStack() {
                    HStack {
                        VStack{
                            Spacer()
                                .frame(height:40)
                            Text("君不见高堂明镜悲白发朝如青丝暮成雪")
                            .font(.system(size:15))
                            .foregroundColor(Color.gray)
                        }
                        Spacer()
                        Button(action: {
                            self.jieyueshow.toggle()
                            self.menuvieshow.toggle()
                        }) {
                            VStack{
                                Image(systemName:"arrowshape.turn.up.right")
                                .resizable()
                                .frame(width: 25, height: 20)
                                Text("返回")
                                .font(.subheadline)
                            }
                            .offset(y:10)
                            
                        }
                        
                    }
                    .padding(.horizontal,30)
                    Divider()
            List() {
                        Group{
                            Section(header: Text("借阅中")) {
                                ForEach(self.state1) { list in
                                    HStack {
                                        WebImage(url:URL(string: list.bookimg))
                                        .resizable()
                                        .frame(width:60, height:90)
                                        .cornerRadius(5)
                                        .padding(.all,5)
                                            .background(Color.white)
                                        Spacer()
                                            .frame(width:30)
                                        VStack(alignment:.leading) {
                                            Text(list.bookname)
                                            .font(.system(size:23))
                                                .fontWeight(.bold)
                                            Spacer()
                                            Text(list.bookauthor)
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)
                                            Text("ISBN:\(list.bookisbn)")
                                                .font(.subheadline)
                                                .foregroundColor(Color.gray)
                                            Text("\(list.get_date)借阅 | 限\(list.back_date)归还")
                                            .font(.subheadline)
                                            .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
                                        }
                                    }
                                    
                                }
                            }
                            Section(header: Text("超期未归还")) {
                                ForEach(self.state2) { list in
                                    HStack {
                                        WebImage(url:URL(string: list.bookimg))
                                        .resizable()
                                        .frame(width:60, height:90)
                                        .cornerRadius(5)
                                        .padding(.all,5)
                                            .background(Color.white)
                                        Spacer()
                                            .frame(width:30)
                                        VStack(alignment:.leading) {
                                            Text(list.bookname)
                                            .font(.system(size:23))
                                                .fontWeight(.bold)
                                                .foregroundColor(Color.red)
                                            Spacer()
                                            Text(list.bookauthor)
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)
                                            Text("ISBN:\(list.bookisbn)")
                                                .font(.subheadline)
                                                .foregroundColor(Color.gray)
                                            Text("你已超期，请立刻归还书籍")
                                            .font(.subheadline)
                                            .foregroundColor(Color.red)
                                        }
                                    }
                                    
                                }
                            }
                            Section(header: Text("借阅历史")) {
                                ForEach(self.state0) { list in
                                    HStack {
                                        WebImage(url:URL(string: list.bookimg))
                                        .resizable()
                                        .frame(width:60, height:90)
                                        .cornerRadius(5)
                                        .padding(.all,5)
                                            .background(Color.white)
                                        Spacer()
                                            .frame(width:30)
                                        VStack(alignment:.leading) {
                                            Text(list.bookname)
                                            .font(.system(size:23))
                                                .fontWeight(.bold)
                                            .foregroundColor(Color.gray)
                                            Spacer()
                                            Text(list.bookauthor)
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)
                                            Text("ISBN:\(list.bookisbn)")
                                                .font(.subheadline)
                                                .foregroundColor(Color.gray)
                                            Text("\(list.get_date)借阅 | \(list.back_date)归还")
                                            .font(.subheadline)
                                            .foregroundColor(Color.gray)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
        .lineSpacing(0)
                }
                .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            Api().get_jieyuelist(completion: { (list) in
                self.state0 = list
            }, userid: self.userid, state: "0")
            
            Api().get_jieyuelist(completion: { (list) in
                self.state1 = list
            }, userid: self.userid, state: "1")

            Api().get_jieyuelist(completion: { (list) in
                self.state2 = list
            }, userid: self.userid, state: "2")

        }
    }
}

struct MyJieyue_Previews: PreviewProvider {
    static var previews: some View {
        MyJieyue(userid: .constant(""), jieyueshow: .constant(false) ,menuvieshow: .constant(false))
    }
}
