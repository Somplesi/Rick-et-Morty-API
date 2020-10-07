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
    // {"characters":"https://rickandmortyapi.com/api/character","locations":"https://rickandmortyapi.com/api/location","episodes":"https://rickandmortyapi.com/api/episode"}
    
    var urlPersonnages: String {
        return _baseUrl + "character/" // https://rickandmortyapi.com/api/character/
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
    
    func getPersos(_ urlString: String, completion: ApiCompletion?) {
        // Connexion session
        if let url = URL(string: urlString) { // URL ok ?
            // https://rickandmortyapi.com/api/character/
            print("URL: \(urlString)")
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil { // Session ko ?
                    completion?(nil, nil, error!.localizedDescription)
                    print(error!.localizedDescription)
                }
                // Convertir JSON
                if data != nil { // Data ok ?
                    do {
                        //print("Data: \(String(describing: data))")
                        let responseJSON = try JSONDecoder().decode(APIResult.self, from: data!)
                        completion?(responseJSON.info.next, responseJSON.results, nil)
                    } catch {
                        completion?(nil, nil, error.localizedDescription)
                    }
                } else {
                    completion?(nil, nil, "Aucune Data dispo")
                }
//                // S'il y a une Réponse
//                if response != nil {
//                    print("Response: \(String(describing: response))")
//                }
                //            URLSession.shared.dataTask(with: url) { (d, r, e) in
                //                DispatchQueue.main.async {
                //                    if let data = d {
                //                        print("Data: \(data)")
                //                        do {
                //                            let reponseJSON = try JSONDecoder().decode(APIResult.self, from: data)
                //                            //let datas = result.results
                //                            completion?(reponseJSON.info.next, reponseJSON.results, nil)
                //                        } catch {
                //                            completion?(nil, nil, error.localizedDescription)
                //                            print(error.localizedDescription)
                //                        }
                //                    }
                //                    // S'il y a une Réponse
                //                    if let response = r {
                //                        print("Response: \(response)")
                //                    }
                //                    // S'il y a une Erreur
                //                    if let error = e {
                //                        completion?(nil, nil, error.localizedDescription)
                //                        print("Error: \(error.localizedDescription)")
                //                    }
                //                }
            }.resume()
        } else {
            completion?(nil, nil, "Url Invalide")
        }
    }
}
