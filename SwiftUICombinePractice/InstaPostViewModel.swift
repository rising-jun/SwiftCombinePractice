//
//  File.swift
//  SwiftUICombinePractice
//
//  Created by 김동준 on 2020/09/24.
//

import SwiftUI
import Combine

final class InstaPostViewModel: ObservableObject{
    @Published private(set) var postList = [TourInfo]()
    @Published private(set) var tourImage = [TourInfo: UIImage]()
    
    private var dataCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    deinit {
        dataCancellable?.cancel()
    }
    
    public func setPostList(){
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
            .assign(to: \.postList, on: self)
            
    }
    
    public func fetchImage(for tourInfo: TourInfo) {
        print(tourInfo.galWebImageUrl)
        guard case .none = tourImage[tourInfo] else {
            return
        }

        let request = URLRequest(url: tourInfo.galWebImageUrl)
        _ = URLSession.shared.dataTaskPublisher(for: request)
            .map {
                UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: RunLoop.current)
            .eraseToAnyPublisher()
            .sink(receiveValue: { [weak self] image in
                self?.tourImage[tourInfo] = image
            })
    }
    
    public func giveHeart(){
        toggles = true
    }
    
    public func canceledHeart(){
        toggles = false
    }
}
