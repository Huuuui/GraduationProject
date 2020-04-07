//
//  SQLtestData.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/1.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation

//对应表随机查询30条数据
//var landmark: SQLbook_js  后续使用中需要先实例化
//let bookdata_class: [SQLbookclass] = SQLbookclass.rows( )

let bookdata_js: [SQLbook_js] = SQLbook_js.rows( order: "RANDOM() ", limit: 8)
let alldata_js:[SQLbook_js] = SQLbook_js.rows(order: "RANDOM() ")

let bookdata_gdwx: [SQLbook_gdwx] = SQLbook_gdwx.rows( order: "RANDOM() ", limit: 8)
let alldata_gdwx:[SQLbook_gdwx] = SQLbook_gdwx.rows(order: "RANDOM() ")

let bookdata_rwkp: [SQLbook_rwkp] = SQLbook_rwkp.rows( order: "RANDOM() ", limit: 8)
let alldata_rwkp: [SQLbook_rwkp] = SQLbook_rwkp.rows(order: "RANDOM() ")

let bookdata_shjj: [SQLbook_shjj] = SQLbook_shjj.rows( order: "RANDOM() ", limit: 8)
let alldata_shjj: [SQLbook_shjj] = SQLbook_shjj.rows(order: "RANDOM() ")

let bookdata_wgwx: [SQLbook_wgwx] = SQLbook_wgwx.rows( order: "RANDOM() ", limit: 8)
let alldata_wgwx: [SQLbook_wgwx] = SQLbook_wgwx.rows(order: "RANDOM() ")

let bookdata_wx: [SQLbook_wx] = SQLbook_wx.rows( order: "RANDOM() ", limit: 8)
let alldata_wx: [SQLbook_wx] = SQLbook_wx.rows(order: "RANDOM() ")

let bookdata_zgwx: [SQLbook_zgwx] = SQLbook_zgwx.rows( order: "RANDOM() ", limit: 8)
let alldata_zgwx: [SQLbook_zgwx] = SQLbook_zgwx.rows(order: "RANDOM() ")
