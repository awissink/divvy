//
//  Tag.swift
//  Divvy
//
//  Created by Eki Uzamere on 10/29/23.
//

import SwiftUI

// Tag Model
struct Tag: Identifiable, Hashable {
    var id = UUID().uuidString
    var text: String
    var size: CGFloat = 0
}
