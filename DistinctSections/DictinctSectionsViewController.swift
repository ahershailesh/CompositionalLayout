//
//  DictinctSectionsViewController.swift
//  PersonnelProject
//
//  Created by Shailesh Aher on 28/12/19.
//  Copyright © 2019 Shailesh Aher. All rights reserved.
//

import UIKit

class DictinctSectionsViewController: UIViewController {
    
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var datasource : UICollectionViewDiffableDataSource<Int, Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "LabelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: LabelCollectionViewCell.self))
        
        collectionView.collectionViewLayout = configureLayout()
        configureDatasource()
    }
    
    private func configureLayout() -> UICollectionViewCompositionalLayout {

        return UICollectionViewCompositionalLayout { (section, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1.0)))
            
            let columns = layoutEnvironment.container.contentSize.width > 800 ?  (section + 1) * 2 : section + 1
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2)), subitem: item, count: columns)
            return NSCollectionLayoutSection(group: group)
            
        }
    }

    private func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
             guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LabelCollectionViewCell.self), for: indexPath) as? LabelCollectionViewCell else { fatalError("Cannot create LabelCollectionViewCell") }
            cell.label.text = item.description
             return cell
        })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        initialSnapshot.appendSections([1, 2, 3, 4])
        initialSnapshot.appendItems(Array(1...10), toSection: 1)
        initialSnapshot.appendItems(Array(11...20), toSection: 2)
        initialSnapshot.appendItems(Array(21...30), toSection: 3)
        initialSnapshot.appendItems(Array(31...40), toSection: 4)
        datasource.apply(initialSnapshot, animatingDifferences: true, completion: nil)
    }
}
