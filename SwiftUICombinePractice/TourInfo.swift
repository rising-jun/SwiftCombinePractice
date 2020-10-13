//
//  TourInfo.swift
//  SwiftUICombinePractice
//
//  Created by 김동준 on 2020/09/29.
//

import Foundation
import SwiftUI

struct TourInfo: Hashable, Codable{
    var galWebImageUrl: URL
    var galPhotographyLocation: String?
    var galTitle: String?
    var galPhotographer: String?
    
    private enum CodingKeys : String, CodingKey {
            case galWebImageUrl, galPhotographyLocation, galTitle, galPhotographer
    }
}

