//
//  LaunchDetailViewController.swift
//  SpaceXLaunches
//
//  Created by Tolga Taş on 30.01.2022.
//

import UIKit
import Apollo

class LaunchDetailViewController: UIViewController {
    
    //MARK: - Variables
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack: UIStackView = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 8
        return stack
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var rocketInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var locationDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Where"
        label.numberOfLines = 0
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var dateDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "When"
        label.numberOfLines = 0
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var detailDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Details"
        label.numberOfLines = 0
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var detailContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var detailTextView: UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 14, weight: .light)
        textView.isUserInteractionEnabled = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private lazy var videoLinkButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Link to Video", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    private lazy var shipDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Ships"
        label.numberOfLines = 0
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var shipsCollectionViewLayout: UICollectionViewCompositionalLayout = {
        
        let itemSize: NSCollectionLayoutSize = .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(90))
        let item: NSCollectionLayoutItem = .init(layoutSize: itemSize)
        let group: NSCollectionLayoutGroup = .horizontal(layoutSize: itemSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = .init(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return .init(section: section)
    }()
    
    private lazy var shipsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: shipsCollectionViewLayout)
        collectionView.contentInsetAdjustmentBehavior = .scrollableAxes
        collectionView.allowsSelection = false
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return collectionView
    }()
    
    private lazy var dataSource: LaunchDetailSceneCollectionDataSource = {
        let mainItemCellRegistration = UICollectionView.CellRegistration<ShipItemCell, ShipsViewModel> { (cell, indexPath, item) in
            cell.shipNameLabel.text = item.ships.name
            cell.shipImageView.downloaded(from: item.ships.image ?? "")
        }
        
        let dataSource = LaunchDetailSceneCollectionDataSource(collectionView: shipsCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: ShipsViewModel) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: mainItemCellRegistration, for: indexPath, item: identifier)
        }
        
        return dataSource
    }()
    
    var viewModel: LaunchViewModel? {
        didSet {
            applyUIChanges()
            configureUIActions()
        }
    }
    
    //MARK: - Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        addConstraints()
    }
    
    //MARK: - Private Class Functions
    private func configureShipsSnapshot() {
        var snapshot = LaunchDetailSnapshot()
        snapshot.appendSections([.main])
        guard let ships = viewModel?.launchesPast.ships else { return }
        let nonNilShips = ships.compactMap({ $0 })
        let items = nonNilShips.map { item in
            return ShipsViewModel(ships: item)
        }
        shipsCollectionView.isHidden = items.isEmpty
        shipDescriptionLabel.isHidden = items.isEmpty
        snapshot.appendItems(items)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func applyUIChanges() {
        guard let model = viewModel else { return }
        
        mainLabel.text = model.launchesPast.missionName
        rocketInfoLabel.text = "Rocket: \(model.launchesPast.rocket?.rocketName ?? "Missing")"
        locationLabel.text = model.launchesPast.launchSite?.siteNameLong
        dateLabel.text = .getFormattedDate(string: model.launchesPast.launchDateLocal ?? "")
        detailTextView.text = model.launchesPast.details
        configureShipsSnapshot()
    }
    
    private func configureUI() {
        view.addSubview(containerView)
        containerView.addSubview(stackView)
        detailContainerView.addSubview(detailTextView)
        
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(rocketInfoLabel)
        stackView.setCustomSpacing(64, after: rocketInfoLabel)
        stackView.addArrangedSubview(dateDescriptionLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(locationDescriptionLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(detailDescriptionLabel)
        stackView.addArrangedSubview(detailContainerView)
        stackView.addArrangedSubview(videoLinkButton)
        stackView.addArrangedSubview(shipDescriptionLabel)
        stackView.addArrangedSubview(shipsCollectionView)
    }
    
    private func configureUIActions() {
        videoLinkButton.addAction(.init(handler: { [weak self] _ in
            guard let self = self else { return }
            guard let videoLink = self.viewModel?.launchesPast.links?.videoLink else { return }
            if let url = URL(string: videoLink) {
                UIApplication.shared.open(url)
            }
        }), for: .primaryActionTriggered)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            detailTextView.topAnchor.constraint(equalTo: detailContainerView.topAnchor),
            detailTextView.leadingAnchor.constraint(equalTo: detailContainerView.leadingAnchor),
            detailTextView.trailingAnchor.constraint(equalTo: detailContainerView.trailingAnchor),
            detailTextView.bottomAnchor.constraint(equalTo: detailContainerView.bottomAnchor)
        ])
    }
    
}
