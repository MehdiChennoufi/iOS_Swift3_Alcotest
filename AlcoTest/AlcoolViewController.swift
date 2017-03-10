//
//  AlcoViewController.swift
//  AlcoTest
//
//  Created by etudiant-06 on 07/03/2017.
//  Copyright © 2017 mehdi. All rights reserved.
//

import UIKit

class AlcoolViewController: UIViewController {
    
    //MARK: === VARIABLES ET CONSTANTES ===
    
    //MARK: - Boutons Biere
    @IBOutlet weak var beerButton: UIButton!
    @IBOutlet weak var beerLabel: UILabel!
    @IBOutlet weak var beerButtonMinus: UIButton!
    
    //MARK: - Boutons Vin
    @IBOutlet weak var vineButton: UIButton!
    @IBOutlet weak var vineLabel: UILabel!
    @IBOutlet weak var vineButtonMinus: UIButton!
    
    //MARK: - Boutons Whisky
    @IBOutlet weak var whiskyButton: UIButton!
    @IBOutlet weak var whiskyLabel: UILabel!
    @IBOutlet weak var whiskyButtonMinus: UIButton!
    
    //MARK: - Boutons Porto
    @IBOutlet weak var portoButton: UIButton!
    @IBOutlet weak var portoLabel: UILabel!
    @IBOutlet weak var portoButtonMinus: UIButton!
    
    //MARK: - Autres Elements
    @IBOutlet weak var tauxLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var profilUserLabel: UILabel!
    
    var user = User()
    var drinks = [Drink]()
    
    //MARK: === FONCTIONS LIEES A LA VUE ===
    
    // Au chargement de l'app
    override func viewDidLoad() {
        
        user.nbOfGlasses = [0,0,0,0]
        
        drinks.append(Drink(name: "Bière", alcooholRate: 0.04, glassSize: 330))
        drinks.append(Drink(name: "Vin", alcooholRate: 0.12, glassSize: 120))
        drinks.append(Drink(name: "Whisky", alcooholRate: 0.40, glassSize: 50))
        drinks.append(Drink(name: "Porto", alcooholRate: 0.18, glassSize: 80))
        
        // Initialisation des variables à 0 au lancement du programme
        tauxLabel.text = "0,0"
        progressBar.setProgress(0.0, animated: true)
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // A l'apparition de la Vue
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        // Poids
        let newWeight = UserDefaults.standard.integer(forKey: "weight")
        if user.weight != newWeight {
            user.weight = newWeight
        }
        // Sexe
        let newGender = UserDefaults.standard.integer(forKey: "gender")
        if user.gender.rawValue != newGender {
            user.gender = Gender(rawValue: newGender)!
        }
        
        updateDisplay()
        
    }

    
    //MARK: === FONCTIONS POUR LA PICKER VIEW ===
    
    // Le nombre de "component" à afficher ("date", "heures", "minutes" par exemple)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Ajout d'une consommation
    @IBAction func drinkPressed(_ sender: UIButton) {
        user.nbOfGlasses[sender.tag] += 1
        updateDisplay()
    }
    
    // Supression d'une consommation
    @IBAction func removePressed(_ sender: UIButton) {
        if user.nbOfGlasses[sender.tag] > 0 {
            user.nbOfGlasses[sender.tag] -= 1
            updateDisplay()
        }
    }
    
    // Préparation à la transition vers la page de profil
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToAbout" {
            if let destinationVC = segue.destination as? ProfilViewController {
                destinationVC.user = self.user
            }
        }
    }
    
    // Transition vers la page de Profil
    @IBAction func profilButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "homeToProfileSegue", sender: self)
    }
    
    // Transition vers la page d'About
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "homeToAboutSegue", sender: self)
    }
    
    // Update de l'affichage en fonction du calcul de la consomation
    func updateDisplay() {
        beerLabel.text = "\(user.nbOfGlasses[0])"
        vineLabel.text = "\(user.nbOfGlasses[1])"
        whiskyLabel.text = "\(user.nbOfGlasses[2])"
        portoLabel.text = "\(user.nbOfGlasses[3])"
        
        
        let rate = user.computeAlcooholRate(drinks: self.drinks)
        
        progressBar.tintColor = UIColor.blue
        tauxLabel.textColor = UIColor.black
        
        // Autre méthode pour formatter le texte à l'arrondi
        tauxLabel.text = String(format: "%0.2f", rate) + " g/l"
        
        let remplissageDeLaBar = rate / maxAlcooholRate
        
        if remplissageDeLaBar > firstAlcooholRate {
            progressBar.tintColor = UIColor.orange
            tauxLabel.textColor = UIColor.orange
        }
        
        if remplissageDeLaBar >= 1 {
            progressBar.tintColor = UIColor.red
            tauxLabel.textColor = UIColor.red
        }
        
        progressBar.setProgress(Float(remplissageDeLaBar), animated: true)
        
        // Remplissage du label du Profil
        if self.profilUserLabel.text != nil {
            profilUserLabel.text = "Votre profil : \(user.gender.rawValue == 0 ? "Homme" : "Femme") de \(user.weight) Kg"
        }
        
    }
    
    // Fonction pour la remise à zéros des verres
    @IBAction func resetButton() {
        for index in 0...3 {
            user.nbOfGlasses[index] = 0
        }
        updateDisplay()
    }
    
    
    
}
