//
//  PickItemView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 18/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class PickItemView: UIView {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var pickItemTitleLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var animateOut : () -> Void = {}
    
    func setup(){
        backgroundColor = UIColor.clear
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
        
        addButtons(to: view)
    }
    
    private func loadViewFromNib()->UIView{
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: String.init(describing: type(of:self)), bundle: bundle)
        let viewNib = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return viewNib
    }
    
    func addButtons(to container : UIView){
        
        let containerWidth = container.bounds.width
        let containerHeight = container.bounds.height
        let width : CGFloat = 60
        let height : CGFloat = 60
        let font = UIFont.systemFont(ofSize: 20)
        
        let numberOfButtons = Int.random(min: 1, max: 3)
        let itemsMaxWidth = width * CGFloat(numberOfButtons)
        var xPos = (containerWidth - itemsMaxWidth) * 0.5
        let yPos = (containerHeight - height) * 0.5
        for _ in 0..<numberOfButtons {
            let frame = CGRect(x: 0, y: yPos, width: width, height: height)
            let button = createButton(with: frame, text: "😀", xPos: xPos, font: font)
            button.tag = self.tag
            button.addTarget(self, action: #selector(selectedItemButton(_:)), for: .touchUpInside)
            container.addSubview(button)
            
            xPos += width
        }
        
    }
    
    @objc func selectedItemButton(_ sender: UIButton) {
        animateOut()
    }
    
    func createButton(with frame: CGRect, text: String, xPos: CGFloat, font : UIFont) -> UIButton
    {
        let button = UIButton(type: .system) 
        button.frame = frame
        button.setTitle(text, for: .normal)
        button.frame.origin.x = xPos
        button.setTitleColor( UIColor.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor.randomColor()
        button.titleLabel?.font = font
        button.addBorder()
        return button
    }
    
    required public init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override public func didMoveToSuperview() {
        
    }
    
}
