import UIKit

//https://www.raywenderlich.com/90690/modern-core-graphics-with-swift-part-1


@IBDesignable class CounterView: UIView {
  
    let π:CGFloat = CGFloat.pi
    
    @IBInspectable var MaxCount: Int = 0
    {
        didSet {
            if MaxCount >=  0 {
                //the view needs to be refreshed
                setNeedsDisplay()
            }else {
                MaxCount = 0
                counter = 0
            }
        }
    }
    
    @IBInspectable var counter: Int = 5 {
        didSet {
            if counter <=  MaxCount {
                //the view needs to be refreshed
                setNeedsDisplay()
            }
        }
    }
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.orange
  
    override func draw(_ rect: CGRect) {
        
        // 1
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        // 2
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        // 3
        let arcWidth: CGFloat = 76
        
        // 4
        let startAngle: CGFloat = 2.0000000001 * π / 4.0
        let endAngle: CGFloat = π / 2.0
        
        // 5
        let path = UIBezierPath(arcCenter: center,
          radius: radius/2 - arcWidth/2,
          startAngle: startAngle,
          endAngle: endAngle,
          clockwise: true)
        
        // 6
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        //Draw the outline
        
        //1 - first calculate the difference between the two angles
        //ensuring it is positive
        let angleDifference: CGFloat = 2.0 * π - startAngle + endAngle
        
        //then calculate the arc for each single glass
        let arcLengthPerGlass = angleDifference / CGFloat(MaxCount)
        
        //then multiply out by the actual glasses drunk
        let outlineEndAngle = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //2 - draw the outer arc
            let outlinePath = UIBezierPath(arcCenter: center,
          radius: bounds.width/2 - 2.5,
          startAngle: startAngle,
          endAngle: outlineEndAngle,
          clockwise: true)
        
        //3 - draw the inner arc
            outlinePath.addArc(withCenter: center,
          radius: bounds.width/2 - arcWidth + 2.5,
          startAngle: outlineEndAngle,
          endAngle: startAngle,
          clockwise: false)
        
        //4 - close the path
            outlinePath.close()
        
        outlineColor.setStroke()
        outlinePath.lineWidth = 5.0
        outlinePath.stroke()
    }
}
