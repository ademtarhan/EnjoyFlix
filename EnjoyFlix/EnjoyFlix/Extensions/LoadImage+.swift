//
//  LoadImage+.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 21.07.2023.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func loadImage(withURL url: URL? = nil, urlString: String? = nil) {
        if let url {
            let resource = ImageResource(downloadURL: url, cacheKey: "\(url.absoluteString)")
            KF.resource(resource).set(to: self)

        } else if let urlString {
            guard let url = URL(string: urlString) else {
                backgroundColor = .secondarySystemBackground
                return
            }
            let resource = ImageResource(downloadURL: url, cacheKey: "\(url.absoluteString)")
            KF.resource(resource).set(to: self)

        } else {
            backgroundColor = .secondarySystemBackground
        }
    }
}


