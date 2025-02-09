//
//  ButtonCollectionCell.swift
//  TopMenu
//
//  Created by Abdusalom on 09/02/2025.
//

import UIKit


public class ButtonCollectionCell: UICollectionViewCell {
    
    public static let reuseID = "ButtonCollectionCell"
    public weak var delegate: ButtonCollectionDelegate?
    
    
    public lazy var customButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        contentView.addSubview(customButton)
        
        NSLayoutConstraint.activate([
            customButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            customButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            customButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            customButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    @objc func buttonTapped() {
        if let title = customButton.title(for: .normal) {
            delegate?.didTapButton(withTitle: title)
        }
    }
    
    public func configure(with Title: String, background: UIColor, textColor: UIColor) {
        customButton.setTitle(Title, for: .normal)
        customButton.backgroundColor = background
        customButton.setTitleColor(textColor, for: .normal)
    }
    
    
}
