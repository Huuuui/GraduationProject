//
//  DataStore.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/3/15.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import Combine

class DataStore: ObservableObject {
    @Published var bgdwx: [booklist] = []
    @Published var bjs: [booklist] = []
    @Published var brwkp: [booklist] = []
    @Published var bshjj: [booklist] = []
    @Published var bwgwx: [booklist] = []
    @Published var bwx: [booklist] = []
    @Published var bzgwx: [booklist] = []
    @Published var bclass: [bookclass] = []
    
    init() {
        get_class()
        get_js()
        get_wx()
        get_gdwx()
        get_rwkp()
        get_shjj()
        get_wgwx()
        get_zgwx()
    }
    func get_class() {
        Api().get_class { (classlist) in
            self.bclass = classlist
        }
    }
    func get_gdwx()  {
        Api().get_list(completion: { (booklist) in
            self.bgdwx = booklist
        }, str: "gdwx")
    }
    func get_js()  {
        Api().get_list(completion: { (booklist) in
            self.bjs = booklist
        }, str: "js")
    }
    func get_rwkp()  {
        Api().get_list(completion: { (booklist) in
            self.brwkp = booklist
        }, str: "rwkp")
    }
    func get_shjj()  {
        Api().get_list(completion: { (booklist) in
            self.bshjj = booklist
        }, str: "shjj")
    }
    func get_wgwx()  {
        Api().get_list(completion: { (booklist) in
            self.bwgwx = booklist
        }, str: "wgwx")
    }
    func get_wx()  {
        Api().get_list(completion: { (booklist) in
            self.bwx = booklist
        }, str: "wx")
    }
    func get_zgwx()  {
        Api().get_list(completion: { (booklist) in
            self.bzgwx = booklist
        }, str: "zgwx")
    }
}
