import UIKit

public class CounterLabelView: UILabel {
  //1
  var value:Int = 0 {
    //2
    didSet {
      self.text = " \(value)"
    }
  }
  
  fileprivate var endValue: Int = 0
  fileprivate var timer: Timer? = nil
  
    required public init?(coder aDecoder:NSCoder) {
        super.init(coder: aDecoder)
    }
  
  //3
  init(font:UIFont, frame:CGRect) {
    super.init(frame:frame)
    self.font = font
    self.backgroundColor = UIColor.clear
  }
  
  func updateValue(_ timer:Timer) {
    //1 update the value
    if (endValue < value) {
      value -= 1
    } else {
      value += 1
    }
    
    //2 stop and clear the timer
    if (endValue == value) {
      timer.invalidate()
      self.timer = nil
    }
  }
  
  //count to a given value
  func setValue(_ newValue:Int, duration:Float) {
    //1 set the end value
    endValue = newValue
    
    //2 cancel previous timer
    if timer != nil {
      timer?.invalidate()
      timer = nil
    }
    
    //3 calculate the interval to fire each timer
    let deltaValue = abs(endValue - value)
    if (deltaValue != 0) {
      var interval = Double(duration / Float(deltaValue))
      if interval < 0.01 {
        interval = 0.01
      }
      
      //4 set the timer to update the value
      timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector:#selector(CounterLabelView.updateValue(_:)), userInfo: nil, repeats: true)
    }
  }
}
