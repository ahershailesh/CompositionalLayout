//
//  ViewController.swift
//  PersonnelProject
//
//  Created by Shailesh Aher on 24/12/19.
//  Copyright © 2019 Shailesh Aher. All rights reserved.
//

import UIKit

var tutList = ["Mountain Search", "Distinct Sections"]

class ViewController: UIViewController {

    enum Section {
        case main
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var datasource : UICollectionViewDiffableDataSource<Section, String>!
    private var sectionsLayoutArray : [NSCollectionLayoutSection] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = configureLayout()
        collectionView.delegate = self
        
        configureDatasource()
    }

    func configureLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize:  NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource<Section, String>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, number) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: NumberCollectionViewCell.self), for: indexPath) as? NumberCollectionViewCell else { fatalError("Cannot create NumberCollectionViewCell") }
            
            cell.label.text = number.description
            
            return cell
        })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Section, String>()
        initialSnapshot.appendSections([.main])
        initialSnapshot.appendItems(tutList, toSection: .main)
        
        datasource.apply(initialSnapshot, animatingDifferences: true)
    }
}

extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let controller = MountainViewController(nibName: "MountainViewController", bundle: nil)
            present(controller, animated: true, completion: nil)
        case (0, 1):
            let controller = DictinctSectionsViewController(nibName: "DictinctSectionsViewController", bundle: nil)
            present(controller, animated: true, completion: nil)
        default: break
        }
    }
}
