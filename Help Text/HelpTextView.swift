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
    
    
    private var _theme: HelpTheme!
    
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
            frame.origin = CGPoint(x: screenBounds.size.width - (pathFrame.size.width + boxOffset), y: screenBounds.size.height - (pathFrame.size.height + boxOffset))
            
            layer.addSublayer(shapeLayer)
            
            label.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
            addSubview(label)
            
//            let coloredBox = UIView(frame: CGRectMake(0,0, 0, 0))
//            coloredBox.backgroundColor = .yellow
//            coloredBox.layer.
        }
    }
    
    init(theme t: HelpTheme) {
        super.init(frame: CGRect.zero)
        setTheme(theme: t)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setTheme(theme: .Detail)
    }
    
    func show(withFadeDuration fadeDuration: TimeInterval, persistenceDuration: TimeInterval, animated: Bool) {
        if animated {
            UIView.animate(withDuration: fadeDuration, delay: 0, options: .curveLinear, animations: {
                self.alpha = 1
                self.isVisible = true
            }, completion: { (done) in
                UIView.animate(withDuration: fadeDuration, delay: persistenceDuration, options: .curveLinear, animations: {
                    self.alpha = 0
                    self.isVisible = false
                }, completion: { (done) in
                    
                })
            })
        } else {
            self.alpha = 1
            self.layer.removeAllAnimations()
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
            fillColor = UIColor(red: 1, green: 0.89, blue: 0.5333, alpha: 1)
            strokeColor = UIColor(red: 1, green: 0.4862, blue: 0, alpha: 1)
        case .Warning:
            fillColor = UIColor(red: 0.996, green: 0.7411, blue: 0.6666, alpha: 1)
            strokeColor = UIColor(red: 0.898, green: 0.1216, blue: 0, alpha: 1)
        case .Detail:
            fillColor = UIColor.white
            strokeColor = UIColor.darkGray
        case .Progress:
            fillColor = UIColor(red: 0.6196, green: 0.996, blue: 0.6745, alpha: 1)
            strokeColor = UIColor(red: 0, green: 0.5804, blue: 0, alpha: 1)
        case let .Custom(s, f):
            fillColor = f
            strokeColor = s
        }

    }
}
