//
//  APIHelper.swift
//  Rick et Morty API
//
//  Created by Rodolphe DUPUY on 07/10/2020.
//  Copyright © 2020 Rodolphe DUPUY. All rights reserved.
//

import Foundation

typealias ApiCompletion = (_ next: String?, _ personnages: [Personnage]?, _ errorString: String?) -> Void

class APIHelper {
    
    private let _baseUrl = "https://rickandmortyapi.com/api/"
    
    var urlPersonnages: String {
        return _baseUrl + "character/"
    }
    
    func urlAvecParam() -> String {
        var base = urlPersonnages + "?"
        if UserDefaultsHelper().getName() != "" {
            base += "name=" + UserDefaultsHelper().getName() + "&"
        }
        let st = UserDefaultsHelper().getStatus() ? "alive" : "dead"
        base += "status=" + st
        return base
    }
    
    func getPersos(_ string: String, completion: ApiCompletion?) {
        if let url = URL(string: string) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion?(nil, nil, error!.localizedDescription)
                }
                
                if data != nil {
                    do {
                        let reponseJSON = try JSONDecoder().decode(APIResult.self, from: data!)
                        completion?(reponseJSON.info.next, reponseJSON.results, nil)
                    } catch {
                        completion?(nil, nil, error.localizedDescription)
                    }
                } else {
                    completion?(nil, nil, "Aucune Data dispo")
                }
            }.resume()
        } else {
            completion?(nil, nil, "Url Invalide")
        }
    }
}
