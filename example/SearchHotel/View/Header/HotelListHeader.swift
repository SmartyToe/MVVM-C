//
//  FloatingHeader.swift
//  Hotels
//
//  Created by Amir lahav on 31/01/2019.
//  Copyright © 2019 Amir lahav. All rights reserved.
//

import UIKit

protocol HeaderProtocolDelegate:class {
    func didSelectSort(sort:SortBy)
}

enum SortBy:String
{
    case cheapest
    case topRated
    case nearst
}


class HotelListHeader: UICollectionReusableView {
    
    
    
    
    
    // color
    
    let lightGray = UIColor.lightGray
    let purple = UIColor.init(red: 111/255, green: 99/255, blue: 133/255, alpha: 1)
    
    // outlet
    
    @IBOutlet weak var cheapestBtn: UIButton!
    @IBOutlet weak var topRated: UIButton!
    @IBOutlet weak var mostCentral: UIButton!
    @IBOutlet weak var underlineView: UIView!

    let underlineViewHeight:CGFloat = 3
    var underlineViewY:CGFloat  { return self.underlineView.frame.origin.y }

    
    
    // acction

    @IBAction func mostCentral(_ sender: UIButton) {
        delegate?.didSelectSort(sort: .nearst)
        updateUI(sender)

    }
    
    
    @IBAction func topRated(_ sender: UIButton) {
        delegate?.didSelectSort(sort: .topRated)
        updateUI(sender)


    }
    @IBAction func cheapest(_ sender: UIButton) {
        delegate?.didSelectSort(sort: .cheapest)
        updateUI(sender)
    }
    
    var btns:[UIButton] { return  [cheapestBtn,topRated,mostCentral]  }
    
    weak var delegate:HeaderProtocolDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
        setUnderlinePosition(cheapestBtn)
        setSelectBtn(cheapestBtn)

    }
    

    func updateUI(_ sender:UIButton)
    {
        setUnderlinePosition(sender)
    }
    
    
    
    func setUnderlinePosition(_ sender:UIButton)
    {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .allowUserInteraction, animations: {
                self.underlineView.frame = CGRect(x: sender.frame.origin.x, y: self.underlineViewY, width: sender.frame.width, height: self.underlineViewHeight)
                self.setSelectBtn(sender)
            }, completion: nil)
        }

    }
    
    func setSelectBtn(_ sender:UIButton)
    {
        for btn in btns {
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.setTitleColor(lightGray, for: .normal)
        }
        sender.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        sender.setTitleColor(purple, for: .normal)

    }
}




