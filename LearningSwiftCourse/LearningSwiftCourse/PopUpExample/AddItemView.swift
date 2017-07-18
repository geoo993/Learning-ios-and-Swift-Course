//
//  AddItemView.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 18/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

class AddItemView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var addItemTitleLabel: UILabel!
    @IBOutlet weak var addItemDone: UIButton!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var animateOut : () -> Void = {}
    
    @IBAction func doneButton(_ sender: UIButton) {
        animateOut()
    }
    
    func setup(){
        backgroundColor = UIColor.clear
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
    
    private func loadViewFromNib()->UIView{
        let bundle = Bundle(for: type(of:self))
        let nib = UINib(nibName: String.init(describing: type(of:self)), bundle: bundle)
        let viewNib = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return viewNib
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
