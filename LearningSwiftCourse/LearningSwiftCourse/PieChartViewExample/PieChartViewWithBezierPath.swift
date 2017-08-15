//
//  PieChartViewWithBezierPath.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 01/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

public class DataPoint {
    let text: String
    let value: Float
    let color: UIColor
    
    public init(text: String, value: Float, color: UIColor) {
        self.text = text
        self.value = value
        self.color = color
    }
}

@IBDesignable class PieChartViewWithBezierPath: UIView {

    public var dataPoints: [DataPoint]
   
    @IBInspectable var lineWidth: CGFloat = 2.0 {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable var lineColor: UIColor = UIColor.random {
        didSet { setNeedsDisplay() }
    }
    
    fileprivate let data = [
        DataPoint(text: "foo", value: 3, color: UIColor.red),
        DataPoint(text: "bar", value: 4, color: UIColor.yellow),
        DataPoint(text: "baz", value: 5, color: UIColor.blue)
    ]
    
    required init(coder aDecoder: NSCoder) {
        self.dataPoints = data
        super.init(coder:aDecoder)!
        self.contentMode = .redraw
    }
    
    override init(frame: CGRect) {
        self.dataPoints = data
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.contentMode = .redraw
    }
    
    init(frame: CGRect, dataPoints: [DataPoint]) {
        self.dataPoints = dataPoints
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.contentMode = .redraw
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        guard !dataPoints.isEmpty else {
            return
        }
        
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = min(bounds.size.width, bounds.size.height) / 2.0 - lineWidth
        let total = dataPoints.reduce(Float(0)) { $0 + $1.value }
        var startAngle = CGFloat(-(Double.pi / 2))
        
        UIColor.black.setStroke()
        
        for dataPoint in dataPoints {
            let endAngle = startAngle + CGFloat(2.0 * Double.pi) * CGFloat(dataPoint.value / total)
            
            let path = UIBezierPath()
            path.move(to: center)
            path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.close()
            
            path.lineWidth = lineWidth
            dataPoint.color.setFill()
            
            path.fill()
            path.stroke()
            
            startAngle = endAngle
            
            
        }
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }

}
