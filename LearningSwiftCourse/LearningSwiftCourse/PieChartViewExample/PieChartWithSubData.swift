//
//  PieChartWithSubData.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 01/07/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//

import UIKit

@IBDesignable class PieChartWithSubData: UIView {
    
    func dictionary_to_sorted_array(dict:Dictionary<String,Double>) ->Array<(key:String,value:Double)> {
        var tuples: Array<(key:String,value:Double)> = Array()
        let sortedKeys = (dict as NSDictionary).keysSortedByValue(using: #selector(NSNumber.compare(_:)))
        for key in sortedKeys {
            tuples.append((key:key as! String,value:dict[key as! String]!))
        }
        return tuples
    }
    
    var chartColors : [UIColor] 
    var chartData: Dictionary<String,Double> 
    
    @IBInspectable var lineWidth: CGFloat = 2.0 {
        didSet { setNeedsDisplay()
        }
    }
    @IBInspectable var lineColor: UIColor = UIColor.black {
        didSet { setNeedsDisplay() }
    }
    
    required init(coder aDecoder: NSCoder) {
        self.chartColors = [.orange, .cyan, .random, .yellow, .random, .random]
        self.chartData = ["Alpha":1, "Beta":2, "Charlie":3, "Delta":4, "Echo":2.5, "Foxtrot":1.4] 
        
        super.init(coder:aDecoder)!
        self.contentMode = .redraw
    }
    
    override init(frame: CGRect) {
        self.chartColors = [.orange, .cyan, .random, .yellow, .random, .random]
        self.chartData = ["Alpha":1, "Beta":2, "Charlie":3, "Delta":4, "Echo":2.5, "Foxtrot":1.4] 

        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.contentMode = .redraw
    }
    
    init(frame: CGRect, chartColors : [UIColor], chartData: Dictionary<String,Double>) {
        self.chartColors = chartColors
        self.chartData = chartData
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.contentMode = .redraw
    }
    
    override func draw(_ rect: CGRect) {
        
        // set font for labels
        let fieldColor: UIColor = UIColor.darkGray
        let fieldFont = UIFont(name: "Georgia",size: 12.0)
        var fieldAttributes: NSDictionary = [
            NSAttributedString.Key.foregroundColor: fieldColor,
            NSAttributedString.Key.font: fieldFont!
        ]
        
        // get the graphics context and prepare an inset box for the pie
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let margin: CGFloat = lineWidth
        let box0 = self.bounds.insetBy(dx: margin, dy: margin)
        let keyHeight = CGFloat( ceil( Double(chartData.count) / 3.0) * 24 ) + 16
        let side : CGFloat = min(box0.width, box0.height-keyHeight)
        let box = CGRect( x:(self.bounds.width-side)/2, y:(self.bounds.height-side-keyHeight)/2,width:side,height:side)
        let radius : CGFloat = min(box.width, box.height)/2.0
        
        
        // converts percentages to radians for drawing the segment
        func percent_to_rad(p: Double) -> CGFloat {
            let rad = CGFloat(p * 0.02 * Double.pi)
            return rad
        }
        
        // draws a segment
        func draw_arc(start: CGFloat, end: CGFloat, color: CGColor) {
            context.beginPath()
            
            context.setLineWidth(lineWidth)
            context.setStrokeColor(lineColor.cgColor)
            context.move(to: CGPoint(x: box.midX, y: box.midY))
            context.addArc(center: CGPoint(x:box.midX,y:box.midY), 
                           radius: radius-lineWidth/2, 
                           startAngle: start, 
                           endAngle: end, 
                           clockwise: false)
            context.strokePath()
            
            
            context.setFillColor( color)
            context.move(to: CGPoint(x: box.midX, y: box.midY))
            context.addArc(center: CGPoint(x:box.midX,y:box.midY), 
                           radius: radius-lineWidth/2, 
                           startAngle: start, 
                           endAngle: end, 
                           clockwise: false)
            context.closePath()
            context.fillPath()
            
        }
        // draws a key item
        func draw_key(keyName: String, keyValue: Double, color: CGColor, keyX: CGFloat, keyY: CGFloat) {
            context.beginPath()
            context.move(to: CGPoint(x: keyX, y: keyY))
            context.setFillColor( color)
            context.addArc(center: CGPoint(x:keyX,y:keyY), 
                           radius: 8, 
                           startAngle: 0, 
                           endAngle: CGFloat(2 * Double.pi), 
                           clockwise: false)
            
            context.closePath()
            context.fillPath()
            
            //drae name next to circle
            keyName.draw(in: CGRect(x:keyX + 12,y:keyY-8,width:self.bounds.width/3,height:16), withAttributes: fieldAttributes as? [NSAttributedString.Key : Any])
        }
        
        
        let total =  Double( chartData.values.reduce(0, +) ) // the total of all values
        // convert dictionary to sorted touples
        let dataPointsArray = dictionary_to_sorted_array(dict: chartData)
        
        // now sort the dictionary into an Array
        var start = -CGFloat(Double.pi / 2) // start at 0 degrees, not 90
        var end: CGFloat
        var i = 0
        
        // draw all segments
        for dataPoint in dataPointsArray {
            
            end = percent_to_rad(p: Double( (dataPoint.value)/total) * 100 ) + start
            
            draw_arc(start: start,end:end,color: chartColors[ i % chartColors.count ].cgColor)
            
            start = end
            i += 1
        }
        
        // the key
        let keyXoffset : CGFloat = 20
        var keyX = keyXoffset + self.bounds.minX
        var keyY = self.bounds.height - keyHeight + 32
        i = 0
        for dataPoint in dataPointsArray {
            
            draw_key(keyName: dataPoint.key, 
                     keyValue: dataPoint.value, 
                     color: chartColors[ i % chartColors.count ].cgColor, 
                     keyX: keyX, 
                     keyY: keyY)
            
            if((i+1)%3 == 0) {
                keyX = keyXoffset + self.bounds.minX 
                keyY += 24
            } else {
                keyX += self.bounds.width / 3
            }
            i += 1
        }
        
        
        
    }
}
