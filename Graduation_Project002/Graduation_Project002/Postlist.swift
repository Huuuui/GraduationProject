//
//  Postlist.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/3/14.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI

struct Postlist: View {
    @ObservedObject var store = DataStore()
    var body: some View {
        List(store.bjs) { post in
            Text(post.bookisbn)
                .font(.system(size:20))
                
        }
        .onAppear{
            //print(self.store.posts.bookname)
        }
    }
}

struct Postlist_Previews: PreviewProvider {
    static var previews: some View {
        Postlist()
    }
}
