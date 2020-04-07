//
//  StarStore.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/3/9.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI
import Combine

class StarStore: ObservableObject {
    @Published var stardates:[Stardate] = StardateD
}
