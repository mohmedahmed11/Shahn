//
//  ViewController.swift
//  Shahn
//
//  Created by Mohamed Ahmed on 4/9/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sleep(2)
        self.performSegue(withIdentifier: "toHome", sender: nil)
    }


}

