//
//  SearchBook.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/5.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Foundation
import CoreLocation

struct SearchBook: View {
    @Binding var userid: String
    @State var searchstr: String
    @State var searchresult:[booklist] = []
    @Binding var searchshow: Bool
    @Binding var menuvieshow: Bool
    var body: some View {
        
        NavigationView  {
            VStack{
                HStack {
                    SATextField(tag: 0, text:searchstr,placeholder: "图书名字、作者、ISBN", changeHandler: { (newstr) in
                        self.searchstr = newstr
                    })
                        
                        .frame(width: 280)
                    Spacer()
                    Button(action: {
                        Api().get_searchlist(completion: { (item) in
                            self.searchresult = item
                        }, str: self.searchstr)
                    }) {
                        Text("Search")
                            .foregroundColor(Color.white)
                    }
                    .frame(width:90, height:35)
                    .background(Color.blue)
                    .cornerRadius(30)
                }
                .padding(.horizontal)
                
                List(self.searchresult) { item in
                    NavigationLink(destination:Book(userid: self.$userid, bookimg: item.bookimg, booktitle: item.bookname, bookauthor: item.bookauthor, bookclass: item.bookclass, booktxt: item.booktext, bookfen: item.bookscore, bookisbn: item.bookisbn) ) {
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
                .gesture(
                    DragGesture().onChanged{    value in
                        if value.translation.width > 50{
                            
                            self.searchshow = false
                            self.menuvieshow = false
                            
                        }
                        
                    }
                )
            }
            .navigationBarTitle(Text("检索书籍"))
            
        //.navigationBarHidden(true)
            //.background(Color.blue)
        }
        //.edgesIgnoringSafeArea(.top)
    //.navigationBarTitle("")
            
    //.navigationBarHidden(true)
        //.background(Color.red)
    }
    
}

struct SearchBook_Previews: PreviewProvider {
    static var previews: some View {
        SearchBook(userid: .constant(""), searchstr: "", searchshow: .constant(false), menuvieshow: .constant(false))
    }
}



