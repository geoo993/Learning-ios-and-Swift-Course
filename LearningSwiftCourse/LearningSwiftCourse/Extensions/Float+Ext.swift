//
//  Float+Ext.swift
//  ProjectStemCore
//
//  Created by GEORGE QUENTIN on 15/07/2018.
//  Copyright © 2018 Geo Games. All rights reserved.
//
import SceneKit
import simd

public extension float3 {

    public static func rayIntersectionWithHorizontalPlane(rayOrigin: float3,
                                                          direction: float3,
                                                          planeY: Float) -> float3? {

        let direction = simd_normalize(direction)

        // Special case handling: Check if the ray is horizontal as well.
        if direction.y == 0 {
            if rayOrigin.y == planeY {
                // The ray is horizontal and on the plane, thus all points on the ray intersect with the plane.
                // Therefore we simply return the ray origin.
                return rayOrigin
            } else {
                // The ray is parallel to the plane and never intersects.
                return nil
            }
        }

        // The distance from the ray's origin to the intersection point on the plane is:
        //   (pointOnPlane - rayOrigin) dot planeNormal
        //  --------------------------------------------
        //          direction dot planeNormal

        // Since we know that horizontal planes have normal (0, 1, 0), we can simplify this to:
        let dist = (planeY - rayOrigin.y) / direction.y

        // Do not return intersections behind the ray's origin.
        if dist < 0 {
            return nil
        }

        // Return the intersection point.
        return rayOrigin + (direction * dist)
    }
    
    public func toSCN() -> SCNVector3 {
        #if swift(>=4.0)
        return SCNVector3(self)
        #else
        return SCNVector3FromFloat3(self)
        #endif
    }
}

public extension FloatingPoint {
    public var toRadians: Self { return self * .pi / Self(180) }
    public var toDegrees: Self { return self * Self(180) / .pi }
    public var metersToLatitude : Self { return self / Self(6360500) }
    public var metersToLongitude : Self { return self / Self(5602900) }
}

public extension Float {
    public static func rand() -> Float {
        return Float(arc4random()) / Float(UInt32.max)
    }
    
    public static func random(min: Float, max: Float) -> Float {
        let rand = Float(arc4random()) / Float(UINT32_MAX)
        let minimum = min < max ? min : max
        return  rand * Swift.abs(Float( min - max)) + minimum
    }
}


extension float4x4 {
    public func toSCN() -> SCNMatrix4 {
        #if swift(>=4.0)
        return SCNMatrix4(self)
        #else
        return SCNMatrix4FromMat4(self.cmatrix)
        #endif
    }
}
