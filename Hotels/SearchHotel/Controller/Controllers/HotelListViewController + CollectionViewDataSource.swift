//
//  HotelListViewController + CollectionViewDataSource.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import Foundation
import UIKit


extension HotelListViewController:UICollectionViewDataSource
{
    
    // collection view data source methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = hotelList?.dequeueReusableCell(withReuseIdentifier: HotelCollectionViewCell.uniqueIdentifier, for: indexPath) as? HotelCollectionViewCell else {
            fatalError("cant register cell")
        }
        
        // get formated data from view model
        guard let hotel = viewModel.cell(indexPath) else {
            return UICollectionViewCell()
        }
        
        // bind to cell
        cell.bind(hotel:hotel)
        
        // configure cell if needed
        cell.dropShadow()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HotelListHeader.uniqueIdentifier, for: indexPath) as? HotelListHeader else { fatalError("cant get header")}
        
        headerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 56)
        headerView.delegate = self
        
        return headerView
    }
}
