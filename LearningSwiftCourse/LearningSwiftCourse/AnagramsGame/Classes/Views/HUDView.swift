

import UIKit
import LearningSwiftCourseExtensions

public class HUDView: UIView {
  
    var stopwatch: StopwatchView!
    var gamePoints: CounterLabelView!
    
    var pointsLabel : UILabel!
    var hintButton: UIButton!
    
    let stopwatchVWidthRatio : CGFloat = 0.24
    let pointsWidthRatio : CGFloat = 0.3
    let hintWidthRatio : CGFloat = 0.2
    let frontSpace : CGFloat = 0.04
    
  //this should never be called
    required public init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
  
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        stopwatch = StopwatchView(frame:CGRect.zero)
        stopwatch.setSeconds(0)

        //the dynamic points label
        gamePoints = CounterLabelView(font: AnagramsSet.FontHUD!, frame: CGRect.zero)
        gamePoints.textColor = UIColor(red: 0.38, green: 0.098, blue: 0.035, alpha: 1)
        gamePoints.value = 0   
        self.addSubview(gamePoints)

        //"points" label
        pointsLabel = UILabel()
        pointsLabel.backgroundColor = UIColor.clear
        pointsLabel.font = AnagramsSet.FontHUD
        pointsLabel.text = " Points :"
        self.addSubview(pointsLabel)

        self.addSubview(self.stopwatch)
        self.isUserInteractionEnabled = true

        //load the button image
        let hintButtonImage = UIImage(named: "btn")!
        //the help button
        self.hintButton = UIButton(type: .custom)
        hintButton.setTitle("Hint!", for:UIControl.State())
        hintButton.titleLabel?.font = AnagramsSet.FontHUD
        hintButton.setBackgroundImage(hintButtonImage, for: UIControl.State())
        hintButton.alpha = 0.8
        self.addSubview(hintButton)
        
        updateFrames()
    }
    
    func updateFrames (){
        
        let screenWidth = UIScreen.main.bounds.width
        let yPos : CGFloat = 10
        let height = CGFloat.recommenedHeight(withReferencedDevice: UIDevice.current.modelName, desiredHeight: 80)
        
        let stopwatchWidth = screenWidth * stopwatchVWidthRatio
        let stopwatchXpos : CGFloat = ( screenWidth - stopwatchWidth) * CGFloat(0.5)
        let stopwatchFrame = CGRect(x: stopwatchXpos, y: yPos, width: stopwatchWidth, height: height)
        stopwatch.frame = stopwatchFrame
        
        let pointsWidth = (screenWidth * pointsWidthRatio)
        let pointsLabelWidth = pointsWidth * 0.4
        let pointsLabelXpos : CGFloat = screenWidth - pointsWidth
        let pointsLabelFrame = CGRect(x: pointsLabelXpos, y: yPos, width: pointsLabelWidth, height: height)
        pointsLabel.frame = pointsLabelFrame
        
        let gamePointsWidth = pointsWidth * 0.6
        let gamePointsXpos : CGFloat = pointsLabelXpos + pointsLabelWidth
        let gamePointsFrame = CGRect(x: gamePointsXpos, y: yPos, width: gamePointsWidth, height: height)
        gamePoints.frame = gamePointsFrame
        
        let hintWidth = screenWidth * hintWidthRatio
        let hintXpos : CGFloat = screenWidth * frontSpace
        let hintFrame = CGRect(x: hintXpos, y: yPos, width: hintWidth, height: height)
        hintButton.frame = hintFrame
        
    }
    
    override public func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        //1 let touches through and only catch the ones on buttons
        let hitView = super.hitTest(point, with: event)
        
        //2
        if hitView is UIButton {
          return hitView
        }
        
        //3
        return nil
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
