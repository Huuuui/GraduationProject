//
//  TeacherManagement.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/2.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI

struct TeacherManagement: View {
    //Teacher_zeng(teacherbookisbn: "", teacherbookname: "", teacherbookauthor: "", teacherbooktext: "", teacherbookimg: "", teacherbookscore: "")
    var body: some View {
        NavigationView {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                NavigationLink(destination: Teacher_zeng(teacherbookisbn: "test", teacherbookname: "test", teacherbookauthor: "test", teacherbooktext: "test", teacherbookimg: "test", teacherbookscore: "test")) {
                HStack {
                    Text("增加书籍")
                        .foregroundColor(Color.black)
                        .font(.system(size: 15))
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
        }
        
    }
}

struct TeacherManagement_Previews: PreviewProvider {
    static var previews: some View {
        TeacherManagement()
    }
}
