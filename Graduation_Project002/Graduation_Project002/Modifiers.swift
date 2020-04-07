//
//  Modifiers.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/3/9.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

//import SwiftUI
//
//struct CustomFontModifier: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.custom("FZY3JW", size: 20))
//    }
//}
import UIKit

class JWellUserModel: NSObject,NSCoding {
   let filePath = NSHomeDirectory() + "/Documents/contacts.data"
    var mainUserId: Int?
    var id: Int?
    var key: String?
    var name: String?
    // 解档
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.mainUserId   = aDecoder.decodeObject(forKey: "mainUserId") as? Int
        self.id           = aDecoder.decodeObject(forKey: "id") as? Int
        self.key          = aDecoder.decodeObject(forKey: "key") as? String
        self.name         = aDecoder.decodeObject(forKey: "name") as? String
    }
    
    // 归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.mainUserId,forKey: "mainUserId")
        aCoder.encode(self.id,forKey: "id")
        aCoder.encode(self.key,forKey: "key")
        aCoder.encode(self.name,forKey: "name")
    }
    
    override init() {
        
    }
 
}
