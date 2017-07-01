//
//  PieChartViewViewController.swift
//  LearningSwiftCourse
//
//  Created by GEORGE QUENTIN on 30/06/2017.
//  Copyright © 2017 LEXI LABS. All rights reserved.
//
//https://medium.com/@jacks205/lets-create-a-custom-uiview-circle-indicator-in-swift-ec5a2b993dec
//https://stackoverflow.com/questions/35752762/making-a-pie-chart-using-core-graphics
//http://wareto.com/swift-piecharts
//https://github.com/DuncanMC/PieChart/blob/master/PieChart/PieChartView.swift
//https://stackoverflow.com/questions/33944446/creating-a-pie-chart-in-swift
//https://stackoverflow.com/questions/30266554/pie-chart-slices-in-swift
//https://stackoverflow.com/questions/36708737/how-to-create-the-pie-chart-and-fill-percentage-in-swift
//https://stackoverflow.com/questions/29320361/how-to-create-graph-pies-with-different-sizes-using-b%C3%A9zier-paths-in-swift

import UIKit

class PieChartViewViewController: UIViewController {

    @IBAction func homebutton(_ sender: Any) {
        dismiss(animated: true) { 
            print("view controller dismissed, now going to home page")
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var titleText = ""
    var pageIndex: Int = -1
    var numberOfPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupPage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupPage(){
        
        titleLabel.text = titleText
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = pageIndex
        
        setupPieView()
    }
    
    func removeView<T>(with type : T.Type){
        for subview in view.subviews {
            if (subview is T) {
                print(subview)
                subview.removeFromSuperview()
            }
        }
    }
    
    func setupPieView(){
        
        switch pageIndex {
        case 0:
            showCirclePieView()
        case 1:
            showSimplePieChart()
        case 2:
            showPieChartWithSubData()
        case 3:
            showPieChartWithLines()
        default:
            break
        }
    }
    
    func showCirclePieView(){
        
        removeView(with: CirclePieIndicatorView.self)
        
        let frame = CGRect(x: 0, y:0, width: 250 , height: 250)
        let circlePieIndicatorView = CirclePieIndicatorView(frame: frame)
        circlePieIndicatorView.center = view.center
        
        let values = [0, 150, 300, 0, 150, 300, 0, 150, 300, 0, 150, 300]
        var totalValues = 0
        for val in values {
            totalValues += val
        }
        
        let totals = [200, 500, 350, 220, 600, 500, 200, 500, 350, 220, 600, 500]
        var totalTotals = 0
        for total in totals {
            totalTotals += total
        }
        
        let percent = (Double(totalValues) / Double(totalTotals)) * 100
        circlePieIndicatorView.percentageLabel.text = percent.format(f:".0") + "%"
        circlePieIndicatorView.circlePieView.setSegmentValues(
            values: values,
            totals: totals,
            colors: [UIColor.green, UIColor.yellow, UIColor.red, UIColor.green, UIColor.yellow, UIColor.red, UIColor.green, UIColor.yellow, UIColor.red, UIColor.green, UIColor.yellow, UIColor.red])
        circlePieIndicatorView.circlePieView.backgroundColor = UIColor.clear
        view.addSubview(circlePieIndicatorView)
    }
    
    func showSimplePieChart(){
        
        removeView(with: PieChartView.self)
        
        let pieChartView = PieChartView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300) )
        pieChartView.center = view.center
        pieChartView.segments = [
            PieSegment(color: .red, value: 57),
            PieSegment(color: .blue, value: 30),
            PieSegment(color: .green, value: 25),
            PieSegment(color: .yellow, value: 40)
        ]
        view.addSubview(pieChartView)
    }
    
    func showPieChartWithSubData(){
        
        removeView(with: PieChartWithSubData.self)
        
        let uicolor_chart_1 = UIColor.init(red: 0.0/255, green:153.0/255, blue:255.0/255, alpha:1.0)  //16b
        let uicolor_chart_2 = UIColor.init(red: 0.0/255, green:200.0/255, blue:120.0/255, alpha:1.0)
        let uicolor_chart_3 = UIColor.init(red: 140.0/255, green:220.0/255, blue:0.0/255, alpha:1.0)
        let uicolor_chart_4 = UIColor.init(red: 255.0/255, green:240.0/255, blue:0.0/255, alpha:1.0)
        let uicolor_chart_5 = UIColor.init(red: 255.0/255, green:180.0/255, blue:60.0/255, alpha:1.0)
        let uicolor_chart_6 = UIColor.init(red: 235.0/255, green:60.0/255, blue:150.0/255, alpha:1.0)
        
        let chartColors = [
                uicolor_chart_1,
                uicolor_chart_2,
                uicolor_chart_3,
                uicolor_chart_4,
                uicolor_chart_5,
                uicolor_chart_6
            ]
        let chartData: Dictionary<String,Double> = ["Alpha":1,"Beta":2,"Charlie":3,"Delta":4,"Echo":2.5,"Foxtrot":1.4]
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300)
        let pie = PieChartWithSubData(frame: frame, chartColors: chartColors, chartData: chartData)
        pie.center = view.center
        view.addSubview(pie)
    }
    
    func showPieChartWithLines(){
        removeView(with: PieChartViewWithBezierPath.self)
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300)
        let dataPoints = [
            DataPoint(text: "Monday", value: 2, color: UIColor.randomColor()),
            DataPoint(text: "Tuesday", value: 4, color: UIColor.randomColor()),
            DataPoint(text: "Wednesday", value: 6, color: UIColor.randomColor()),
            DataPoint(text: "Thursday", value: 8, color: UIColor.randomColor()),
            DataPoint(text: "Friday", value: 5, color: UIColor.randomColor()),
            DataPoint(text: "Saturday", value: 3, color: UIColor.randomColor()),
            DataPoint(text: "Sunday", value: 1, color: UIColor.randomColor()),
        ]
        
        let pieChart = PieChartViewWithBezierPath(frame: frame, dataPoints: dataPoints)
        pieChart.center = view.center
        view.addSubview(pieChart)
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
        print("Pie Page view controller is \(#function)")
    }

}
