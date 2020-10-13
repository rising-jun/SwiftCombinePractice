//
//  TourInfoRespons.swift
//  SwiftUICombinePractice
//
//  Created by 김동준 on 2020/10/05.
//

import Foundation
struct TourInfoRespons: Decodable{
    var response: Body?
}

struct Body: Decodable{
    var body: Items?
    var head: String?
}

struct Items: Decodable{
    var items: Item?
}

struct Item: Decodable{
    var item: [TourInfo]?
}
