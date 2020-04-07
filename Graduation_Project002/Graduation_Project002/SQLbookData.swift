//
//  testData.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/1.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

//获取对应表内的数据
import Foundation
import SwiftUI
//class SQLbookclass: SQLTable {
//    var id = ""
//    var classname = ""
//    override var description: String {
//        return "id:\(id), name:\(classname)"
//    }
//    static func customTables() -> String {
//        return "bookclass"
//    }
//}
class SQLbook_gdwx: SQLTable {
    var bookisbn = ""
    var bookclass = ""
    var bookname = ""
    var bookauthor = ""
    var booktext = ""
    var bookimg = ""
    var bookscore = ""
    override var description:String {
        return "id: \(bookisbn ), name: \(bookname)"
    }
    static func customTables() ->String {
        return "booklist_gdwx"
    }
    
}

class SQLbook_js: SQLTable {
    var bookisbn = ""
    var bookclass = ""
    var bookname = ""
    var bookauthor = ""
    var booktext = ""
    var bookimg = ""
    var bookscore = ""
    override var description:String {
        return "id: \(bookisbn ), name: \(bookname)"
    }
    static func customTables() ->String {
        return "booklist_js"
    }
}

class SQLbook_rwkp: SQLTable {
    var bookisbn = ""
    var bookclass = ""
    var bookname = ""
    var bookauthor = ""
    var booktext = ""
    var bookimg = ""
    var bookscore = ""
    override var description:String {
        return "id: \(bookisbn ), name: \(bookname)"
    }
    static func customTables() ->String {
        return "booklist_rwkp"
    }
}

class SQLbook_shjj: SQLTable {
    var bookisbn = ""
    var bookclass = ""
    var bookname = ""
    var bookauthor = ""
    var booktext = ""
    var bookimg = ""
    var bookscore = ""
    override var description:String {
        return "id: \(bookisbn ), name: \(bookname)"
    }
    static func customTables() ->String {
        return "booklist_shjj"
    }
}

class SQLbook_wgwx: SQLTable {
    var bookisbn = ""
    var bookclass = ""
    var bookname = ""
    var bookauthor = ""
    var booktext = ""
    var bookimg = ""
    var bookscore = ""
    override var description:String {
        return "id: \(bookisbn ), name: \(bookname)"
    }
    static func customTables() ->String {
        return "booklist_wgwx"
    }
}

class SQLbook_wx: SQLTable {
    var bookisbn = ""
    var bookclass = ""
    var bookname = ""
    var bookauthor = ""
    var booktext = ""
    var bookimg = ""
    var bookscore = ""
    override var description:String {
        return "id: \(bookisbn ), name: \(bookname)"
    }
    static func customTables() ->String {
        return "booklist_wx"
    }
}

class SQLbook_zgwx: SQLTable {
    var bookisbn = ""
    var bookclass = ""
    var bookname = ""
    var bookauthor = ""
    var booktext = ""
    var bookimg = ""
    var bookscore = ""
    override var description:String {
        return "id: \(bookisbn ), name: \(bookname)"
    }
    static func customTables() ->String {
        return "booklist_zgwx"
    }
}

