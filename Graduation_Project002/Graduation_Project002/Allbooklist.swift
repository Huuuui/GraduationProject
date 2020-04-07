//
//  Allbooklist.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/4.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Foundation
import CoreLocation

struct Allbooklist: View {
    
    @Binding var userid:String
    
    @Binding var showwhich : String
    @Binding var showallbooklist : Bool
    var body: some View {
        ZStack{
            Color.white
                .edgesIgnoringSafeArea(.all)
            if(self.showwhich == "gdwx"){ gdwx(userid:self.$userid,show: self.$showallbooklist)}
            if(self.showwhich == "js"){ js(userid:self.$userid,show: self.$showallbooklist)}
            if(self.showwhich == "rwkp"){ rwkp(userid:self.$userid,show: self.$showallbooklist)}
            if(self.showwhich == "shjj"){ shjj(userid:self.$userid,show: self.$showallbooklist)}
            if(self.showwhich == "wgwx"){ wgwx(userid:self.$userid,show: self.$showallbooklist)}
            if(self.showwhich == "wx"){ wx(userid:self.$userid,show: self.$showallbooklist)}
            if(self.showwhich == "zgwx"){ zgwx(userid:self.$userid,show: self.$showallbooklist)}
        }
    }
}

struct Allbooklist_Previews: PreviewProvider {
    static var previews: some View {
        Allbooklist(userid: .constant(""), showwhich: .constant(""), showallbooklist: .constant(false))
    }
}
struct gdwx: View {
    
    @Binding var userid:String
    @Binding var show: Bool
    var body: some View {
    return
        VStack {
            NavigationView {
                List(0..<alldata_gdwx.count){ item in
                    NavigationLink(destination: Book( userid: self.$userid, bookimg: alldata_gdwx[item].bookimg, booktitle: alldata_gdwx[item].bookname, bookauthor: alldata_gdwx[item].bookauthor, bookclass: alldata_gdwx[item].bookclass, booktxt: alldata_gdwx[item].booktext, bookfen: alldata_gdwx[item].bookscore, bookisbn: alldata_zgwx[item].bookisbn)) {
                        HStack {
                            WebImage(url:URL(string: alldata_gdwx[item].bookimg))
                                .resizable()
                                .frame(width: 90, height: 130, alignment: .top)
                                .cornerRadius(10)
                            VStack(alignment:.leading){
                                Text(alldata_gdwx[item].bookname)
                                    .font(.title)
                                    .font(.system(size:20))
                                Text(alldata_gdwx[item].bookauthor)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text(alldata_gdwx[item].booktext)
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
                            
                            self.show = false
                            
                        }
                        
                    }
                )
                .navigationBarTitle(Text("古典文学"))
            }
            
        }
        
    }
}

struct js: View {
    @Binding var userid:String
    @Binding var show: Bool
    var body: some View {
    return
        VStack {
            NavigationView {
                List(0..<alldata_js.count){ item in
                    NavigationLink(destination: Book( userid: self.$userid,bookimg: alldata_js[item].bookimg, booktitle: alldata_js[item].bookname, bookauthor: alldata_js[item].bookauthor, bookclass: alldata_js[item].bookclass, booktxt: alldata_js[item].booktext, bookfen: alldata_js[item].bookscore, bookisbn: alldata_zgwx[item].bookisbn)) {
                        HStack {
                            WebImage(url:URL(string: alldata_js[item].bookimg))
                                .resizable()
                                .frame(width: 90, height: 130, alignment: .top)
                                .cornerRadius(10)
                            VStack(alignment:.leading){
                                Text(alldata_js[item].bookname)
                                    .font(.title)
                                    .font(.system(size:20))
                                Text(alldata_js[item].bookauthor)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text(alldata_js[item].booktext)
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
                            
                            self.show = false
                            
                        }
                        
                    }
                )
                .navigationBarTitle(Text("战争文学"))
            }
            
        }
        
    }
}

struct rwkp: View {
    @Binding var userid:String
    @Binding var show: Bool
    var body: some View {
    return
        VStack {
            NavigationView {
                List(0..<alldata_rwkp.count){ item in
                    NavigationLink(destination: Book( userid: self.$userid,bookimg: alldata_rwkp[item].bookimg, booktitle: alldata_rwkp[item].bookname, bookauthor: alldata_rwkp[item].bookauthor, bookclass: alldata_rwkp[item].bookclass, booktxt: alldata_rwkp[item].booktext, bookfen: alldata_rwkp[item].bookscore, bookisbn: alldata_zgwx[item].bookisbn)
) {
                        HStack {
                            WebImage(url:URL(string: alldata_rwkp[item].bookimg))
                                .resizable()
                                .frame(width: 90, height: 130, alignment: .top)
                                .cornerRadius(10)
                            VStack(alignment:.leading){
                                Text(alldata_rwkp[item].bookname)
                                    .font(.title)
                                    .font(.system(size:20))
                                Text(alldata_rwkp[item].bookauthor)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text(alldata_rwkp[item].booktext)
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
                            
                            self.show = false
                            
                        }
                        
                    }
                )
                .navigationBarTitle(Text("人文科普"))
            }
            
        }
        
    }
}

struct shjj: View {
    @Binding var userid:String
    @Binding var show: Bool
    var body: some View {
    return
        VStack {
            NavigationView {
                List(0..<alldata_shjj.count){ item in
                    NavigationLink(destination: Book( userid: self.$userid,bookimg: alldata_shjj[item].bookimg, booktitle: alldata_shjj[item].bookname, bookauthor: alldata_shjj[item].bookauthor, bookclass: alldata_shjj[item].bookclass, booktxt: alldata_shjj[item].booktext, bookfen: alldata_shjj[item].bookscore, bookisbn: alldata_zgwx[item].bookisbn)) {
                        HStack {
                            WebImage(url:URL(string: alldata_shjj[item].bookimg))
                                .resizable()
                                .frame(width: 90, height: 130, alignment: .top)
                                .cornerRadius(10)
                            VStack(alignment:.leading){
                                Text(alldata_shjj[item].bookname)
                                    .font(.title)
                                    .font(.system(size:20))
                                Text(alldata_shjj[item].bookauthor)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text(alldata_shjj[item].booktext)
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
                            
                            self.show = false
                            
                        }
                        
                    }
                )
                .navigationBarTitle(Text("社会经济"))
            }
            
        }
        
    }
}

struct wgwx: View {
    @Binding var userid:String
    @Binding var show: Bool
    var body: some View {
    return
        VStack {
            NavigationView {
                List(0..<alldata_wgwx.count){ item in
                    NavigationLink(destination: Book( userid: self.$userid,bookimg: alldata_wgwx[item].bookimg, booktitle: alldata_wgwx[item].bookname, bookauthor: alldata_wgwx[item].bookauthor, bookclass: alldata_wgwx[item].bookclass, booktxt: alldata_wgwx[item].booktext, bookfen: alldata_wgwx[item].bookscore, bookisbn: alldata_zgwx[item].bookisbn)) {
                        HStack {
                            WebImage(url:URL(string: alldata_wgwx[item].bookimg))
                                .resizable()
                                .frame(width: 90, height: 130, alignment: .top)
                                .cornerRadius(10)
                            VStack(alignment:.leading){
                                Text(alldata_wgwx[item].bookname)
                                    .font(.title)
                                    .font(.system(size:20))
                                Text(alldata_wgwx[item].bookauthor)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text(alldata_wgwx[item].booktext)
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
                            
                            self.show = false
                            
                        }
                        
                    }
                )
                .navigationBarTitle(Text("外国文学"))
            }
            
        }
        
    }
}

struct wx: View {
    @Binding var userid:String
    @Binding var show: Bool
    var body: some View {
    return
        VStack {
            NavigationView {
                List(0..<alldata_wx.count){ item in
                    NavigationLink(destination: Book( userid: self.$userid,bookimg: alldata_wx[item].bookimg, booktitle: alldata_wx[item].bookname, bookauthor: alldata_wx[item].bookauthor, bookclass: alldata_wx[item].bookclass, booktxt: alldata_wx[item].booktext, bookfen: alldata_wx[item].bookscore, bookisbn: alldata_zgwx[item].bookisbn)) {
                        HStack {
                            WebImage(url:URL(string: alldata_wx[item].bookimg))
                                .resizable()
                                .frame(width: 90, height: 130, alignment: .top)
                                .cornerRadius(10)
                            VStack(alignment:.leading){
                                Text(alldata_wx[item].bookname)
                                    .font(.title)
                                    .font(.system(size:20))
                                Text(alldata_wx[item].bookauthor)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                Text(alldata_wx[item].booktext)
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
                            
                            self.show = false
                            
                        }
                        
                    }
                )
                .navigationBarTitle(Text("武侠经典"))
            }
            
        }
        
    }
}

struct zgwx: View {
    @Binding var userid:String
    @Binding var show: Bool
    var body: some View {
    return
        VStack {
            NavigationView {
                List(0..<alldata_zgwx.count){ item in
                    NavigationLink(destination: Book( userid: self.$userid,bookimg: alldata_zgwx[item].bookimg, booktitle: alldata_zgwx[item].bookname, bookauthor: alldata_zgwx[item].bookauthor, bookclass: alldata_zgwx[item].bookclass, booktxt: alldata_zgwx[item].booktext, bookfen: alldata_zgwx[item].bookscore, bookisbn: alldata_zgwx[item].bookisbn)) {
                    HStack {
                        WebImage(url:URL(string: alldata_zgwx[item].bookimg))
                            .resizable()
                            .frame(width: 90, height: 130, alignment: .top)
                            .cornerRadius(10)
                        VStack(alignment:.leading){
                            Text(alldata_zgwx[item].bookname)
                                .font(.title)
                                .font(.system(size:20))
                            Text(alldata_zgwx[item].bookauthor)
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                            Text(alldata_zgwx[item].booktext)
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
                                
                                self.show = false
                                
                            }
                            
                        }
                    )
                    .navigationBarTitle(Text("中国文学"))
        }
        
        }
        
    }
}

