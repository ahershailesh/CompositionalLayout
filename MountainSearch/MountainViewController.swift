//
//  MountainViewController.swift
//  PersonnelProject
//
//  Created by Shailesh Aher on 28/12/19.
//  Copyright © 2019 Shailesh Aher. All rights reserved.
//

import UIKit

class MountainViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var datasource : UICollectionViewDiffableDataSource<Int, MountainsController.Mountain>!
    private var controller = MountainsController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        collectionView.register(UINib(nibName: "LabelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: LabelCollectionViewCell.self))
        
        collectionView.collectionViewLayout = configureLayout()
        configureDatasource()
    }


    private func configureLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(80)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }

    private func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource<Int, MountainsController.Mountain>(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LabelCollectionViewCell.self), for: indexPath) as? LabelCollectionViewCell else { fatalError("Cannot create LabelCollectionViewCell") }
            cell.label.text = item.name
            return cell
        })
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Int, MountainsController.Mountain>()
        initialSnapshot.appendSections([1])
        initialSnapshot.appendItems(controller.filteredMountains(), toSection: 1)

        datasource.apply(initialSnapshot, animatingDifferences: true, completion: nil)
    }
}

extension MountainViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchText = searchBar.text else { return }
        
        var initialSnapshot = NSDiffableDataSourceSnapshot<Int, MountainsController.Mountain>()
        initialSnapshot.appendSections([1])
        initialSnapshot.appendItems(controller.filteredMountains(with: searchText), toSection: 1)

        datasource.apply(initialSnapshot, animatingDifferences: true, completion: nil)
    }
}
