//
//  ProfilViewController.swift
//  AlcoTest
//
//  Created by etudiant-06 on 07/03/2017.
//  Copyright © 2017 mehdi. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - === VARIABLES & CONSTANTES ===
    var user = User()
    @IBOutlet weak var poidsPickerView: UIPickerView!
    var listePoids = [45,50,55,60,65,70,75,80,85,90,95,100,105]
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    //MARK: - FONCTIONS LIEES A LA VUE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.poidsPickerView.delegate = self
        self.poidsPickerView.dataSource = self
    }
    
    // A l'apparition de la Vue
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
        if let index = listePoids.index(of: user.weight) {
            self.poidsPickerView.selectRow( index, inComponent: 0, animated: true)
        }
        
        self.segmentedControl.selectedSegmentIndex = self.user.gender.rawValue
        
    }
    
    // A la disparition de la Vue
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Définition du sexe de l'user selon le choix dans le segmentedControl
        self.segmentedControl.selectedSegmentIndex == 0 ? (self.user.gender = Gender.man) : (self.user.gender = Gender.woman)
        
        // Définition du poids de l'user selon la ligne du pickerView selectionnée
        self.user.weight = listePoids[self.poidsPickerView.selectedRow(inComponent: 0)]
        
        self.user.persistData()
        
        //print("L'user est de type : \(self.user.gender) et pèse \(self.user.weight) ")
    }
    
    //MARK: - FONCTIONS DU PICKER VIEW
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listePoids.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(self.listePoids[row])
    }
    
}
