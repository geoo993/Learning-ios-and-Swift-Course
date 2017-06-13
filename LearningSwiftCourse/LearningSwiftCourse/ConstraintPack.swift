/*
 
 Erica Sadun, http://ericasadun.com
 Auto Layout Demystified

 Requires CrossPlatformDefines.swift
 This version deprecates iOS 7 coverage. For iOS 8 and later only

*/

import Foundation
import ObjectiveC
#if os(iOS)
    import UIKit
#else
    import Cocoa
#endif

public let SkipConstraint = CGRect.null.origin.x
public let SkipOptions = NSLayoutFormatOptions(rawValue: 0)

// **************************************
// MARK: Convenience
// **************************************

public extension View {
    public func addSubviews(views : View...) {
        for eachView in views {
            addSubview(eachView)
            eachView.autoLayoutEnabled = true
        }
    }
}

// **************************************
// MARK: Superviews / Ancestors
// **************************************

// Return superviews
public func Superviews(view : View) -> ([View]) {
    var array = [View]()
    var currentView : View? = view.superview
    while (currentView != nil) {
        array += [currentView!]
        currentView = currentView!.superview
    }
    return array
}

// Return nearest common ancestor between two views
public func NearestCommonViewAncestor(view1 : View, view2 : View) -> (View?) {
    if view1 === view2 {return view1}
    
    let view1Superviews = Superviews(view: view1)
    let view2Superviews = Superviews(view: view2)
    
    // Check for superview relationships
    if view1Superviews.contains(view2) { return view2 }
    if view2Superviews.contains(view1) { return view1 }
    
    // Check for indirect ancestor
    for eachItem in view1Superviews {
        if view2Superviews.contains(eachItem) { return eachItem }
    }
    
    return nil
}

public extension View {
    public var superviews : [View] {get { return Superviews(view: self) } }
    public func nearestCommonAncestorWithView(view : View) -> (View?) {
        return NearestCommonViewAncestor(view1: self, view2: view)
    }
}

// **************************************
// MARK: Constraint References
// **************************************

// NSView uses a constraints property
// UIView uses a constraints function
public extension View {
    var viewConstraints : [NSLayoutConstraint] {
        #if os(iOS)
            return constraints 
        #else
            return constraints as! [NSLayoutConstraint]
        #endif
    }
}

public extension NSLayoutConstraint {
    public var firstView : View {return self.firstItem as! View}
    public var secondView : View? {return self.secondItem as? View}
    public func refersToView(theView : View) -> Bool {
        if firstItem as! View == theView {return true}
        if secondItem != nil {
            if secondItem as! View == theView {return true}
        }
        return false
    }
}

public func ExternalConstraintsReferencingView(view : View) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]()
    for superview in view.superviews {
        for constraint in superview.viewConstraints {
            if constraint.refersToView(theView: view) {constraints += [constraint]}
        }
    }
    return constraints
}

public func InternalConstraintsReferencingView(view : View) -> [NSLayoutConstraint] {
    var constraints = [NSLayoutConstraint]() // updated to any object
    for constraint in view.viewConstraints {
        if constraint.refersToView(theView: view) {
            constraints += [constraint]
        }
    }
    return constraints
}

public extension View {
    public var externalConstraintReferences : [NSLayoutConstraint] {
        return ExternalConstraintsReferencingView(view: self)
    }
    public var internalConstraintReferences : [NSLayoutConstraint] {
        return InternalConstraintsReferencingView(view: self)
    }
    public var constraintsReferencingView : [NSLayoutConstraint] {
        return internalConstraintReferences + externalConstraintReferences
    }
}

// **************************************
// MARK: Enabling Auto Layout
// **************************************
#if os(iOS)
    public extension View {
        public var autoLayoutEnabled : Bool {
            get {return !translatesAutoresizingMaskIntoConstraints}
            set { translatesAutoresizingMaskIntoConstraints = !newValue } //setTranslatesAutoresizingMaskIntoConstraints(!newValue)}
        }
    }
    #else
    public extension View {
        public var autoLayoutEnabled : Bool {
        get {return translatesAutoresizingMaskIntoConstraints == false}
        set {translatesAutoresizingMaskIntoConstraints = !newValue}
        }
    }
#endif




// **************************************
// MARK: Format Installation
// **************************************
public func InstallLayoutFormats(
    formats : [String],
    options : NSLayoutFormatOptions,
    metrics : [String : Any]?,
    bindings : [String : Any],
    priority : LayoutPriority) {
    for format in formats {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: metrics, views: bindings ) 
        _ = constraints.map{ $0.priority = priority }
        NSLayoutConstraint.activate(constraints)
    }
}

// **************************************
// MARK: Sizing
// **************************************

// Constraining Sizes
public func SizeView(view : View, size : CGSize, priority : LayoutPriority) {
    let metrics = ["width" : size.width, "height" : size.height]
    let bindings = ["view" : view]
    var formats = [String]()
    if size.width != SkipConstraint { formats += ["H:[view(==width)]"] }
    if size.height != SkipConstraint { formats += ["V:[view(==height)]"] }
    InstallLayoutFormats(formats: formats, options: SkipOptions, metrics: metrics , bindings: bindings, priority: priority)
}

public func ConstrainMinimumViewSize(view : View, size : CGSize, priority : LayoutPriority) {
    let metrics = ["width" : size.width, "height" : size.height]
    let bindings = ["view" : view]
    var formats = [String]()
    if size.width != SkipConstraint { formats += ["H:[view(>=width)]"] }
    if size.height != SkipConstraint { formats += ["V:[view(>=height)]"] }
    InstallLayoutFormats(formats: formats, options: SkipOptions, metrics: metrics, bindings: bindings, priority: priority)
}

public func ConstrainMaximumViewSize(view : View, size : CGSize, priority : LayoutPriority) {
    let metrics = ["width" : size.width, "height" : size.height]
    let bindings = ["view" : view]
    var formats = [String]()
    if size.width != SkipConstraint { formats += ["H:[view(<=width)]"] }
    if size.height != SkipConstraint { formats += ["V:[view(<=height)]"] }
    InstallLayoutFormats(formats: formats, options: SkipOptions, metrics: metrics, bindings: bindings, priority: priority)
}

// **************************************
// MARK: Positioning
// **************************************

// Constraining Positions
public func PositionView(view : View, point : CGPoint, priority : LayoutPriority) {
    if view.superview == nil {return}
    let metrics = ["hLoc" : point.x, "vLoc" : point.y]
    let bindings = ["view" : view]
    var formats = [String]()
    if point.x != SkipConstraint { formats += ["H:|-hLoc-[view]"] }
    if point.y != SkipConstraint { formats += ["V:|-vLoc-[view]"] }
    InstallLayoutFormats(formats: formats, options: SkipOptions, metrics: metrics, bindings: bindings, priority: priority)
}

public func ConstrainViewToSuperview(view : View, inset : Float, priority : LayoutPriority) {
    if view.superview == nil {return}
    let formats = [
        "H:|->=inset-[view]",
        "H:[view]->=inset-|",
        "V:|->=inset-[view]",
        "V:[view]->=inset-|"]
    InstallLayoutFormats(formats: formats, options: SkipOptions, metrics: ["inset" : inset], bindings: ["view" : view], priority: priority)
}

// **************************************
// MARK: Stretching
// **************************************

// Stretching to Superview
public func StretchViewHorizontallyToSuperview(view : View, inset : CGFloat, priority : LayoutPriority) {
    if view.superview == nil {return}
    let metrics = ["inset" : inset]
    let bindings = ["view" : view]
    let formats = ["H:|-inset-[view]-inset-|"]
    InstallLayoutFormats(formats: formats, options: SkipOptions, metrics: metrics, bindings: bindings, priority: priority)
}

public func StretchViewVerticallyToSuperview(view : View, inset : CGFloat, priority : LayoutPriority) {
    if view.superview == nil {return}
    let metrics = ["inset" : inset]
    let bindings = ["view" : view]
    let formats = ["V:|-inset-[view]-inset-|"]
    InstallLayoutFormats(formats: formats, options: SkipOptions, metrics: metrics, bindings: bindings, priority: priority)
}

public func StretchViewToSuperview(view : View, inset : CGSize, priority : LayoutPriority) {
    if view.superview == nil {return}
    if inset.width != SkipConstraint {
        StretchViewHorizontallyToSuperview(view: view, inset: inset.width, priority: priority)
    }
    if inset.height != SkipConstraint {
        StretchViewVerticallyToSuperview(view: view, inset: inset.height, priority: priority)
    }
}

// **************************************
// MARK: Alignment
// **************************************

// Aligning
public func AlignViewInSuperview(view : View, attribute : NSLayoutAttribute, inset : CGFloat, priority : LayoutPriority) {
    if view.superview == nil {return}
    var actualInset : CGFloat
    switch attribute {
    case .left, .leading, .top:
        actualInset = inset * -1.0
    default:
        actualInset = inset
    }
    let superview = view.superview!
    let constraint = NSLayoutConstraint(item:superview, attribute:attribute, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: 1.0, constant: actualInset)
    constraint.priority = priority
    constraint.isActive = true
}

public func AlignViews(priority : LayoutPriority, view1 : View, view2 : View, attribute : NSLayoutAttribute) {
    let constraint : NSLayoutConstraint = NSLayoutConstraint(item: view1, attribute: attribute, relatedBy: .equal, toItem: view2, attribute: attribute, multiplier: 1, constant: 0)
    constraint.priority = priority
    constraint.isActive = true
}

// View to View Layout
public func CenterViewInSuperview(view : View, horizontal : Bool, vertical : Bool, priority : LayoutPriority) {
    if view.superview == nil {return}
    if horizontal { AlignViews(priority: priority, view1: view, view2: view.superview!, attribute: .centerX)}
    if vertical {AlignViews(priority: priority, view1: view, view2: view.superview!, attribute: .centerY)}
}

/// Constrain several views at once. Views are named view1, view2, view3...
public func ConstrainViews(priority : LayoutPriority, format : String, metrics : [String : Any]?, views : [View]) {
    
    // At least one view
    if views.count == 0 {return}
    
    // Install view names to bindings
    var bindings = [String : View]()
    bindings["view"] = views.first
    for (index, view) in (views).enumerated() {
        bindings["view\(index+1)"] = view
        view.autoLayoutEnabled = true
    }
    
    // Generate and install constraints with priority
    InstallLayoutFormats(formats: [format], options: SkipOptions, metrics: metrics, bindings: bindings, priority: priority)
}

public func ConstrainViews(priority : LayoutPriority, format : String, views : [View]) {
    ConstrainViews(priority: priority, format: format, metrics: nil, views: views)
}

public func ConstrainView(priority : LayoutPriority, format : String, metrics: [String : Any]?, view : View) {
    ConstrainViews(priority: priority, format: format, metrics: metrics, views: [view])
}

public func ConstrainView(priority : LayoutPriority, format : String, view : View) {
    ConstrainView(priority: priority, format: format, metrics: [String : Any](), view: view)
}

// **************************************
// MARK: iOS Layout Guides
// **************************************

// Working with Layout Guides. iOS Only
#if os(iOS)
public func StretchViewToTopLayoutGuide(controller : UIViewController, view : View, inset : Int, priority : LayoutPriority) {
    let metrics = ["vinset" : inset]
    let bindings = ["view" : view, "topGuide" : controller.topLayoutGuide as AnyObject]
    let formats = ["V:[topGuide]-vinset-[view]"]
    InstallLayoutFormats(formats: formats, options: SkipOptions, metrics: metrics, bindings: bindings, priority: priority)
}

public func StretchViewToBottomLayoutGuide(controller : UIViewController, view : View, inset : Int, priority : LayoutPriority) {
    let metrics = ["vinset" : inset]
    let bindings = ["view" : view, "bottomGuide" : controller.bottomLayoutGuide as AnyObject]
    let formats = ["V:[view]-vinset-[bottomGuide]"]
    InstallLayoutFormats(formats: formats, options: SkipOptions, metrics: metrics, bindings: bindings, priority: priority)
}

public func StretchViewToController(controller : UIViewController, view : View, inset : CGSize, priority : LayoutPriority) {
    StretchViewToTopLayoutGuide(controller: controller, view: view, inset: lrint(Double(inset.height)), priority: priority)
    StretchViewToBottomLayoutGuide(controller: controller, view: view, inset: lrint(Double(inset.height)), priority: priority)
    StretchViewHorizontallyToSuperview(view: view, inset: inset.width, priority: priority)
}

// UIViewController extended layout
extension UIViewController {
    public var useExtendedLayout : Bool {
        get {
            return !(edgesForExtendedLayout == .none)
        }
        set {
            edgesForExtendedLayout = newValue ? .all : []
        }
    }
}
#endif

// **************************************
// MARK: Hug / Resist
// **************************************

#if os(iOS)
public extension View {
    public var horizontalContentHuggingPriority : LayoutPriority {
        get {return contentHuggingPriority(for: .horizontal)}
        set { setContentHuggingPriority(newValue, for: .horizontal)}
    }
    public var verticalContentHuggingPriority : LayoutPriority {
        get {return contentHuggingPriority(for: .vertical)}
        set {setContentHuggingPriority(newValue, for: .vertical)}
    }
    public var contentHuggingPriority : LayoutPriority {
        get {print("This priority is write-only"); return 250} // meaningless
        set {
            setContentHuggingPriority(newValue, for: .horizontal)
            setContentHuggingPriority(newValue, for: .vertical)
        }
    }
    public var horizontalContentCompressionResistancePriority : LayoutPriority {
        get {return contentCompressionResistancePriority(for: .horizontal)}
        set {setContentCompressionResistancePriority(newValue, for: .horizontal)}
    }
    public var verticalContentCompressionResistancePriority : LayoutPriority {
        get {return contentCompressionResistancePriority(for: .vertical)}
        set {setContentCompressionResistancePriority(newValue, for: .vertical)}
    }
    public var contentCompressionResistancePriority : LayoutPriority {
        get {print("This priority is write-only"); return 750} // meaningless
        set {
            setContentCompressionResistancePriority(newValue, for: .horizontal)
            setContentCompressionResistancePriority(newValue, for: .vertical)
        }
    }
}

    #else

// OS X
public extension View {
    public var horizontalContentHuggingPriority : LayoutPriority {
        get {return contentHuggingPriorityForOrientation(.Horizontal)}
        set {setContentHuggingPriority(newValue, forOrientation: .Horizontal)}
    }
    public var verticalContentHuggingPriority : LayoutPriority {
        get {return contentHuggingPriorityForOrientation(.Vertical)}
        set {setContentHuggingPriority(newValue, forOrientation: .Vertical)}
    }
    public var contentHuggingPriority : LayoutPriority {
        get {println("This priority is write-only"); return 250} // meaningless
        set {
            setContentHuggingPriority(newValue, forOrientation: .Horizontal)
            setContentHuggingPriority(newValue, forOrientation: .Vertical)
        }
    }
    public var horizontalContentCompressionResistancePriority : LayoutPriority {
        get {return contentCompressionResistancePriorityForOrientation(.Horizontal)}
        set {setContentCompressionResistancePriority(newValue, forOrientation: .Horizontal)}
    }
    public var verticalContentCompressionResistancePriority : LayoutPriority {
        get {return contentCompressionResistancePriorityForOrientation(.Vertical)}
        set {setContentCompressionResistancePriority(newValue, forOrientation: .Vertical)}
    }
    public var contentCompressionResistancePriority : LayoutPriority {
        get {println("This priority is write-only"); return 750} // meaningless
        set {
            setContentCompressionResistancePriority(newValue, forOrientation: .Horizontal)
            setContentCompressionResistancePriority(newValue, forOrientation: .Vertical)
        }
    }
}
#endif


// --------------------------------------------------
// MARK: Placement utility
// --------------------------------------------------

public func PlaceViewInSuperview(view : View, position: String, inseth : CGFloat, insetv : CGFloat, priority : LayoutPriority) {
    if (position).characters.count != 2 { return }
    if view.superview == nil { return }

    view.autoLayoutEnabled = true

    let verticalPosition = position.substring(to: position.startIndex ) 
    let horizontalPosition = position.substring(from: position.startIndex)

    switch verticalPosition as String {
    case "t":
        AlignViewInSuperview(view: view, attribute: .top, inset: insetv, priority: priority)
    case "c":
        AlignViewInSuperview(view: view, attribute: .centerY, inset: insetv, priority: priority)
    case "b":
        AlignViewInSuperview(view: view, attribute: .bottom, inset: insetv, priority: priority)
    case "x":
        StretchViewVerticallyToSuperview(view: view, inset: insetv, priority: priority)
    default:
        break
    }

    switch horizontalPosition as String {
    case "l":
        AlignViewInSuperview(view: view, attribute: .leading, inset: inseth, priority: priority)
    case "c":
        AlignViewInSuperview(view: view, attribute: .centerX, inset: inseth, priority: priority)
    case "r":
        AlignViewInSuperview(view: view, attribute: .trailing, inset: inseth, priority: priority)
    case "x":
        StretchViewHorizontallyToSuperview(view: view, inset: inseth, priority: priority)
    default:
        break
    }
}

#if os(iOS)
public func PlaceView(controller : UIViewController, view : View, position : String, inseth : CGFloat, insetv : CGFloat, priority : LayoutPriority) {
    view.autoLayoutEnabled = true
    if view.superview == nil {controller.view .addSubview(view)}

    if (position).characters.count != 2 { return }
    var verticalPosition = position.substring(to: position.startIndex ) 
    var horizontalPosition = position.substring(from: position.startIndex)
    
    // Handle the two stretching cases
    if position.hasPrefix("x") {
        StretchViewToTopLayoutGuide(controller: controller, view: view, inset: lrint(Double(insetv)), priority: priority)
        StretchViewToBottomLayoutGuide(controller: controller, view: view, inset: lrint(Double(insetv)), priority: priority)
        verticalPosition = "-"
    }

    if position.hasSuffix("x") {
        StretchViewHorizontallyToSuperview(view: view, inset: inseth, priority: priority)
        horizontalPosition = "-"
    }
    
    if position == "xx" {return}

    // Otherwise just place in superview
    PlaceViewInSuperview(view: view, position: (verticalPosition + horizontalPosition), inseth: inseth, insetv: insetv, priority: priority)
}
#endif

// **************************************
// MARK: Inspection
// **************************************

public var ViewNameKey = "ViewNameKey"
public extension NSObject {
    public var objectClassName : String {
        return "\(type(of: self))"
    }
    public var addressString : String {
        get {return NSString(format: "%p", self) as String}
    }
    public var debugName : String {
        return objectClassName + ":" + addressString
    }
}
public extension View {
    public var viewName : String? {
        get {return objc_getAssociatedObject(self, &ViewNameKey) as? String}
        set { objc_setAssociatedObject(self, &ViewNameKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
        
    }
    public var debugViewName : String {
        get {
            if objectClassName.hasPrefix("_UI") {
                let index = objectClassName.index(objectClassName.startIndex, offsetBy: 3)
                return objectClassName.substring(from: index) 
            }
            if objectClassName.hasPrefix("_NS") {
                let index = objectClassName.index(objectClassName.startIndex, offsetBy: 3)
                return objectClassName.substring(from: index)
            }
                
            return objectClassName + ":" + (viewName ?? addressString)
        }
    }
}

public extension NSLayoutConstraint {
    public var descriptionWithViewNames : String {
        var string : String = description 

        string = string.replacingOccurrences(of: debugName + " ", with: "")

        if let viewName = firstView.viewName {
            string = string.replacingOccurrences(of: firstView.addressString, with: "\"" + viewName + "\"") 
        }

        if firstView.objectClassName.hasPrefix("_UI") {
            let index = firstView.objectClassName.index(objectClassName.startIndex, offsetBy: 3)
            let visible = firstView.objectClassName.substring(from: index)
            string = string.replacingOccurrences(of: firstView.debugName, with: visible) 
        }

        if let secondView = secondView {
            if let viewName = secondView.viewName {
                string = string.replacingOccurrences(of: secondView.addressString, with: "\"" + viewName + "\"")
            }
            
            if secondView.objectClassName.hasPrefix("_UI") {
                let index = secondView.objectClassName.index(objectClassName.startIndex, offsetBy: 3)
                
                let visible = secondView.objectClassName.substring(from: index)
                string = string.replacingOccurrences(of: secondView.debugName, with: visible)
            }
        }

        // return className + ": " + (string as String)
        return string as String
    }
}

public func AddConstraint(request : String, view1 : View, view2 : View, m : CGFloat, c : CGFloat, priority : LayoutPriority) {
    var components = [String]()
    for separator in [".", " "] {
        components = request.components(separatedBy: separator) 
            //.componentsSeparatedByString(separator)
        if (components).count == 3 { break }
    }
    
    if (components).count != 3 {
        for separator in ["<=", "==", ">=", "<", "=", ">"] {
            components = request.components(separatedBy:separator)
            if (components).count == 2 {
                components = [components[0], separator, components[1]]
                break
            }
        }
    }
    
    if (components).count != 3 {
        print("Add constraint format error: "+request)
        return
    }
    
    let firstAttributeString = components[0].lowercased()
    let secondAttributeString = components[2].lowercased()
    
    let index = components[1].index(components[1].startIndex, offsetBy: 1)
    let relationString = components[1].substring(from: index)
    
    #if os(iOS)
        let attributes : [String : NSLayoutAttribute] = [
        "l":.left, "r":.right, "t":.top, "b":.bottom,
        "cx":.centerX, "cy":.centerY,"w":.width,"h":.height,
        "left":.left, "right":.right, "top":.top, "bottom":.bottom,
        "leading":.leading, "trailing":.trailing, "width":.width, "height":.height,
        "centerx":.centerX, "centery":.centerY,
        "leftmargin":.leftMargin, "rightmargin":.rightMargin,
        "topmargin":.topMargin, "bottommargin":.bottomMargin,
        "leadingmargin":.leadingMargin, "trailingmargin":.trailingMargin,
        "centerxmargin":.centerXWithinMargins, "centerymargin":.centerYWithinMargins,
        "lastbaseline": .lastBaseline, "firstbaseline":.firstBaseline,
        "notanattribute":.notAnAttribute, "_":.notAnAttribute,
        "_naa_":.notAnAttribute, "skip":.notAnAttribute,
        ]
        #else
        let attributes : [String : NSLayoutAttribute] = [
            "l":.left, "r":.right, "t":.top, "b":.bottom,
            "cx":.centerX, "cy":.centerY,"w":.width,"h":.height,
            "left":.left, "right":.right, "top":.top, "bottom":.bottom,
            "leading":.leading, "trailing":.trailing, "width":.width, "height":.height,
            "centerx":.centerX, "centery":.centerY,
            "lastbaseline": .lastBaseLine,
            "notanattribute":.notAnAttribute, "_":.notAnAttribute,
            "_naa_":.notAnAttribute, "skip":.notAnAttribute,
        ]
    #endif
    
    let relations : [String : NSLayoutRelation] = [
        "<":.lessThanOrEqual, "=":.equal, ">":.greaterThanOrEqual]
    
    let firstAttribute = attributes[firstAttributeString] ?? .notAnAttribute
    let secondAttribute = attributes[secondAttributeString] ?? .notAnAttribute
    let relation = relations[relationString] ?? .equal
    
    let constraint = NSLayoutConstraint(item: view1, attribute: firstAttribute, relatedBy: relation, toItem: view2, attribute: secondAttribute, multiplier: m, constant: c)
    
    constraint.priority = priority
    constraint.isActive = true
}

public extension View {
    public func dumpViewsAtIndent(indent : Int) {

        if objectClassName.hasPrefix("_UI") {return}

        // indent and print view
        for _ in 0..<indent {print("----")}
        print("[\(debugViewName) \(frame)")
        if tag != 0 {print(" tag: \(tag)")}

        // Hugging and resistance
        // print(" Hug:(\(horizontalContentHuggingPriority), \(verticalContentHuggingPriority))")
        // print(" Res:(\(horizontalContentCompressionResistancePriority), \(verticalContentCompressionResistancePriority))")

        // Count and references
        if viewConstraints.count > 0 {print(" constraints: \(viewConstraints.count)")}
        if constraintsReferencingView.count > 0 {print(" references: \(constraintsReferencingView.count)")}

        print("]")

        // Enumerate the constraints
        for (index, constraint) in (viewConstraints).enumerated() {
            for _ in 0..<indent {print("    ")} // indentation
            print("    \(index + 1). \(constraint.descriptionWithViewNames)")
        }

        // Recurse
        for subview in subviews {
            subview.dumpViewsAtIndent(indent: indent + 1)
        }
    }

    public func dumpViews() {
        dumpViewsAtIndent(indent: 0)
    }
}

