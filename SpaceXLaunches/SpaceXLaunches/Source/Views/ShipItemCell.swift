//
//  ShipItemCell.swift
//  SpaceXLaunches
//
//  Created by Tolga Taş on 31.01.2022.
//

import UIKit

class ShipItemCell: UICollectionViewCell {
    
    //MARK: - Variables
    private(set) lazy var shipNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var shipImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - Override Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(shipImageView)
        contentView.addSubview(shipNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            shipImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            shipImageView.heightAnchor.constraint(equalToConstant: 90),
            shipImageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            shipImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            
            shipNameLabel.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            shipNameLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
