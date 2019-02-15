//
//  HotelCollectionViewCell.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import UIKit

class HotelCollectionViewCell: UICollectionViewCell {

    // varibles
    var shadowDropped:Bool = false
    
    
    // outlets
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelPrice: UILabel!
    @IBOutlet weak var cityCenterDistance: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var ratingView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    
    func dropShadow()
    {
        if !shadowDropped {
            
            // round corners
            self.contentView.layer.cornerRadius = 4.0
            self.contentView.layer.borderWidth = 0.0
            self.contentView.layer.borderColor = UIColor.clear.cgColor
            self.contentView.layer.masksToBounds = true
            
            // drop shadow
            self.layer.shadowColor = UIColor.lightGray.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
            self.layer.shadowRadius = 4.0
            
            // better preformance without opacity
            self.layer.shadowOpacity = 1.0
            
            
            self.layer.masksToBounds = false
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
            
            shadowDropped = true
        }
    }
    
    func bind(hotel:Hotel)  {
        
        // bind data
        self.hotelName.text = hotel.hotelName
        self.cityCenterDistance.text = "\(hotel.distance.format(.oneDigit)) km from city center"
        self.hotelPrice.text = "\(hotel.totalPrice.format(.rounded))"

        setStars(rank: hotel.rank)
        
        /// url is broken too
        let imageURL = URL(fileURLWithPath: hotel.hotelImageURL)
    }
    
    func setStars(rank:Int)
    {
        switch rank {
        case 3:
            ratingView.image = UIImage(named: "3Stars")
        case 4:
            ratingView.image = UIImage(named: "4Stars")
        case 5:
            ratingView.image = UIImage(named: "5Stars")
        default:
            ratingView.image = nil
        }
    }

    override func prepareForReuse() {
        
        ratingView.image = nil
        hotelName.text = ""
        cityCenterDistance.text = ""
        hotelPrice.text = ""
    }
}
