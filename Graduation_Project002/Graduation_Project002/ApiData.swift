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
struct loginreturn:Codable, Identifiable {
    let id = UUID()
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
    var state: String
}
struct isjieyue:Codable, Identifiable {
    let id = UUID()
    var state: String
}
class Api {
    
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
    
    
    func student_getbook(username: String,bookisbn: String,bookname:String,bookimg:String,bookauthor:String) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpStudentGetbook.php?Suser=\(username)&Sbookisbn=\(bookisbn)&Sbookname=\(bookname)&Sbookimg=\(bookimg)&Sbookauthor=\(bookauthor)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            print("还是失败了 日")
            return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            print(url)
        }
        .resume()
    }
    
    func student_backbook(username: String,bookisbn: String) {//completion: @escaping ([loginreturn]) -> () ,
        let url0 = "http://m300239h20.zicp.vip/phpStudentBackbook.php?Suser=\(username)&Sbookisbn=\(bookisbn)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{
            print("还是失败了 日")
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
            print(loginstate)
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
    
    func get_searchlist(completion: @escaping ([booklist]) -> () ,str: String) {
        
        let url0 = "http://m300239h20.zicp.vip/phpsousuo.php?search=\(str)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) //中文转码
        guard let url = URL(string: url0 ?? "") else{  return }
        
        
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
