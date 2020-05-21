//
//  Data.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/3/14.
//  Copyr ight © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import Alamofire


struct booklist: Codable, Identifiable {
    let id = UUID()
    var bookclass: String
    var bookisbn: String
    var bookname: String
    var bookauthor: String
    var booktext: String
    var bookimg: String
    var bookscore: String
}

struct bookclass: Codable, Identifiable {
    let id = UUID()
    var classname: String
    
}
struct user:Codable, Identifiable {
    let id = UUID()
    var username: String
    var userpass: String
    var shenfen: String
    var userxingming: String
    var usertouxiang: String
}
struct jieyuenum:Codable , Identifiable {
    let id = UUID()
    var num: String
}
struct loginreturn:Codable, Identifiable {
    let id = UUID()
    //var username: String
    var shenfen: String = "-1"
    var userxingming: String
    var usertouxiang: String
}
struct jieyuelist:Codable, Identifiable {
    let id = UUID()
    var bookisbn: String
    var bookname: String
    var bookimg: String
    var bookauthor: String
    var get_date: String
    var back_date: String
    
    var real_back_date: String
    var state: String
    var fine: String
}
struct isjieyue:Codable, Identifiable {
    let id = UUID()
    var state: String
}
struct tongyongstate:Codable, Identifiable {
    let id = UUID()
    var state : String
}
struct nownum:Codable, Identifiable {
    //被用来接收所有和书本数量有关的
    let id = UUID()
    var booknum: String
}
struct tbchalishi: Codable,Identifiable {
    //返回这本书都被谁什么时候借阅，什么时候归还
    let id = UUID()
    var userxingming:String
    var get_date:String
    var real_back_date:String
}
struct managementjieyue:Codable, Identifiable {
    //用来返回结果这本书的人的学号、姓名
    let id = UUID()
    var username: String
    var userxingming: String
}
struct managementjieyue2:Codable, Identifiable {
    //用来返回借过这本书得人的归还时间、借阅时间
    let id = UUID()
    var user: String
    var get_date: String
    var back_date: String
    var real_back_date: String
    var fine: String
}
struct managementjieyueuser:Codable, Identifiable {
    let id = UUID()
    var username: String
    var userxingming: String
}
struct bjycount:Codable, Identifiable {
    let id = UUID()
    var bjycount: String
}
struct bookfine:Codable, Identifiable {
    let id = UUID()
    var fine: String
}
struct bookjienum:Codable, Identifiable {
    let id = UUID()
    var jienum: String
}
class Api {
    //获取该用户罚金多少
    func phpBookMaxFine(user:String,completion: @escaping ([bookfine]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpBookMaxFine.php?user=\(user)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            print("失败")
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([bookfine].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    //获取该用户借了多少本
    func phpBookMaxinfo(user:String,completion: @escaping ([bookjienum]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpBookMaxinfo.php?user=\(user)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            print("失败")
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([bookjienum].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    //获取借阅表内所有用户的信息
    func phpTeacherJieyueuser(completion: @escaping ([managementjieyueuser]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpTeacherJieyueUser.php".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            print("失败")
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([managementjieyueuser].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    //获取借阅表内所有的信息
    //4.19  Api功能发生变化，现在应该是返回借阅这本书的人的学号、姓名
    func phpTeacherJieyueLishi(completion: @escaping ([managementjieyue]) -> () ,bookisbn:String,state:String) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpTeacherJieyueLishi.php?bookisbn=\(bookisbn)&state=\(state)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            print("失败")
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([managementjieyue].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    //用来获取结果这本书的人的时间、学号
    func phpTeacherJieyueLishi2(completion: @escaping ([managementjieyue2]) -> () ,bookisbn:String,state:String) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpTeacherJieyueLishi2.php?bookisbn=\(bookisbn)&state=\(state)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            print("失败")
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([managementjieyue2].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    //获取当前书都被谁借过
    func phpTeacherBookchalishi(bookisbn:String,completion: @escaping ([tbchalishi]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpTeacherBookchalishi.php?isbn=\(bookisbn)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            print("失败")
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([tbchalishi].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    //获取当前书的被借阅量
    func phpBookJieyuenum(bookisbn:String,completion: @escaping ([nownum]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpBookJieyuenum.php?isbn=\(bookisbn)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([nownum].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    //获取当前书的总库存量
    func phpBookAllnum(bookisbn:String,completion: @escaping ([nownum]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpBookAllnum.php?isbn=\(bookisbn)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([nownum].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    //获取当前书的库存量
    func phpStudentGetbooknownum(bookisbn:String,completion: @escaping ([nownum]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpStudentGetbooknownum.php?isbn=\(bookisbn)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            print("失败")
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([nownum].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    //获取当前书的借阅次数
    func phpJieyuelishicount(bookisbn:String,completion: @escaping ([bjycount]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpTeacherJieyueLishicount.php?bookisbn=\(bookisbn)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            print("失败")
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([bjycount].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    //图书库存借书还书api
    func phpStudentGetbooknum(isbn:String,tonum:String,completion: @escaping ([tongyongstate]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpStudentGetbooknum.php?isbn=\(isbn)&tonum=\(tonum)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            print("失败")
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([tongyongstate].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    func phpTeacherStudentchajieyue(userid:String,state:String,completion: @escaping ([jieyuenum]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpTeacherStudentchajieyue.php?userid=\(userid)&state=\(state)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            print("失败")
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([jieyuenum].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    func phpTeacherStudentcha(userid:String,completion: @escaping ([user]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpTeacherStudentcha.php?userid=\(userid)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([user].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(stategai.count)
        }
        .resume()
    }
    func phpTeacherStudentgai(userid:String,userpass:String,userxingming:String,usertouxiang:String,completion: @escaping ([tongyongstate]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpTeacherStudentgai.php?user=\(userid)&userpass=\(userpass)&xingming=\(userxingming)&userimg=\(usertouxiang)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([tongyongstate].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(stategai.count)
        }
        .resume()
    }
    
    func phpTeacherStudentshan(completion: @escaping ([isjieyue]) -> () ,studentid: String) {//
        let url0 = "http://m300239h20.zicp.vip/phpTeacherStudentshan.php?userid=\(studentid)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let statezeng = try! JSONDecoder().decode([isjieyue].self, from: data!)
            DispatchQueue.main.async {
                completion(statezeng)
            }
            print(url)
        }
        .resume()
    }
    func phpTeacherStudentzeng(completion: @escaping ([isjieyue]) -> () ,studentid: String,studentpass: String,studentname: String,studentimg: String) {//
        let url0 = "http://m300239h20.zicp.vip/phpTeacherStudentzeng.php?studentid=\(studentid)&studentpass=\(studentpass)&studentname=\(studentname)&studentimg=\(studentimg)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let statezeng = try! JSONDecoder().decode([isjieyue].self, from: data!)
            DispatchQueue.main.async {
                completion(statezeng)
            }
            print(url)
        }
        .resume()
    }
    //book改里面的查询图书信息
    func phpTeacherBookCHAgai(bookisbn:String,completion: @escaping ([booklist]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpTeacherBookcha.php?isbn=\(bookisbn)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([booklist].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    func phpTeacherBookgai(bookisbn:String,bookname: String,bookauthor: String,booktext: String,bookimg: String,bookscore: String,newbookclass: String,oldbookclass: String,completion: @escaping ([isjieyue]) -> () ) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpTeacherBookgai.php?bookname=\(bookname)&bookauthor=\(bookauthor)&booktext=\(booktext)&bookimg=\(bookimg)&bookscore=\(bookscore)&newbookclass=\(newbookclass)&oldbookclass=\(oldbookclass)&bookisbn=\(bookisbn)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stategai = try! JSONDecoder().decode([isjieyue].self, from: data!)
            DispatchQueue.main.async {
                completion(stategai)
            }
            print(url)
        }
        .resume()
    }
    
    func phpTeacherBookshan(completion: @escaping ([isjieyue]) -> () ,bookisbn: String) {//
        let url0 = "http://m300239h20.zicp.vip/phpTeacherBookshan.php?bookisbn=\(bookisbn)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            
            return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let stateshan = try! JSONDecoder().decode([isjieyue].self, from: data!)
            DispatchQueue.main.async {
                completion(stateshan)
            }
            print(stateshan)
        }
        .resume()
    }
    
    func phpTeacherBookzeng(completion: @escaping ([isjieyue]) -> () ,bookname: String,bookauthor: String,bookisbn: String,booktext: String,bookimg: String,bookscore: String,bookclass: String,booknum:String) {//
        let url0 = "http://m300239h20.zicp.vip/phpTeacherBookzeng.php?bookname=\(bookname)&bookauthor=\(bookauthor)&bookisbn=\(bookisbn)&booktext=\(booktext)&bookimg=\(bookimg)&bookscore=\(bookscore)&bookclass=\(bookclass)&booknum=\(booknum)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let statezeng = try! JSONDecoder().decode([isjieyue].self, from: data!)
            DispatchQueue.main.async {
                completion(statezeng)
            }
            print(url)
        }
        .resume()
    }
    
    func get_isjieyue(completion: @escaping ([isjieyue]) -> () ,userid: String,bookisbn: String) {
        guard let url = URL(string: "http://m300239h20.zicp.vip/phpGetbookisjieyue.php?userid=" + userid + "&bookisbn=" + bookisbn) else{return}
        //print(url)
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            let blist = try! JSONDecoder().decode([isjieyue].self, from: data!)
            DispatchQueue.main.async {
                completion(blist)
            }
            print(url)
        }
        .resume()
    }
    
    
    
    func get_jieyuelist(completion: @escaping ([jieyuelist]) -> () ,userid: String,state: String) {
        guard let url = URL(string: "http://m300239h20.zicp.vip/phpGetThreejieyueList.php?userid=" + userid + "&state=" + state) else{return}
        //print(url)
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            let blist = try! JSONDecoder().decode([jieyuelist].self, from: data!)
            DispatchQueue.main.async {
                
                completion(blist)
            }
            print(url)
        }
        .resume()
    }
    
    
    func student_getbook(completion: @escaping ([isjieyue]) -> () ,username: String,bookisbn: String,bookname:String,bookimg:String,bookauthor:String) {//
        let url0 = "http://m300239h20.zicp.vip/phpStudentGetbook.php?Suser=\(username)&Sbookisbn=\(bookisbn)&Sbookname=\(bookname)&Sbookimg=\(bookimg)&Sbookauthor=\(bookauthor)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let blist = try! JSONDecoder().decode([isjieyue].self, from: data!)
            DispatchQueue.main.async {
                
                completion(blist)
            }
            print(url)
        }
        .resume()
    }
    
    func student_backbook(username: String,bookisbn: String) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpStudentBackbook.php?Suser=\(username)&Sbookisbn=\(bookisbn)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            print(url)
        }
        .resume()
    }
    
    
    func to_Login(completion: @escaping ([loginreturn]) -> () ,username: String,userpass: String) {
        
        guard let url = URL(string: "http://m300239h20.zicp.vip/phplogin.php?userid=" + username + "&userpass=" + userpass) else{return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let loginstate = try! JSONDecoder().decode([loginreturn].self, from: data!)
            //DispatchQueue.main.async {
                completion(loginstate)
            //}
            print(url)
            print(loginstate)
        }
        .resume()
    }
    func JieyueJiance(username: String) {
        
        guard let url = URL(string: "http://m300239h20.zicp.vip/phpJieyueJiance.php?userid=" + username) else{return}
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
           
        }
        .resume()
    }
    func get_list(completion: @escaping ([booklist]) -> () ,str: String) {
        guard let url = URL(string: "http://m300239h20.zicp.vip/phpSuiji.php?tabName=booklist_" + str) else{return}
        //print(url)
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            let blist = try! JSONDecoder().decode([booklist].self, from: data!)
            DispatchQueue.main.async {
                
                completion(blist)
            }
            print(url)
        }
        .resume()
    }
    //借阅管理里的搜索书籍
    func phpTeacherJieyueSearch(completion: @escaping ([booklist]) -> () ,bookisbn:String,bookname:String,bookauthor:String) {
        
        let url0 = "http://m300239h20.zicp.vip/phpTeacherJieyueSearch.php?bookisbn=\(bookisbn)&bookname=\(bookname)&bookauthor=\(bookauthor)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{  return }
        
        print(url)
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            let sousuolist = try! JSONDecoder().decode([booklist].self, from: data!)
            DispatchQueue.main.async {
                
                completion(sousuolist)
            }
            //print(sousuolist)
        }
        .resume()
    }
    func get_searchlist(completion: @escaping ([booklist]) -> () ,str: String) {
        
        let url0 = "http://m300239h20.zicp.vip/phpsousuo.php?search=\(str)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{  return }
        
        print(url)
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            let sousuolist = try! JSONDecoder().decode([booklist].self, from: data!)
            DispatchQueue.main.async {
                
                completion(sousuolist)
            }
            //print(sousuolist)
        }
        .resume()
    }
    
    func get_class(completion: @escaping ([bookclass]) -> ()) {
        guard let url = URL(string: "http://m300239h20.zicp.vip/phpbookclass.php") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            let bclass = try! JSONDecoder().decode([bookclass].self, from: data!)
            DispatchQueue.main.async {
                completion(bclass)
            }
            //print(bclass)
        }
        .resume()
    }
}
