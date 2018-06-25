//
//  AlertManager.swift
//  MyLedger
//
//  Created by Moin Uddin on 11/30/14.
//  Copyright (c) 2014 Moin Uddin. All rights reserved.
//

import UIKit

class AlertManager: NSObject, UIAlertViewDelegate {
    
    convenience init(viewController: UIViewController? = nil, title: String? = nil, message: String? = nil, buttonNames: Array<String>? = nil, textFields: Array<UITextField>? = nil, tintColor: UIColor? = nil, completion: ((_ index: Int, _ textFields: [UITextField]?) -> Void)? = nil) {
        self.init()
        let alertTitle1 = (title == nil || title!.isEmpty) ? "Alert" : title!;
        let alertMsg = (message == nil || message!.isEmpty) ? alertTitle1 : message!;
        
        let alertController: UIAlertController = UIAlertController(title: alertTitle1, message: alertMsg, preferredStyle: UIAlertControllerStyle.alert)
        
        if buttonNames == nil{
            alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: { (action: UIAlertAction!) -> Void in
                if completion != nil{
                    completion!(0, alertController.textFields)
                }
            }));
        }else{
            var actionStyle: UIAlertActionStyle = UIAlertActionStyle.default
            for (index,name) in buttonNames!.enumerated(){
                if buttonNames!.count - 1 == index{
                    actionStyle = UIAlertActionStyle.cancel
                }
                //DVPrint(actionStyle.rawValue)
                alertController.addAction(UIAlertAction(title: name, style: actionStyle, handler: { (action: UIAlertAction!) -> Void in
                    if completion != nil{
                        completion!(index, alertController.textFields)
                    }
                }))
            }
        }
        
        if textFields != nil{
            for textfield in textFields!{
                alertController.addTextField(configurationHandler: { (textField: UITextField) -> Void in
                    textField.font = textfield.font
                    textField.textColor = textfield.textColor
                    textField.placeholder = textfield.placeholder
                    textField.text = textfield.text
                    
                    if let sublayers = textfield.layer.sublayers{
                        for sublayer in sublayers{
                            textField.layer.addSublayer(sublayer)
                        }
                    }
                })
            }
        }
        
        if tintColor != nil{
            alertController.view.tintColor = tintColor!
        }
        if viewController != nil{
            viewController?.present(alertController, animated: true, completion: nil)
        }else{
            if let vc: UIViewController = UIApplication.shared.keyWindow?.rootViewController{
                vc.present(alertController, animated: true, completion: nil)
            }else{
                let vc: UIViewController = UIViewController()
                UIApplication.shared.keyWindow?.rootViewController = vc
                DispatchQueue.main.async {
                    vc.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    // MARK: - custom alert function
    class func showAlert(_ viewController: UIViewController,title: String? = nil, message: String? = nil, buttonNames: Array<String>? = nil, textFields: Array<UITextField>? = nil, completion: ((_ index: Int, _ textFields: [UITextField]?) -> Void)? = nil) -> AlertManager{
        return AlertManager(viewController: viewController, title: title, message: message, buttonNames: buttonNames, textFields: textFields, tintColor: nil, completion: completion)
    }
    
    // MARK: - custom alert function
    class func showAlertWithTint(_ viewController: UIViewController,title: String? = nil, message: String? = nil, buttonNames: Array<String>? = nil, textFields: [UITextField]? = nil, tintColor: UIColor? = nil, completion: ((_ index: Int, _ textFields: Array<UITextField>?) -> Void)? = nil) -> AlertManager{
        return AlertManager(viewController: viewController, title: title, message: message, buttonNames: buttonNames, textFields: textFields, tintColor: tintColor, completion: completion)
    }
}
