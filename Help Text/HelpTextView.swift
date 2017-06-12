//
//  HelpTextView.swift
//  Help Text
//
//  Created by Omar Al-Ejel on 6/7/17.
//  Copyright © 2017 Omar Al-Ejel. All rights reserved.
//

import UIKit

enum HelpTheme {
    case Reminder, Warning, Detail, Progress, Custom(stroke: UIColor, fill: UIColor)
}

class HelpTextView: UIView {
    
    let cornerRadius: CGFloat = 5
    let textInset = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
    let boxOffset: CGFloat = 8
    var label: UILabel!
    let screenBounds = UIScreen.main.bounds
    var isVisible = false
        
    private var fillColor: UIColor!
    private var strokeColor: UIColor!
    
    var str = "" {
        didSet {
            if let x = label {x.removeFromSuperview();}
            label = UILabel()
            label.font = UIFont(name: "SF-UI", size: 6)
            label.text = str
            label.textColor = strokeColor
            label.sizeToFit()
            
            let pathFrame = CGRect(x:0,y:0,width:label.frame.size.width + (2 * textInset.right), height:label.frame.size.height + (2 * textInset.top))
            let layerPath = UIBezierPath(roundedRect: pathFrame, cornerRadius: cornerRadius)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = layerPath.cgPath
            shapeLayer.fillColor = fillColor.cgColor
            shapeLayer.strokeColor = strokeColor.cgColor
            shapeLayer.lineWidth = 2
            
            frame = pathFrame
            
            let horizontalSize = UIDevice.current.orientation.isPortrait ? screenBounds.size.width : screenBounds.size.height
            let verticalSize = UIDevice.current.orientation.isPortrait ? screenBounds.size.height : screenBounds.size.width
            
            frame.origin = CGPoint(x: horizontalSize - (pathFrame.size.width + boxOffset), y: verticalSize - (pathFrame.size.height + boxOffset))
            
            layer.addSublayer(shapeLayer)
            
            label.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
            addSubview(label)
        }
    }
    
    public class var sharedInstance: HelpTextView {
        struct Singleton {
            static let instance = HelpTextView(theme: .Detail)
        }
        return Singleton.instance
    }
    
    private init(theme t: HelpTheme) {
        super.init(frame: CGRect.zero)
        setTheme(theme: t)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setTheme(theme: .Detail)
    }
    
    //adapted from swiftspinner
    private static weak var customSuperview: UIView? = nil
    private static func cView() -> UIView? {
        return customSuperview ?? UIApplication.shared.keyWindow
    }
    public class func useContainerView(_ sv: UIView?) {
        customSuperview = sv
    }
    
    public class func present(str: String, theme t: HelpTheme, withFadeDuration fadeDuration: TimeInterval, persistenceDuration: TimeInterval, animated: Bool) {
        
        let textView = HelpTextView.sharedInstance
        textView.setTheme(theme: t)
        textView.str = str
        
        textView.alpha = 0
        
        if textView.superview == nil {
            guard let containerView = cView() else {
                fatalError("No key window or given view")
            }
            
            containerView.addSubview(textView)
            
            if animated {
                UIView.animate(withDuration: fadeDuration, delay: 0, options: .curveLinear, animations: {
                    textView.alpha = 1
                    textView.isVisible = true
                }, completion: { (done) in
                    UIView.animate(withDuration: fadeDuration, delay: persistenceDuration, options: .curveLinear, animations: {
                        textView.alpha = 0
                        textView.isVisible = false
                    }, completion: { (done) in
                        textView.removeFromSuperview()
                    })
                })
            } else {
                textView.alpha = 1
            }
        }
    }

    func hide(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.5, animations: { 
                self.alpha = 0
            })
        } else {
            self.alpha = 0
        }
    }
    
    func setTheme(theme: HelpTheme) {
            switch theme {
            case .Reminder:
                self.fillColor = UIColor(red: 1, green: 0.89, blue: 0.5333, alpha: 1)
                self.strokeColor = UIColor(red: 1, green: 0.4862, blue: 0, alpha: 1)
            case .Warning:
                self.fillColor = UIColor(red: 0.996, green: 0.7411, blue: 0.6666, alpha: 1)
                self.strokeColor = UIColor(red: 0.898, green: 0.1216, blue: 0, alpha: 1)
            case .Detail:
                self.fillColor = UIColor.white
                self.strokeColor = UIColor.darkGray
            case .Progress:
                self.fillColor = UIColor(red: 0.6196, green: 0.996, blue: 0.6745, alpha: 1)
                self.strokeColor = UIColor(red: 0, green: 0.5804, blue: 0, alpha: 1)
            case let .Custom(s, f):
                self.fillColor = f
                self.strokeColor = s
        }
    }
}
