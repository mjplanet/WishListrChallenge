//
//  UIImageView+Extension.swift
//  WishListrChallenge
//
//  Created by Mobin Jahantark on 9/18/22.
//  Copyright © 2022 mobinjt.com. All rights reserved.
//

import UIKit
import Kingfisher

public extension UIImageView {
    func setRemoteImage(with path: String?) {
        guard let path = path else {
            image = nil
            return
        }
        self.kf.setImage(with: URL(string: path))
    }   
}
