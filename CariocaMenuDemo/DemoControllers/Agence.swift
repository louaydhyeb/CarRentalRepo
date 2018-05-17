//
//  Agence.swift
//  CariocaMenuDemo
//
//  Created by Admin on 30/04/2018.
//  Copyright © 2018 CariocaMenu. All rights reserved.
//

import Foundation


class Agence {
    
    var idAgence: String?
    var nameAgence: String?
    var emailAgence: String?
    var phoneAgence: String?
    var photoAgence: String?
    
    init(idAgence: String?, nameAgence: String?,emailAgence : String?,phoneAgence: String?, photoAgence: String?) {
        self.idAgence = idAgence
        self.nameAgence = nameAgence
        self.emailAgence = emailAgence
        self.phoneAgence = phoneAgence
        self.photoAgence = photoAgence
        
    }
}
