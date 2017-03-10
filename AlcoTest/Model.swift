//
//  Model.swift
//  alcotest
//
//  Created by Nicolas on 27/01/2016.
//  Copyright © 2016 nicolas. All rights reserved.
//

import Foundation

// Paramètres pour toute l'application
let maxAlcooholRate = 0.8 // taux max d'alcool autorisé
let firstAlcooholRate = 0.5 // taux à partir duquel la jauge devient orange

struct Drink {
    var name: String
    let alcooholRate: Double
    let glassSize: Double
}

enum Gender: Int {
    case man = 0
    case woman = 1
}

class User {
    var weight: Int
    var nbOfGlasses = [Int]()
    var gender: Gender
    
    /* init simple, remplacé par un constructeur qui tient compte du stockage
     init (gender : Gender, weight : Int, numberOfDrinks: Int) {
     self.weight = weight
     self.gender = gender
     }
     */
    
    init() {
        // si une valeur a été stockée dans les UserDefaults, on prend celle là plutôt que celle fournie dans le constructeur
        
        let myWeight = UserDefaults.standard.integer(forKey: "weight")
        if  myWeight != 0 {
            self.weight = myWeight
        } else {
            self.weight = 70
        }
        
        let myGender = UserDefaults.standard.integer(forKey: "gender")
        if  (myGender == 0 || myGender == 1) {
            self.gender = Gender(rawValue: myGender)!
        } else {
            self.gender = .man
        }
    }
    
    // Calcul du taux d'alcoolemie
    func computeAlcooholRate (drinks: [Drink]) -> Double {
        var output = 0.0
        
        let ratio = (self.gender == .man ? 0.7 : 0.6)
        
        for (index, drink) in drinks.enumerated() {
            output += (Double(self.nbOfGlasses[index]) * drink.glassSize * drink.alcooholRate * 0.8)
                / (Double(self.weight) * ratio )
        }
        return output
    }
    
    
    // stockage des données dans les NSUserDefaults
    func persistData() {
        UserDefaults.standard.set(self.weight, forKey: "weight")
        UserDefaults.standard.set(self.gender.rawValue, forKey: "gender")
        // force la sauvegarde. Pas obligatoire
        UserDefaults.standard.synchronize()
        
    }
}



