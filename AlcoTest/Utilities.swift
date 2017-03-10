import Foundation
import UIKit

func simpleAlert(title: String?, message: String?, acceptTitle: String?, myController: UIViewController, completionHandler:(()->Void)? ) {
    let alertController = UIAlertController(title: title != nil ? title! : "Alert", message: message != nil ? message! : "", preferredStyle: .alert)
    
    // Create the action.
    let acceptAction = UIAlertAction(title: acceptTitle != nil ? acceptTitle! : "OK", style: .default) { _ in
        completionHandler?()
        // print("The simple alert's accept action occurred.")
    }
    
    // Add the action.
    alertController.addAction(acceptAction)
    myController.present(alertController, animated: true, completion: nil)
}

extension Double {
    func toFormattedString(_ digits : Int) -> String? {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = digits
        formatter.minimumFractionDigits = digits
        
        if let output = formatter.string(from: NSNumber.init(value:self)) {
            return output
        } else {
            return nil
        }
    }
}

extension NSNumber {
    func toFormattedString(_ digits : Int) -> String? {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = digits
        formatter.minimumFractionDigits = digits
        
        if let output = formatter.string(from: self) {
            return output
        } else {
            return nil
        }
    }
}

func intToString(_ number: Int, digits: Int) -> String? {
    let formatter = NumberFormatter()
    
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = digits
    formatter.minimumFractionDigits = digits
    
    if let output = formatter.string(from: NSNumber.init(value:number)) {
        return output
    } else {
        return nil
    }
}

func numberToString(_ number: NSNumber, digits: Int) -> String? {
    let formatter = NumberFormatter()
    
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = digits
    formatter.minimumFractionDigits = digits
    
    if let output = formatter.string(from: number) {
        return output
    } else {
        return nil
    }
}






