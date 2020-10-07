//
//  APIResult.swift
//  Rick et Morty API
//
//  Created by Rodolphe DUPUY on 07/10/2020.
//  Copyright © 2020 Rodolphe DUPUY. All rights reserved.
//

import Foundation

struct APIResult: Decodable {
    var info: Info
    var results: [Personnage]
}

struct Info: Decodable {
    var count: Int
    var pages: Int
    var next: String
    var prev: String?
}

struct Personnage: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: Origin
    var location: Location
    var image: String
    var episode: [String]
    var url: String
    var created: String
}

struct Origin: Decodable {
    var name: String
    var url: String
}

struct Location: Decodable {
    var name: String
    var url: String
}

// https://rickandmortyapi.com/api/character/
/*
 {
   "info": {
     "count": 591,
     "pages": 20,
     "next": "https://rickandmortyapi.com/api/character/?page=2",
     "prev": null
   },
   "results": [
     {
       "id": 1,
       "name": "Rick Sanchez",
       "status": "Alive",
       "species": "Human",
       "type": "",
       "gender": "Male",
       "origin": {
         "name": "Earth",
         "url": "https://rickandmortyapi.com/api/location/1"
       },
       "location": {
         "name": "Earth",
         "url": "https://rickandmortyapi.com/api/location/20"
       },
       "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
       "episode": [
         "https://rickandmortyapi.com/api/episode/1",
         "https://rickandmortyapi.com/api/episode/2",
         // ...
       ],
       "url": "https://rickandmortyapi.com/api/character/1",
       "created": "2017-11-04T18:48:46.250Z"
     },
     // ...
   ]
 }
 */

