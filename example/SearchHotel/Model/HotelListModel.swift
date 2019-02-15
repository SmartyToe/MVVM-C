//
//  Hotel.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation

class HotelListModel:NSObject {
    
    // api service conform to APIServiceProtocol
    let apiService:APIServiceProtocol

    
    
    
    // initiation with conform to api protocol
    init<T:APIServiceProtocol>(apiService:T) {
        self.apiService = apiService
    }
    
    
    
    
    // fetch hotels
    func fetchHotels(parametrs:Data, complition:@escaping ((Hotels)->()), error:@escaping ((String)->()))
    {
        
        // create request
        let request = RequestData(baseURL: "https://tripsciences.net", path: "hotels?page=1&pageSize=30", method: .post, headers: [:], param: .body(parametrs))
        
        // submit request
        apiService.fetch(request: request, type: Hotels.self) { (result) in
            switch result
            {
                case .succes(let hotels):
                    complition(hotels)
                case .error(let error):
                print(error.localizedDescription)
            }
        }
    }
}


// array of hotels
struct Hotels:Decodable {
    let hotels:[Hotel]
}


// hotel
struct Hotel:Decodable,Hashable {
        
    let hotelId: Int
    let hotelName:String
    let hotelImageURL:String
    let rank:Int
    var distance:Double
    var totalPrice:Double
    let pricePerNight:Double
}
