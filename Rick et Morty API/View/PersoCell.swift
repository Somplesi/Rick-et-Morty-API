//
//  PersoCell.swift
//  Rick et Morty API
//
//  Created by Matthieu PASSEREL on 01/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
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
