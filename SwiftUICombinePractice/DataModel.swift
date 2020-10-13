//
//  DataModel.swift
//  SwiftUICombinePractice
//
//  Created by 김동준 on 2020/09/24.
//

import Foundation
import Combine
class DataModel{
    func bringData(){
        print("hi?")
        var url = URL(string: "https://www.instagram.com/officialfromis_9/")
        let subscription = URLSession.shared
            .dataTaskPublisher(for: url!)
            .map({ (data, response) in
                return String(data: data, encoding: .utf8)
            })
            .sink { (completion) in
                if case .failure(let err) = completion {
                      print("Retrieving data failed with error \(err)")
                    }
            } receiveValue: { (data) in
                print(data)
            }

    }
}
