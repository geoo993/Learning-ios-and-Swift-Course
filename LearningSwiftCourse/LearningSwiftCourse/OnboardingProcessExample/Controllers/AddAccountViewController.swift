//
//  AddAccountViewController.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 16/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AddAccountViewController: UIViewController {

    let didAddStudent = PublishSubject<Void>()
    
    @IBOutlet weak var nameTextField : UITextField!
    @IBOutlet weak var ageTextField : UITextField!
    
    @IBAction func addButtonAction(_ sender : UIButton){
        didAddStudent.onNext(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
