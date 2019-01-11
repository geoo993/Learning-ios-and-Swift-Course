//
//  ParallaxViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 10/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://stackoverflow.com/questions/42953360/swift-how-to-do-add-an-header-with-parallax-effect-to-tableview
//https://stackoverflow.com/questions/31373775/how-do-i-create-a-parallax-effect-in-uitableview-with-uiimageview-in-their-proto
//https://www.youtube.com/watch?v=_U-eXneUnQY

import UIKit

class ParallaxViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    //Mark: - Status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet weak var tableView: UITableView!
    
    
    let imageNames = ["autumnlandscape", "desert", "GoldenGateBridge", "happiness","japanvillage", "pexels", "treesfallredleaves", "svetik", "snowvillage","naturemountain","foresttreesfog"] 
    var images = [UIImage]()
    
    let cellItems = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten","Home"]
    
    
    // Mark: - Parallax elements
    
    // Change the ratio or enter a fixed value, whatever you need
    var cellHeight: CGFloat {
        return tableView.frame.width * 9 / 16
    }
    
    // Just an alias to make the code easier to read
    var imageVisibleHeight: CGFloat {
        return cellHeight
    }
    
    // Change this value to whatever you like (it sets how "fast" the image moves when you scroll)
    let parallaxOffsetSpeed: CGFloat = 50
    
    
    // This just makes sure that whatever the design is, there's enough image to be displayed, I let it up to you to figure out the details, but it's not a magic formula don't worry :)
    var parallaxImageHeight: CGFloat {
        let maxOffset = (sqrt(pow(cellHeight, 2) + 4 * parallaxOffsetSpeed * tableView.frame.height) - cellHeight) / 2
        return imageVisibleHeight + maxOffset
    }
    
    // Used when the table dequeues a cell, or when it scrolls
    func parallaxOffsetFor(newOffsetY: CGFloat, cell: UITableViewCell) -> CGFloat {
        return ((newOffsetY - cell.frame.origin.y) / parallaxImageHeight) * parallaxOffsetSpeed
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.register(ParallaxTableViewCell.self, forCellReuseIdentifier: cellReuseIdendifier)
        tableView.delegate = self
        tableView.dataSource = self
       
        images = imageNames.compactMap{ UIImage(named: $0)! }
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = tableView.contentOffset.y
        for cell in tableView.visibleCells as! [ParallaxTableViewCell] {
            cell.parallaxTopConstraint.constant = parallaxOffsetFor(newOffsetY: offsetY, cell: cell)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"parallax cell", for: indexPath) as! ParallaxTableViewCell
        cell.parallaxImageView.image = images[indexPath.row]
        cell.parallaxHeightConstraint.constant = parallaxImageHeight
        cell.parallaxTopConstraint.constant = parallaxOffsetFor(newOffsetY: tableView.contentOffset.y, cell: cell)
        cell.parallaxImageLabel.text = cellItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == (cellItems.count - 1) {
            dismiss(animated: true) { 
                print("view controller dismissed, now going to home page")
            }
        }
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
        view.removeEverything()
    }
    
    deinit {
        clearAll()
        print("Parallax view controller is \(#function)")
    }

}

