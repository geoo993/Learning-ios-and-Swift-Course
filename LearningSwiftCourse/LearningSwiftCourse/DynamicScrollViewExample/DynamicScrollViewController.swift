//
//  DynamicScrollViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 09/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture

class DynamicScrollViewController: UIViewController {

    @IBAction func homebutton(_ sender: UIButton) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    @IBOutlet weak var panelSrollView: UIScrollView!
    @IBOutlet weak var panelBookshelfButton: UIButton!
    @IBOutlet weak var panelStudentsButton: UIButton!
    @IBOutlet weak var panelPhonicsButton: UIButton!
    @IBOutlet weak var panelTweaksButton: UIButton!
    @IBOutlet weak var panelEmailButton: UIButton!
    @IBOutlet weak var panelLogoutButton: UIButton!
    @IBOutlet weak var panelGamesButton: UIButton!
    @IBOutlet weak var panelReadingButton: UIButton!
    
    @IBOutlet weak var panelBBCiPlayerLogoButton: UIButton!
    let selectedColor = UIColor.randomColor()
    var buttonsBackgroundView = [UIView]()
    
    let disposable = DisposeBag()
    
    func getAllButtons() -> [UIButton]
    {
        return [ 
            panelBookshelfButton,
            panelStudentsButton,
            panelPhonicsButton,
            panelTweaksButton,
            panelBBCiPlayerLogoButton,
            panelEmailButton,
            panelLogoutButton,
            panelGamesButton,
            panelReadingButton
        ]
    }
    
    func changeButtonColor(at index: Int, color: UIColor){
        if !buttonsBackgroundView.isEmpty && buttonsBackgroundView.count > index {
            clearButtonsBackgroundViewColor()
            buttonsBackgroundView[index].backgroundColor = color.withAlphaComponent(0.5)
        }
    }
    
    func clearButtonsBackgroundViewColor(){
        _ = buttonsBackgroundView.map{ $0.backgroundColor = .clear }
    }
    
    func setupScrollviewItems(_ shouldWrapInsideView: Bool){
        
        let buttons = getAllButtons()
        let buttonsTotalWidth = buttons.map{ $0.bounds.width }.reduce( 0, + )
        let remainingWidth = UIScreen.main.bounds.width - buttonsTotalWidth
        
        let shouldWrap = (remainingWidth > 2) ? shouldWrapInsideView : false
        
        let numberOfElements = buttons.count
        let scrollViewHeight : CGFloat = panelSrollView.bounds.height
        let beginSpace : CGFloat = shouldWrap ? 1 : 10
        let spacing : CGFloat = shouldWrap ? remainingWidth / CGFloat(numberOfElements) : 20
        let endingSpace : CGFloat = shouldWrap ? 1 : 10
        
        //calculate all the content width
        var contentWidth : CGFloat = beginSpace
        
        for i in 0..<numberOfElements {
            //let position : CGPoint = buttons[i].bounds.origin
            let size : CGSize = buttons[i].bounds.size //CGSize(width: 32, height: 30)
            let itemWidth : CGFloat = size.width
            let y = (scrollViewHeight - size.height) / 2
            let x = contentWidth//beginSpace + CGFloat(i) * (itemWidth + spacing)
            
            let buttonFrame = CGRect(origin: CGPoint(x:x, y: y), size: size)
            buttons[i].frame = buttonFrame
            
            contentWidth += (i != numberOfElements - 1) ? (itemWidth + spacing) : itemWidth
            
            ////adding background view
            let buttonBackgroundViewWidth = (itemWidth + spacing)
            let buttonBackgroundViewX = x - (spacing / 2)
            let buttonBackgroundView = UIView(frame: CGRect(x: buttonBackgroundViewX, y: 0, width: buttonBackgroundViewWidth, height: scrollViewHeight))
            buttonBackgroundView.backgroundColor = UIColor.clear
            panelSrollView.addSubview(buttonBackgroundView)
            panelSrollView.sendSubview(toBack: buttonBackgroundView)
            buttonsBackgroundView.append(buttonBackgroundView)
            
        }
        
        contentWidth += endingSpace
        
        //set scrollView content size
        panelSrollView.contentSize = CGSize(width: contentWidth, height: scrollViewHeight)
    
    }
    
    func getIndex(with button : UIButton) -> Int? {
        return getAllButtons().index(of: button)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = getAllButtons().map{ $0
            .rx
            .tapGesture()
            .subscribe( onNext: { sender in
                
                let button = sender.view as! UIButton
                if let index = self.getIndex(with: button) {
                    self.changeButtonColor(at: index, color: self.selectedColor)
                }
                
            }).addDisposableTo(disposable)
        }
        
        clearButtonsBackgroundViewColor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupScrollviewItems(true)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
    
    deinit {
        print("Dynamic Scroll View controller is \(#function)")
    }

}

extension DynamicScrollViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
    }
}

