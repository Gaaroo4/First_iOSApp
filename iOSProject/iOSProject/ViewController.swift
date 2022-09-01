//
//  ViewController.swift
//  iOSProject
//
//  Created by Дмитрий Петров on 01.01.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var allMarksField: UITextField!
    @IBOutlet weak var wantMarkField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var minimalMarksField: UITextField!
    @IBOutlet weak var maximumMarksField: UITextField!
    @IBOutlet weak var NeededToGetField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func calcButtonAction(_ sender: Any) {
        let userinput: String = String (allMarksField.text ?? "")
        let array = userinput.split(separator: " ")
        var usermarks: [Double] = []
        let minUserMark: Double = Double(minimalMarksField.text ?? "")!
        let maxUserMark: Double = Double(maximumMarksField.text ?? "")!
        let wantmark: Double = Double(wantMarkField.text ?? "")!
        var errors: Int = 0
        if (minUserMark >= maxUserMark){
            errors += 1
        }
        if ((wantmark > maxUserMark) || (wantmark < minUserMark)){
            errors += 1
        }
        for val in array {
            let number = Double(val) ?? 0
            if ((number <= maxUserMark) && (number >= minUserMark)){
                usermarks.append(number)
                }
            else {
                errors += 1
                }
            }

        
        let targetmark: Double = wantmark - 0.49
        
        
        if (errors == 0){
            resultLabel.text = gettingResult(byUsing: maxUserMark, decreasedItTo: minUserMark, byUsing: usermarks, toReach: targetmark)
            if (resultLabel.text != "У вас достаточно оценок"){
                NeededToGetField.isHidden = false
                view.endEditing(true)
            }
            else {
                NeededToGetField.isHidden = true
                view.endEditing(true)
            }
        
        }
        else {
            resultLabel.text = "Неправильно введены данные"
            NeededToGetField.isHidden = true
            view.endEditing(true)
            
        }
    }
    
    func gettingResult(byUsing maxUserMark: Double, decreasedItTo minUserMark: Double, byUsing usermarks: [Double], toReach targetmark: Double) -> String {
        var maxMark = maxUserMark
        var resultArray: [String] = []
        var resultAnswer: String = ""
        while maxMark > minUserMark && maxMark >= targetmark{
            let count = calculate(neededToAppend: maxMark, in: usermarks, toReach: targetmark)
            if (count > 0){
                resultArray.append ("\(maxMark) - \(count)шт. \n")
                maxMark -= 1
            }
            else {
                resultArray.append ("У вас достаточно оценок")
                break
            }
                
            
            
        }
        for result in resultArray {
            resultAnswer += (result)
        }
        return resultAnswer
    }
    func summ(_ array: [Double]) -> Double {
        var summ: Double = 0
        for mark in array {
            summ += mark
        }
        return summ
    }
    func calculate(neededToAppend maxMark: Double, in array: [Double], toReach targetMark: Double) -> Int{
        var count:Int = 0
        var allmarks = array
        while summ(allmarks) / Double(allmarks.count) < targetMark {
            allmarks.append(maxMark)
            count += 1
        }
        return count
    }
}



    
