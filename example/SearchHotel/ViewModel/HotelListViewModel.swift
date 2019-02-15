//
//  HotelListViewModel.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit
import DeepDiff


protocol HotelListViewModelDelegate:class {
    func reload()
    func reloadWith(change:[Change<Hotel>])
}

class HotelListViewModel {
    
    // delegate
    weak var delegate:HotelListViewModelDelegate?
    
    
    let model:HotelListModel

    // model
    
    init(model:HotelListModel) {
        self.model = model
    }
    
    // data source
    var numberOfItems:Int  = 0
    
    
    // hotels data
    var hotels:[Hotel] = []
    {
        didSet{
            // update ui
            numberOfItems = hotels.count
        }
    }
    
    
    // fetch hotels from server
    func getHotels(param:Data) {
        
        
            
        model.fetchHotels(parametrs: param, complition: {[weak self] (hotels) in
            
            
            // map hotels for removing nil hotels
            self?.hotels = hotels.hotels.map({ $0})
            
                DispatchQueue.main.async {
                    self?.delegate?.reload()
                    self?.sort(sortBy: .cheapest)
                }
            
            // update UI
        }) { (error) in
            
            // TODO - popup alert
            print(error)
        }
    }
    
    // sort hotels
    func sort(sortBy:SortBy)
    {
        let oldHotel = Array(hotels)
        
        switch sortBy {
        case .cheapest:
            hotels = hotels.sorted(by: {$0.totalPrice < $1.totalPrice})
        case .topRated:
            hotels = hotels.sorted(by: {$0.rank > $1.rank})
        case .nearst:
            hotels = hotels.sorted(by: {$0.distance < $1.distance})
        }
        let change = diff(old: oldHotel, new: hotels)
        delegate?.reloadWith(change: change)
    }
    
    func cell(_ forIndex:IndexPath) -> Hotel?
    {
        if forIndex.row < hotels.count  {
            return hotels[forIndex.row]
        }
        return nil
    }
    
}
