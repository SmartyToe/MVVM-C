//
//  HotelListViewController Sort Delegate.swift
//  Hotels
//
//  Created by Amir lahav on 13/02/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit
import DeepDiff


extension HotelListViewController:HeaderProtocolDelegate
{
    // user want to sort hotels
    func didSelectSort(sort: SortBy) {
        viewModel.sort(sortBy:sort)
    }
    
}

extension HotelListViewController:HotelListViewModelDelegate
{
    func reload() {
        hotelList?.reloadData()
    }
    
    
    func reloadWith(change: [Change<Hotel>]) {
        
        // Heckel Algoritem
        hotelList?.reload(changes: change, updateData: {
            
        })
    }
    
}
