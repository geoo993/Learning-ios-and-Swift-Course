//
//  BookViewController.swift
//  UsingCompass
//
//  Created by GEORGE QUENTIN on 05/09/2017.
//  Copyright © 2017 geomakesgames. All rights reserved.
//

import UIKit

public class CompassBookViewController: CompassBaseViewController {

    @IBOutlet weak var bookLabel : UILabel!
    @IBOutlet weak var pagesLabel : UILabel!
    
    @IBAction func home( _ sender : UIButton){
        //self.navigatorHome()
        
        let url = URL(string: "compass://home:Home")!
        self.handleRoute(url, router: router)
    }
    
    var bookName : String?
    var numberOfPages : String?
    
    // this is a convenient way to create this view controller without a imageURL
    convenience init() {
        self.init(book: nil, pages: nil)
    }
    
    init(book: String?, pages : String?) {
        super.init(nibName: nil, bundle: nil)
        self.title = "Book"
        self.bookName = book
        self.numberOfPages = pages
    }
    
    // if this view controller is loaded from a storyboard, imageURL will be nil

    // Xcode 7 & 8
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = .blue
        // Do any additional setup after loading the view.
        updateLabels(with: bookName, pages: numberOfPages)
    }
    
    func updateLabels(with book: String?, pages: String?){
        bookLabel?.text = book
        pagesLabel?.text = (pages ?? "") + " Pages "
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
