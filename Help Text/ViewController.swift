//
//  ViewController.swift
//  Help Text
//
//  Created by Omar Al-Ejel on 6/7/17.
//  Copyright © 2017 Omar Al-Ejel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        HelpTextView.present(str:"Warning text!", theme: .Reminder, withFadeDuration: 0.5, persistenceDuration: 2, animated: true)
    }
}

