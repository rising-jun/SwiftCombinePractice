//
//  Interactor.swift
//  SwiftUICombinePractice
//
//  Created by 김동준 on 2020/10/07.
//

import Foundation
import SwiftUI
import Combine
class Interactor{
    private var viewModel: InstaPostViewModel?
    
    init(viewModel: InstaPostViewModel){
        self.viewModel = viewModel
    }
    private var dataCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        dataCancellable?.cancel()
    }
    
    public func setPostList(){
        
        print("hi")
        var urlComponents = URLComponents(string: "http://api.visitkorea.or.kr/openapi/service/rest/PhotoGalleryService/galleryList?serviceKey=8KMZQMPCBSiU%2F6nqRFH1iBw9BH9Ww2xgitwSo3yy5FIEOyfEFxiyeExpay9ZucnXtW%2BcrMmdXakp815ZYnEmHg%3D%3D&pageNo=1&numOfRows=10&MobileOS=ETC&MobileApp=AppTest&arrange=A&_type=json")!

        var request = URLRequest(url: urlComponents.url!)
        dataCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map{
                var data = String(data: $0.data, encoding: .utf8)!
                //print(data)
                return data.data(using: .utf8)!
            }
            .decode(type: TourInfoRespons.self, decoder: JSONDecoder())
            .map{
                return ($0.response?.body?.items?.item)!
            }
            .replaceError(with: [])
            .receive(on: RunLoop.current)
            .eraseToAnyPublisher()
            .assign(to: viewModel.postList, on: self)
            
    }
}
