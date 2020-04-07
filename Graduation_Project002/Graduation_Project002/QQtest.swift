//
//  QQtest.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/4/2.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import Combine
struct dsfafsf: View {
    static let pub: PassthroughSubject<AnyView?, Never> = .init()
    @State private var isPresented: AnyView? = nil

    var body: some View {
        VStack {
            Button("to sheet") {}
        }
        .sheet(isPresented: .constant(self.isPresented != nil)) { // sheet 放得往外面 一点, 避免 奇怪的问题
            if self.isPresented != nil {
                self.isPresented!
            }
        }
        .onReceive(dsfafsf.pub) { self.isPresented = $0 }
    }
}

func 弹出(_ a: AnyView?) {
    dsfafsf.pub.send(a)
}
