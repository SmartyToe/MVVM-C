//
//  HotelListViewController.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import UIKit
import DeepDiff

class HotelListViewController: UIViewController  {
    
    
    let viewModel:HotelListViewModel

    // custom inititation
    init(viewModel:HotelListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.delegate = self
        
        // demo param
        
        let param = Data("""
            {
            "rooms": [ { "travelers": [  { "age_group": "ADT", "age": "\(22)"} ]  } ],
            "destination": "AMS",
            "startDate": "2019-03-01",
            "endDate": "2019-03-10",
            "supplier": "Travolutionary"
            }
            """.data(using: String.Encoding.utf8)!)
        
        
        // fetch hotel from server
        viewModel.getHotels(param: param)
        
        // Do any additional setup after loading the view.
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // outlets
 
    @IBOutlet weak var hotelList: UICollectionView?{
        didSet{
            guard  let hotelList = hotelList else {
                return
            }
            hotelList.delegate = self
            hotelList.dataSource = self
            hotelList.registerNib(HotelCollectionViewCell.self)
            hotelList.registerHeaderNib(HotelListHeader.self)
        }
    }
    
}






