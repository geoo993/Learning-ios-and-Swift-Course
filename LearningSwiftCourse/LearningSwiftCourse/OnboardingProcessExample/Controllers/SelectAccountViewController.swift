//
//  SelectAccountViewController.swift
//  OnboardingScreenProcess
//
//  Created by GEORGE QUENTIN on 10/08/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit
import RxSwift

class SelectAccountViewController: UIViewController {

    let didSelectStudent = PublishSubject<String>()
    
    let didSelectAddStudent = PublishSubject<Void>()
    
    var selectedStudent = "George"
    
    @IBAction func nextButtonAction(_ sender : UIButton){
        didSelectStudent.onNext(selectedStudent)
    }
    
    @IBAction func addStudentButtonAction(_ sender : UIButton){
        didSelectAddStudent.onNext(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
