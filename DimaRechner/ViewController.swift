//
//  ViewController.swift
//  DimaRechner
//
//  Created by Tolga Akkiraz on 07.11.17.
//  Copyright © 2017 Tolga Akkiraz. All rights reserved.
//

import UIKit
// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
class ViewController: UIViewController {

    
    @IBOutlet weak var zahl1: UITextField!
    @IBOutlet weak var zahl2: UITextField!
    @IBOutlet weak var operatorSC: UISegmentedControl!
    
    @IBOutlet weak var ergebnisLabel: UILabel!
    
    @IBAction func berechnenButtonPressed(_ sender: Any)
    {
        if ((zahl1.text?.isEmpty)! || (zahl2.text?.isEmpty)!)
        {
            ergebnisLabel.text = "Bitte geben Sie beide Zahlen an !"
            return
        }
        let numberOne = NSString(string: zahl1.text!).doubleValue
        let numberTwo = NSString(string: zahl2.text!).doubleValue
        
        switch operatorSC.selectedSegmentIndex
        {
        case 0: //modulo
            if(numberTwo != 0)
            {
                ergebnisLabel.text = "Ergebnis: \(Int(numberOne) % Int(numberTwo)) mod \(Int(numberTwo))"
            }else
            {
                ergebnisLabel.text = "Modulo 0 ist nicht möglich!"
            }
            break
        case 1: //Stirlingzahl 1. Art
            ergebnisLabel.text = "Ergebnis: \(Stirling_One(n: Int(numberOne), k: Int(numberTwo)))"
            break
        case 2: //Stirlingzahl 2. Art
            ergebnisLabel.text = "Ergebnis: \(Stirling_Two(n: Int(numberOne), k: Int(numberTwo)))"
            break
        case 3: //ungeordnete k-Partitionen von n
            ergebnisLabel.text = "Ergebnis: \(unorderedP(n: Int(numberOne), k: Int(numberTwo)))"
            break
        case 4: //geordnete k-Partitionen von n
            ergebnisLabel.text = "Ergebnis: \(orderedP(n: Int(numberOne), k: Int(numberTwo)))"
            break
        default:
            print("Fehler !")
            break
        }
    }

    //BinomialCoeff
    func binomialCoefficient(_ n: Int, choose k: Int) -> Int {
        var bc = Array(repeating: Array(repeating: 0, count: n + 1), count: n + 1)
        
        for i in 0...n {
            bc[i][0] = 1
            bc[i][i] = 1
        }
        
        if n > 0 {
            for i in 1...n {
                for j in 1..<i {
                    bc[i][j] = bc[i - 1][j - 1] + bc[i - 1][j]
                }
            }
        }
        
        return bc[n][k]
    }
    
    //geordnete k-Partitionen von n
    func orderedP(n: Int, k: Int)->Int
    {
        if(k>n){
            return -1
        }
        let return_value = binomialCoefficient(n-1, choose: k-1)
        return return_value

    }
    //ungeordnete k-Partitionen von n
    func unorderedP( n: Int, k: Int)->Int
    {
        if k>n{
            return 0
        }
        else if (n>0 && k==0){
            return 0
        }
        else if n==k{
            return 1
        }
        let result = unorderedP(n: n-1,k: k-1)+unorderedP(n: n-k,k: k)
        return result
    }
    
    //Stirlingzahl 2. Art
    func Stirling_Two( n: Int, k: Int)->Int
    {   //REKURSIV
//        if k>n{
//            return 0
//        }
//        else if (n>0 && k==0){
//            return 0
//        }
//        else if n==k{
//            return 1
//        }
//        let result = Stirling_Two(n: n-1,k: k-1)+(k)*Stirling_Two(n: n-1,k: k)
//        return result
        
        
        //Iterativ
        let maxj = n-k
        var arr = [Int]()
        
        for i in 0...maxj{
            arr.insert(1, at: i)
        }
        
        for i in 2...k{
            for j in 1...maxj
            {
                arr[j] += i*arr[j-1]
            }
        }
        return arr[maxj]
    }
    //Stirlingzahl 1. Art
    func Stirling_One( n: Int, k: Int)->Int
    {
        if k>n{
        return 0
        }
        else if (n>0 && k==0){
        return 0
        }
        else if n==k{
        return 1
        }
        let result = Stirling_One(n: n-1,k: k-1)+(n-1)*Stirling_One(n: n-1,k: k)
        return result
    }
    
    
    override func viewDidLoad() {
        ergebnisLabel.layer.masksToBounds = true
        ergebnisLabel.layer.cornerRadius = 10
        zahl1.layer.cornerRadius = 5
        zahl2.layer.cornerRadius = 5
        operatorSC.layer.cornerRadius = 5
        
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

