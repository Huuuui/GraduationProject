//
//  CFNetHelper.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/5/11.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//
//负责检测是否联网
import Foundation
import Network

class CFNetHelper: ObservableObject {
    @Published  var netok = false
  
    init(){
        let monitor = NWPathMonitor()
               monitor.pathUpdateHandler = { path in
                   if path.status == .satisfied {
                       print("We're connected!")
                       DispatchQueue.main.async {
                           netModel.netok = true
                       }
                       
                   } else {
                       print("No connection.")
                       DispatchQueue.main.async {
                           netModel.netok = false
                       }
                   }
                
                   print(path.isExpensive)
               }
               let queue = DispatchQueue(label: "Monitor")
               monitor.start(queue: queue)
    }
}
