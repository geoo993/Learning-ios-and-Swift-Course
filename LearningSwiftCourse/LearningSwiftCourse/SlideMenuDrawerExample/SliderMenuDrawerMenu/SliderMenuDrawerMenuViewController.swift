//
//  SliderMenuDrawerViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 17/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int)
}

class SliderMenuDrawerMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    /**
     *  Array to display menu options
     */
    @IBOutlet var tblMenuOptions : UITableView!
    
    /**
     *  Transparent button to hide menu
     */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    
    /**
     *  Array containing menu options
     */
    var arrayMenuOptions : [Dictionary<String,String>] = {
        return [
            ["title":"Apple", "icon":"appleBorderIcon"],
            ["title":"User", "icon":"userIconPin"],
            ["title":"Create", "icon":"createIconPin"],
            ["title":"Play", "icon":"playIconPin"],
            ["title":"Upload", "icon":"uploadIconPin"],
            ["title":"Options", "icon":"optionsIconPin"],
            ["title":"Settings", "icon":"settingsIconPin"],
        ]
    }()
    
    /**
     *  Menu button which was tapped to display the menu
     */
    var btnMenu : UIButton!
    
    /**
     *  Delegate of the MenuVC
     */
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }
    
    func updateArrayMenuOptions(){
        
        tblMenuOptions.reloadData()
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
            
            print(index)
        }
        
        //hide table menu
        UIView.animate(withDuration: 0.3, animations: { [weak self] () -> Void in
            self?.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self?.view.layoutIfNeeded()
            self?.view.backgroundColor = UIColor.clear
        }, completion: { [weak self] (finished) -> Void in
            self?.view.removeFromSuperview()
            self?.removeFromParentViewController()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu", for: indexPath) as! SliderMenuDrawerMenuTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        cell.cellImageView.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        cell.cellTitleLabel.text = arrayMenuOptions[indexPath.row]["title"]!
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func clearAll(){
        arrayMenuOptions = []
        
        tblMenuOptions.getAllCells().map{ $0.removeEverything() }
        tblMenuOptions.removeEverything()
        tblMenuOptions = nil
        btnCloseMenuOverlay.removeEverything()
        btnCloseMenuOverlay = nil
        btnMenu.removeEverything()
        btnMenu = nil
        delegate = nil
    }
    
    deinit {
        clearAll()
        print("Slider Menu Drawer Menu view controller is \(#function)")
    }

}
