//
//  PersoCell.swift
//  Rick et Morty API
//
//  Created by Rodolphe DUPUY on 07/10/2020.
//  Copyright © 2020 Rodolphe DUPUY. All rights reserved.
//

import UIKit

class PersoCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var persoIV: UIImageView!
    
    var perso: Personnage!
    
    func setupCell(_ perso: Personnage) {
        self.perso = perso
        self.nameLbl.text = self.perso.name
        self.persoIV.download(self.perso.image)
        holderView.layer.cornerRadius = 25
        holderView.clipsToBounds = true
        
    }
}
