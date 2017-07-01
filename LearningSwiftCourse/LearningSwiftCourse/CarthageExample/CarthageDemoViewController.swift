//
//  CarthageDemoViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 01/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://www.youtube.com/watch?v=Rjx8b0X3fQc
//https://www.youtube.com/watch?v=jLwx6sDjsIA
//https://github.com/Carthage/Carthage
//https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md
//https://www.raywenderlich.com/109330/carthage-tutorial-getting-started
//https://stackoverflow.com/questions/30612995/how-to-update-just-one-library-from-the-cartfile-with-carthage


/////In the Cartfile we define which dependencies we want from framework in our project.
////Alamofire from https://github.com/Alamofire/Alamofire
///github "Alamofire/Alamofire" ~> 4.4  (this tells carthage to look in Github for this dependency and under the user alimofire, to get repository called AlimoFire and then Git version 4.4)
//// after adding carthage install line in Cartfile, you then do the following in terminal === /*     carthage bootstrap --platform iOS   or    carthage update --platform iOS        */
/////Note: do a "brew install carthage" first, then make sure previous derived dependencies files are deleted and also delete Carthage.resolved before running carthage command in terminal.

/*
 Version requirement
 
 Carthage supports several kinds of version requirements:
 
 >= 1.0 for “at least version 1.0”
 ~> 1.0 for “compatible with version 1.0”
 == 1.0 for “exactly version 1.0”
 "some-branch-or-tag-or-commit" for a specific Git object (anything allowed by git rev-parse). Note: This form of requirement is not supported for binary origins.

 Example Cartfile
 
 # Require version 2.3.1 or later
 github "ReactiveCocoa/ReactiveCocoa" >= 2.3.1
 
 # Require version 1.x
 github "Mantle/Mantle" ~> 1.0    # (1.0 or later, but less than 2.0)
 
 # Require exactly version 0.4.1
 github "jspahrsummers/libextobjc" == 0.4.1
 
 # Use the latest version
 github "jspahrsummers/xcconfigs"
 
 # Use the branch
 github "jspahrsummers/xcconfigs" "branch"
 
 # Use a project from GitHub Enterprise
 github "https://enterprise.local/ghe/desktop/git-error-translations"
 
 # Use a project from any arbitrary server, on the "development" branch
 git "https://enterprise.local/desktop/git-error-translations2.git" "development"
 
 # Use a local project
 git "file:///directory/to/project" "branch"
 
 # A binary only framework
 binary "https://my.domain.com/release/MyFramework.json" ~> 2.3
 

//////// ******* Carthage Syntax done in Cartfile ********* ///////////////
//github "sunshinejr/RxPermission"  =============     normal, and use the latest version
//github "mac-cain13/R.swift.Library" == 3.0.2        ============== Requires exactly version 3.0.2
//github "typelift/Swiftz" "82bf9155"  ======= go to and start from commit number
//github "Khan/SwiftTweaks" "master"    ========= go to and use the master branch
//github "drmohundro/SWXMLHash" ~> 3.0       ========= Require version 3.x (3.0 or later, but less than 4.0)
//github "robb/Cartography" >= 1.0   =========== Require version 1.0 or later
 
*/

import UIKit
import Alamofire

class CarthageDemoViewController: UIViewController {

    @IBAction func homebutton(_ sender: Any) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
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
