//
//  MoviesViewController.swift
//  EnjoyFlix
//
//  Created by Adem Tarhan on 18.07.2023.
//

import Combine
import UIKit

class MoviesViewController: UIViewController {
    var viewModel: MoviesViewModel!

    @IBOutlet var collectionView: UICollectionView!

    private var cancellables: Set<AnyCancellable> = []
    private lazy var dataSource = generatedDataSource
    private lazy var sections = MoviesSection.allCases
    private lazy var nowPlayingCellID = "NowPlayingCollectionViewCell"
    private lazy var regularMovieCellID = "RegularMovieCollectionViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSubsribers()
        viewModel.load()
    }

    private var generatedDataSource: UICollectionViewDiffableDataSource<MoviesSection, CollectionModel> {
        let dataSource = UICollectionViewDiffableDataSource<MoviesSection, CollectionModel>(collectionView: collectionView) { _, indexPath, model in
            let section = self.sections[indexPath.section]

            switch section {
            case .nowPlaying:
                guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionViewCell.identifier, for: indexPath) as? NowPlayingCollectionViewCell else {
                    return UICollectionViewCell()
                }

                cell.setUp(model)

                return cell

            case .upcoming, .topRated, .popular:
                guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.regularMovieCellID, for: indexPath) as? RegularMovieCollectionViewCell else {
                    return UICollectionViewCell()
                }

                cell.setUp(model)

                return cell
            }
        }
        

        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderWithButton.reuseIdentifier, for: indexPath) as? HeaderWithButton else {
                return nil
            }

            let section = self.sections[indexPath.section]
            header.set(withTitle: section.title)

            return header
        }
         

        return dataSource
    }
}

private extension MoviesViewController {
    func setupUI() {
        view.backgroundColor = .systemBackground

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .clear
        appearance.shadowColor = nil

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.collectionViewLayout = createComponsitionalLayout()

        collectionView.register(UINib(nibName: nowPlayingCellID, bundle: .main), forCellWithReuseIdentifier: nowPlayingCellID)
        collectionView.register(UINib(nibName: regularMovieCellID, bundle: .main), forCellWithReuseIdentifier: regularMovieCellID)
        collectionView.register(HeaderWithButton.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderWithButton.reuseIdentifier)
    }

    func setupSubsribers() {
        viewModel.snapshotPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] snapshot in
                self?.dataSource.apply(snapshot)
            }
            .store(in: &cancellables)
    }
}

private extension MoviesViewController {
    func createComponsitionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = self.sections[sectionIndex]

            switch section {
            case .nowPlaying:
                return self.createNowPlayingSection()
            case .upcoming, .topRated, .popular:
                return self.createRegularSection()
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16
        layout.configuration = config

        return layout
    }

    func createNowPlayingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(16 / 9))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered

        return section
    }

    func createRegularSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        section.boundarySupplementaryItems = [createSectionHeader()]

        return section
    }

    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(32))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return header
    }
}

extension MoviesViewController: UICollectionViewDelegate {}
