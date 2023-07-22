//
//  NowPlayingCollectionViewCell.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 21.07.2023.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {
    @IBOutlet var posterImageView: UIImageView!

    static var identifier: String = "NowPlayingCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setUp(_ model: CollectionModel) {
        guard let movie = model as? MovieCollectionModel else {
            let placeholderView = UIView(frame: bounds)
            placeholderView.backgroundColor = .brown
            addSubview(placeholderView)
            return
        }

        posterImageView.loadImage(withURL: movie.posterURL)
    }
}
