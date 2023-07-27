//
//  RegularMovieCollectionViewCell.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 21.07.2023.
//

import UIKit

class RegularMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet var containerView: UIView!

    @IBOutlet var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.cornerRadius = 20
        posterImageView.layer.cornerRadius = 20
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

    func setUpSeries(_ model: CollectionModel) {
        guard let series = model as? SeriesCollectionModel else {
            let placeholderView = UIView(frame: bounds)
            placeholderView.backgroundColor = .brown
            addSubview(placeholderView)
            return
        }
        posterImageView.loadImage(withURL: series.posterURL)
    }
}
