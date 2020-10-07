//
//  ViewController.swift
//  Rick et Morty API
//
//  Created by Matthieu PASSEREL on 01/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit


enum TypeQuery {
    case all
    case query
}

class CharactersController: UIViewController {
    
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var detailView: DetailView!
    
    
    var pageSuivante = ""
    var personnages: [Personnage] = []
    
    var pageSuivanteQuery = ""
    var personnagesQuery: [Personnage] = []
    
    var cellImageFram = CGRect()
    var detailImageFrame = CGRect()
    var imageDeTransition = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        getPerso(string: APIHelper().urlPersonnages, type: .all)
        detailView.alpha = 0
        NotificationCenter.default.addObserver(self, selector: #selector(animateOut), name: Notification.Name("close"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageSuivanteQuery = ""
        personnagesQuery = []
        getPerso(string: APIHelper().urlAvecParam(), type: .query)
    }
    
    func animateIn(personnage: Personnage) {
        detailImageFrame =  detailView.persoIV.convert(detailView.persoIV.bounds, to: view)
        detailView.setup(personnage)
        
        imageDeTransition = UIImageView(frame: cellImageFram)
        imageDeTransition.download(personnage.image)
        imageDeTransition.layer.cornerRadius = 25
        imageDeTransition.contentMode = .scaleAspectFill
        imageDeTransition.clipsToBounds = true
        view.addSubview(imageDeTransition)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.imageDeTransition.frame = self.detailImageFrame
            self.imageDeTransition.layer.cornerRadius = self.detailImageFrame.height / 2
            self.collectionView.alpha = 0
        }) { (success) in
            self.detailView.alpha = 1
        }
    }
    
    @objc func animateOut() {
        UIView.animate(withDuration: 0.5, animations: {
            self.imageDeTransition.frame = self.cellImageFram
            self.imageDeTransition.layer.cornerRadius = 25
            self.collectionView.alpha = 1
            self.detailView.alpha = 0
        }) { (success) in
            self.imageDeTransition.removeFromSuperview()
        }
    }
    
    func getPerso(string: String, type: TypeQuery) {
        APIHelper().getPersos(string) { (pageSuivante, listePersos, erreurString) in
            if pageSuivante != nil {
                switch type {
                case .all: self.pageSuivante = pageSuivante!
                case .query: self.pageSuivanteQuery = pageSuivante!
                }
            }
            
            if erreurString != nil {
                print(erreurString!)
            }
            
            if listePersos != nil {
                switch type {
                case .all: self.personnages.append(contentsOf: listePersos!)
                case .query: self.personnagesQuery.append(contentsOf: listePersos!)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
    
    
}


extension CharactersController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segmented.selectedSegmentIndex == 0 {
            return personnages.count
        }
        return personnagesQuery.count
    }
    
    //Optionnelle surtout si 1 Section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let personnage =  segmented.selectedSegmentIndex == 0 ? personnages[indexPath.item]  : personnagesQuery[indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PersoCell", for: indexPath) as? PersoCell {
            cell.setupCell(personnage)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let taille = collectionView.frame.width / 2 - 20
        return CGSize(width: taille, height: taille)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = segmented.selectedSegmentIndex == 0 ? personnages.count : personnagesQuery.count
        if indexPath.item == count - 1 {
            if segmented.selectedSegmentIndex == 0 && pageSuivante != "" {
                getPerso(string: pageSuivante, type: .all)
            }
            if segmented.selectedSegmentIndex == 1 && pageSuivanteQuery != "" {
                getPerso(string: pageSuivanteQuery, type: .query)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let layout = collectionView.layoutAttributesForItem(at: indexPath) else { return }
        let frame = collectionView.convert(layout.frame, to: collectionView.superview)
        cellImageFram = CGRect(x: frame.minX, y: frame.minY + 50, width: frame.width, height: frame.height - 50)
        
        switch segmented.selectedSegmentIndex {
        case 0: animateIn(personnage: personnages[indexPath.item])
        case 1: animateIn(personnage: personnagesQuery[indexPath.item])
        default: break
        }
        
    }
    
    
}

