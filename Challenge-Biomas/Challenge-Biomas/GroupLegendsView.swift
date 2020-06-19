//
//  GroupLegends.swift
//  Challenge-Biomas
//
//  Created by Alley Pereira  on 6/18/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

struct Legend {
    let title: String
    let color: UIColor
}


class GroupLegendsView: UIView {
    
    var legendArray: [Legend] = [
        Legend(title: "Amazônia", color: .green),
        Legend(title: "Caatinga", color: .orange),
        Legend(title: "Pantanal", color: .brown),
        Legend(title: "Cerrado", color: .magenta),
        Legend(title: "Pampa", color: .systemPink),
        Legend(title: "Mata Atlântica", color: .yellow)
    ]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(ItemView.self, forCellWithReuseIdentifier: ItemView.identifier)
        
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
    
}

extension GroupLegendsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return legendArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let legendAtual = legendArray[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemView.identifier, for: indexPath) as! ItemView
        cell.circleView.backgroundColor = legendAtual.color
        cell.textLabel.text = legendAtual.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 125, height: 180)
    }
    
}
