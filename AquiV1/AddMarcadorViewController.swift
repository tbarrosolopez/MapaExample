//
//  AddMarcadorViewController.swift
//  AquiV1
//
//  Created by Tania Barroso López  on 9/27/18.
//  Copyright © 2018 Tania Barroso López . All rights reserved.
//

import UIKit
import SKMaps
class AddMarcadorViewController: UIViewController {

    @IBOutlet var nombre: UITextField!

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   
    @IBAction func AddMarcador(_ sender: UIButton) {
        
        let name: String = nombre.text!
        let marcadorData:[String: String] = ["name": name]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addMarcador"), object: nil, userInfo: marcadorData)
        
        
        self.dismiss(animated: true) {
            self.viewDidDisappear(true)
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Notification.Name{
    static let addMarcador = Notification.Name("addMarcador")
}
