//
//  ViewController.swift
//  Help Text
//
//  Created by Omar Al-Ejel on 6/7/17.
//  Copyright © 2017 Omar Al-Ejel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var htv = HelpTextView(theme: .Reminder)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }

    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        htv.alpha = 0
        view.addSubview(htv)
        htv.str = "This is a warning sign"
        htv.show(withFadeDuration: 0.5, persistenceDuration: 2, animated: !htv.isVisible)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

