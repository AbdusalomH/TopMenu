// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public protocol ButtonCollectionDelegate: AnyObject {
    func didTapButton(withTitle Title: String)
}

public class TopMenu: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, @preconcurrency ButtonCollectionDelegate {
    
    
    private var buttonTitle: [String]
    private var buttonsBackgroundColor: UIColor
    private var buttonTextColors: UIColor
    private var controllers: [String: UIViewController]
    
    
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 150, height: 50)
        flowLayout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(ButtonCollectionCell.self, forCellWithReuseIdentifier: ButtonCollectionCell.reuseID)
        collection.showsHorizontalScrollIndicator = false
        return collection
        
    }()
    
    private var customcontainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    public init(buttonTitle: [String], buttonsBackgroundColor: UIColor = .systemBlue, buttonTextColors: UIColor = .white, controller: [String: UIViewController] ) {
        self.buttonTitle = buttonTitle
        self.buttonsBackgroundColor = buttonsBackgroundColor
        self.buttonTextColors = buttonTextColors
        self.controllers = controller
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(customcontainerView)
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collectionView.heightAnchor.constraint(equalToConstant: 70),
            
            customcontainerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            customcontainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customcontainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customcontainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitle.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCollectionCell.reuseID, for: indexPath) as! ButtonCollectionCell
        cell.configure(with: buttonTitle[indexPath.row], background: buttonsBackgroundColor, textColor: buttonTextColors)
        cell.delegate = self
        return cell
    }
    
    
    public func didTapButton(withTitle Title: String) {
        displayContent(title: Title)
    }
    
    
    
    private func displayContent(title: String) {
        
        if let currentChild = children.first {
            currentChild.willMove(toParent: nil)
            currentChild.view.removeFromSuperview()
            currentChild.removeFromParent()
        }
        
        if let controller = controllers[title] {
            addChild(controller)
            customcontainerView.addSubview(controller.view)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                controller.view.topAnchor.constraint(equalTo: customcontainerView.topAnchor),
                controller.view.leadingAnchor.constraint(equalTo: customcontainerView.leadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: customcontainerView.trailingAnchor),
                controller.view.bottomAnchor.constraint(equalTo: customcontainerView.bottomAnchor)
            ])
            controller.didMove(toParent: self)
        }
    }
}
