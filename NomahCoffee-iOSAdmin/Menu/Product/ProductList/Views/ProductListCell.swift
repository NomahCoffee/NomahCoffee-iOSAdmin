//
//  ProductListCell.swift
//  NomahCoffee-iOSAdmin
//
//  Created by Caleb Rudnicki on 6/26/21.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    
    // MARK: Properties
    
    static let reuseIdentifier = String(describing: ProductListCell.self)
    
    var coffee: Coffee? {
        didSet {
            if let imageUrl = coffee?.image {
                imageView.load(url: imageUrl)
            } else {
                imageView.image = nil
            }
            titleLabel.text = coffee?.name
            
            let formatter = NumberFormatter()
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            if let price = formatter.string(from: (coffee?.price ?? 0.0) as NSNumber) {
                subtitleLabel.text = price
            }
            
            configureCell()
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = ProductListConstants.imageViewBorderWidth
        imageView.layer.cornerRadius = ProductListConstants.imageViewCornerRadius
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.lineBreakMode = .byTruncatingTail
        subtitleLabel.numberOfLines = 1
        return subtitleLabel
    }()
    
    private let labelStack: UIStackView = {
        let labelStack = UIStackView()
        labelStack.axis = .vertical
        labelStack.spacing = ProductListConstants.labelStackSpacing
        return labelStack
    }()
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        coffee = nil
    }
    
    private func configureCell() {
        labelStack.addArrangedSubview(titleLabel)
        labelStack.addArrangedSubview(subtitleLabel)
        addSubview(imageView)
        addSubview(labelStack)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        labelStack.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

extension UIImageView {
    
    /// Loads an image from a URL asynchronously
    /// - Parameter url: the `URL` where the image lives
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
