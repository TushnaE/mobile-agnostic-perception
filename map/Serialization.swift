//
//  Serialization.swift
//  map (iOS)
//
//  Created by Davon Prewitt on 2/28/21.
//

import ARKit
import Foundation


func _bufferToOCVMAT(buffer : CVPixelBuffer) -> Map_Proto_OCVMat {
    let proto = Map_Proto_OCVMat()

    // Lock address to be thread safe.
    CVPixelBufferLockBaseAddress(buffer, 0)

    // Collect metadata
    let width = CVPixelBufferGetWidth(buffer)
    let height = CVPixelBufferGetHeight(buffer)
    let data = CVPixelBufferGetBaseAddress(buffer)

    // Assign data
    proto.rows = width
    proto.cols = height
    proto.size = width * height
    // TODO(davonprewitt): Convert YUV to RGB.
    memcpy(data, proto.data, proto.size * 4)
    
    // TODO(davonprewitt): Assign type.

    // Remove memory lock.
    CVPixelBufferUnlockBaseAddress(buffer, 0)

    return proto
}

func arFrameToOCVMat(frame : ARFrame) -> Map_Proto_OCVMat {
    return _bufferToOCVMAT(buffer: frame.capturedImage)
}

func arDepthMapToOCVMat(depthMap : ARDepthData) -> Map_Proto_OCVMat {
    return _bufferToOCVMAT(buffer: depthMap.depthMap)
}

func arPointCloudToPointCloud(pointCloud : ARPointCloud) -> Map_Proto_PointCloud {
    let proto = Map_Proto_PointCloud()
    for point in pointCloud.points {
        let vec = Map_Proto_Point()
        vec.location.x = point.x
        vec.location.y = point.y
        vec.location.z = point.z
        // Note: Intensity is not included in ARKit.
        proto.points.append(vec)
    }
    return vec
}
