//
//  NavigationController.swift
//  UsingCompass
//
//  Created by GEORGE QUENTIN on 04/09/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

// https://github.com/hyperoslo/Compass
// https://pugpig.zendesk.com/hc/en-us/articles/204772365-How-To-Set-A-Custom-URL-Scheme

import UIKit
import Compass
import LearningSwiftCourseExtensions

struct LoginRoute: Routable {
    let loginController = UIStoryboard(name: "CompassMain", bundle: nil).instantiateViewController(withIdentifier: "CompassLoginViewController")
    
    func navigate(to location: Location, from currentController: CurrentController) throws {
        guard let username = location.arguments["username"] else { return }
        
        //let loginController = CompassLoginViewController(title: arguments["username"])
        loginController.title = username
        
        //currentController.navigationController?.pushViewController(loginController, animated: true)
        currentController.navigationController?.pushOrPop(to: loginController)
        //currentController.pushOrPop(to:loginController)
        
    }
}

struct HomeRoute: Routable {
    let rootviewcontroller = UIStoryboard(name: "CompassMain", bundle: nil).instantiateViewController(withIdentifier: "CompassRootViewController") 
    
    func navigate(to location: Location, from currentController: CurrentController) throws {
        guard let username = location.arguments["title"] else { return }
        
        //let rootviewcontroller = CompassRootViewController(title: arguments["title"])
        rootviewcontroller.title = username
        
        //currentController.navigationController?.pushViewController(rootviewcontroller, animated: true)
        currentController.navigationController?.pushOrPop(to: rootviewcontroller)
        //currentController.pushOrPop(to:rootviewcontroller)
    }
}

struct ProfileRoute: Routable {
   
    let profileController = UIStoryboard(name: "CompassMain", bundle: nil).instantiateViewController(withIdentifier: "CompassProfileViewController")
   
    
    func navigate(to location: Location, from currentController: CurrentController) throws {
        guard let username = location.arguments["username"] else { return }
        
        //let profileController = CompassProfileViewController(title: username)
        profileController.title = username
        //currentController.navigationController?.pushViewController(profileController, animated: true)
        
        currentController.navigationController?.pushOrPop(to:profileController)
        //currentController.pushOrPop(to:profileController)
        
    }
    
}

struct BookRoute: Routable {
    let bookController = UIStoryboard(name: "CompassMain", bundle: nil).instantiateViewController(withIdentifier: "CompassBookViewController") as! CompassBookViewController
    
    func navigate(to location: Location, from currentController: CurrentController) throws {
        guard let book = location.arguments["name"], let amount = location.arguments["amount"] else { return }
        
        //let bookController = CompassBookViewController(title: book, pages : amount) as! BookViewController
        bookController.title = "Book"
        bookController.bookName = book
        bookController.numberOfPages = amount
        
        //currentController.navigationController?.pushViewController(bookController, animated: true)
        currentController.navigationController?.pushOrPop(to:bookController)
        //currentController.pushOrPop(to:bookController)
    }
    
}

struct LogoutRoute: Routable {
 
    let logoutController = UIStoryboard(name: "CompassMain", bundle: nil).instantiateViewController(withIdentifier: "CompassLogoutViewController")
    
    func navigate(to location: Location, from currentController: CurrentController) throws {
    
        //let logoutController = CompassLogoutViewController()
        logoutController.title = "Logout"
        
        //currentController.navigationController?.pushViewController(logoutController, animated: true)
        currentController.navigationController?.pushOrPop(to: logoutController)
        //currentController.pushOrPop(to:logoutController)
    }
}

struct ConfirmRoute: Routable {
   
    let confirmController = UIStoryboard(name: "CompassMain", bundle: nil).instantiateViewController(withIdentifier: "CompassConfirmViewController") as! CompassConfirmViewController 
    func navigate(to location: Location, from currentController: CurrentController) throws {
        
        //let confirmController = CompassConfirmViewController()
        confirmController.title = "Confirm"
        
        //currentController.navigationController?.pushViewController(confirmController, animated: true)
        currentController.navigationController?.pushOrPop(to: confirmController)
        //currentController.pushOrPop(to:confirmController)
    }
}

public class CompassNavigationController: UINavigationController {

    public func handleRoute(_ url: URL, router: Router)  {
        guard let location = Navigator.parse(url: url) else {
            print("Location not found")
            return
        }
        router.navigate(to: location, from: self)
    }
    
    public func navigate(to route: String){
        do {
            try Navigator.navigate(urn: route)
        } catch {
            print("could not navigate to \(route)")
        }
    }
    
    var router = Router()
    let rootviewcontroller = UIStoryboard(name: "CompassMain", bundle: nil).instantiateViewController(withIdentifier: "CompassRootViewController") 
    let loginController = UIStoryboard(name: "CompassMain", bundle: nil).instantiateViewController(withIdentifier: "CompassLoginViewController")
    let profileController = UIStoryboard(name: "CompassMain", bundle: nil).instantiateViewController(withIdentifier: "CompassProfileViewController")
    let bookController = UIStoryboard(name: "CompassMain", bundle: nil).instantiateViewController(withIdentifier: "CompassBookViewController") as! CompassBookViewController
    let logoutController = UIStoryboard(name: "CompassMain", bundle: nil).instantiateViewController(withIdentifier: "CompassLogoutViewController")
    let confirmController = UIStoryboard(name: "CompassMain", bundle: nil).instantiateViewController(withIdentifier: "CompassConfirmViewController") as! CompassConfirmViewController 
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        //self.viewControllers = [rootviewcontroller]
        //self.pushViewController(rootviewcontroller, animated: true)
        //rootviewcontroller.title = "Home"
       
        Navigator.scheme = "compass"
        print( Navigator.scheme)
        
        Navigator.routes = [
            "login:{username}", 
            "home:{title}", 
            "profile:{username}", 
            "book:pages:{name}:{amount}",
            "logout",
            "logout//confirm"
        ]
        print( Navigator.routes)
        
        router.routes = [
            "login:{username}": LoginRoute(),
            "home:{title}": HomeRoute(),
            "profile:{username}": ProfileRoute(),
            "book:pages:{name}:{amount}": BookRoute(),
            "logout": LogoutRoute(),
            "logout//confirm" : ConfirmRoute()
        ]
        print( Navigator.routes)
        print(router.routes)
        
        /*
        Navigator.handle = { [weak self] location in
            guard let this = self else { return }
            
            let arguments = location.arguments
            
            switch location.path {
            case "login:{username}":
                //let loginController = CompassLoginViewController(title: arguments["username"])
                this.loginController.title = arguments["username"]
                this.pushOrPop(to:this.loginController)
            case "home:{title}":
                //let homeController = CompassRootViewController(title: arguments["title"])
                this.rootviewcontroller.title = arguments["title"]
                this.pushOrPop(to:this.rootviewcontroller)
            case "profile:{username}":
                //let profileController = CompassProfileViewController(title: arguments["username"])
                this.profileController.title = arguments["username"]
                this.pushOrPop(to:this.profileController)
            case "book:pages:{name}:{amount}":
                //let bookController = CompassBookViewController(title: arguments["name"], pages : arguments["amount"]) as! BookViewController
                
                this.bookController.title = "Book"
                this.bookController.bookName = location.arguments["name"]
                this.bookController.numberOfPages = location.arguments["amount"] 
                this.pushOrPop(to:this.bookController)
                
            case "logout":
                //let logoutController = CompassLogoutViewController()
                this.logoutController.title = "Logout"
                this.pushOrPop(to: this.logoutController)
                
            case "logout//confirm":
                //let logoutController = CompassConfirmViewController()
                this.confirmController.title = "Confirm"
                this.pushOrPop(to: this.confirmController)
            default: 
                break
            }
        }
        
        navigate(to :"login:George is In")
        
        */
        
        let url = URL(string: "compass://login:George_logged_in")!
        self.handleRoute(url, router: router)
    }

    override public func didReceiveMemoryWarning() {
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
