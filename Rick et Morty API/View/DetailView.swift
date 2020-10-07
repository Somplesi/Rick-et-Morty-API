//
//  DetailView.swift
//  Rick et Morty API
//
//  Created by Matthieu PASSEREL on 01/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var persoIV: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var specieLbl: UILabel!
    @IBOutlet weak var originLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    var view: UIView?


    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    
    func loadXib() {
        backgroundColor = .clear
        let bundle = Bundle(for: type(of: self))
        if let xib = type(of: self).description().components(separatedBy: ".").last {
            let nib = UINib(nibName: xib, bundle: bundle)
            if let v = nib.instantiate(withOwner: self, options: nil).first as? UIView {
                view = v
                view?.frame = bounds
                if view != nil {
                    addSubview(view!)
                    view?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                    view?.backgroundColor = .white
                    view?.layer.cornerRadius = 25
                    view?.clipsToBounds = true
                }
            }
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name("close"), object: nil)
    }
    
    func setup(_ personnage: Personnage) {
        persoIV.download(personnage.image)
        persoIV.layer.cornerRadius = persoIV.frame.height / 2
        persoIV.clipsToBounds = true
        nameLbl.text = personnage.name
        locationLbl.text = "Lieu: " + personnage.location.name
        originLbl.text = "Origine: " + personnage.origin.name
        specieLbl.text = "Espèce: " + personnage.species
        genderLbl.text = "Sexe: " + convertirDonneeEnEmoji(string: personnage.gender)
        statusLbl.text = "Statut: " + convertirDonneeEnEmoji(string: personnage.status)
    }
    
    func convertirDonneeEnEmoji(string: String) -> String {
        switch string {
        case "Dead": return "☠️"
        case "Alive": return "😀"
        case "Male": return "🚹"
        case "Female": return "🚺"
        default:  return "🤷‍♂️"
        }
    }
    
}
