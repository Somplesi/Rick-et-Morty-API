//
//  UserDefaultsHelper.swift
//  Rick et Morty API
//
//  Created by Matthieu PASSEREL on 01/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import Foundation

class UserDefaultsHelper {
    
    private var _defaults = UserDefaults.standard
    private var _statusKey = "status"
    private var _nameKey = "name"
    
    func setName(string: String?) {
        guard let str = string else { return }
        _defaults.set(str, forKey: _nameKey)
        _defaults.synchronize()
    }
    
    func getName() -> String  {
       return _defaults.string(forKey: _nameKey) ?? ""
    }
    
    func setStatus(bool: Bool) {
        _defaults.set(bool, forKey: _statusKey)
        _defaults.synchronize()
    }
    
    func getStatus() -> Bool {
        return _defaults.bool(forKey: _statusKey)
    }
    
    func getStatusString() -> String {
        let status  = _defaults.bool(forKey: _statusKey)
        if status {
            return "Vivant"
        } else {
            return "Mort"
        }
    }
    
    
}
