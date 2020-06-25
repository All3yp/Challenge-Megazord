//
//  InfoGeraisCell.swift
//  Challenge-Biomas
//
//  Created by Helaine Pontes on 16/06/20.
//  Copyright © 2020 Alley Pereira. All rights reserved.
//

import UIKit

class InfoGeraisCell: UITableViewCell {
    
    static let identifier = "InfoGeraisCell"
    static let xibName = "InfoGeraisXib"
    
    
    @IBOutlet weak var areaViewVerde: UIView!
    @IBOutlet weak var areaViewCinza: UIView!
    @IBOutlet weak var climaViewVerde: UIView!
    @IBOutlet weak var climaViewCinza: UIView!
    @IBOutlet weak var territorioViewVerde: UIView!
    @IBOutlet weak var territorioViewCinza: UIView!
    @IBOutlet weak var paisesViewVerde: UIView!
    @IBOutlet weak var paisesViewCinza: UIView!
    
    
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var climaLabel: UILabel!
    @IBOutlet weak var territorioLabel: UILabel!
    @IBOutlet weak var estadosLabel: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        areaViewVerde.roundCorners(corners: [.topLeft, .topRight], radius: 5)
        areaViewCinza.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 5)
        climaViewVerde.roundCorners(corners: [.topLeft, . topRight], radius: 5)
        climaViewCinza.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 5)
        territorioViewVerde.roundCorners(corners: [.topLeft, . topRight], radius: 5)
        territorioViewCinza.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 5)
        paisesViewVerde.roundCorners(corners: [.topLeft, . topRight], radius: 5)
        paisesViewCinza.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 5)

    }
    
    func configCell(bioma: Bioma){
        areaLabel.text = bioma.area
        climaLabel.text = bioma.clima
        territorioLabel.text = bioma.tNacional
        estadosLabel.text = bioma.estados
    }
}
