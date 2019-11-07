//
//  CollectionViewDataSource.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 06/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit
import Models


class CollectionViewDataSource<Model>: NSObject, UICollectionViewDataSource {
    
    typealias CellConfigurator = (UICollectionViewCell, IndexPath) -> Void
    
    var models: [Model]
    
    private let cellConfigurator: CellConfigurator
    private let cellReuseIdentifier: String
    
    init(
        models: [Model],
        cellReuseIdentifier: String,
        cellConfigurator: @escaping CellConfigurator
    ) {
        self.models = models
        self.cellConfigurator = cellConfigurator
        self.cellReuseIdentifier = cellReuseIdentifier
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellReuseIdentifier,
            for: indexPath)
        
        cellConfigurator(cell, indexPath)
        return cell
    }
    
}
