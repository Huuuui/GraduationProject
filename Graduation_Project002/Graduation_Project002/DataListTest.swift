//
//  DataListTest.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/5.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI

struct DataListTest: View {
     
    @State var suiji:[booklist] = []
    var body: some View {
        VStack {
//            Button(action: {
//                Api().get_list(completion: { (testdata) in
//                    self.suijishuju = testdata
//                }, str: "js")
//            }) {
//                Text("获取数据")
//            }
            Button(action: {
                Api().get_searchlist(completion: { (booklist) in
                    self.suiji = booklist
                }, str: "三国演义")
                //print("ok")
            }) {
                Text("搜索")
            }
            List(self.suiji) { item in
                HStack {
                        
                    Text("数据长度：\(self.suiji.count)\(item.bookname)")
                }
            }
        }
    }
}

struct DataListTest_Previews: PreviewProvider {
    static var previews: some View {
        DataListTest()
    }
}
