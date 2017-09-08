//
//  WNDebugTool.swift
//  Wannar
//
//  Created by 付国良 on 2017/3/9.
//  Copyright © 2017年 玩哪儿. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

func wn_debugMessage(_ message: String) {
    if let keyWindow = UIApplication.shared.keyWindow {
        keyWindow.makeToast(message, duration: 3.0, position: .top)
    }
}


func wn_deinitMessage(_ message: String) {
    wn_debugMessage(message + "销毁")
}



func wn_print<T>(_  items: T,
                    file: String? = nil,
                    method: String? = nil,
                    line: Int? = nil) {
    var message: String = ""
    if let file = file {
        message = message + "##########[ File ]##########\n" + file + "\n\n"
    }
    if let method = method {
        message = message + "##########[ Method ]##########\n" + method + "\n\n"
    }
    if let line = line {
        message = message + "##########[ Line ]##########\n" + String(line) + "\n\n"
    }
    if message != "" {
        message = "\(message)##########[ Message ]##########\n\(items)"
        print("\n===============================\n\n\(message)\n\n===============================\n")
    } else {
        print("\n===============================\n\n\(items)\n\n===============================\n")
    }
    
}



/// Memory Usage
///
/// - Returns: Use of memory in 'M'
func memoryUsage() -> Float? {
    
    var info = mach_task_basic_info()
    var count = mach_msg_type_number_t(MemoryLayout.size(ofValue: info) / MemoryLayout<integer_t>.size)
    let kerr = withUnsafeMutablePointer(to: &info) { infoPtr in
        return infoPtr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { (machPtr: UnsafeMutablePointer<integer_t>) in
            return task_info(mach_task_self_,
                             task_flavor_t(MACH_TASK_BASIC_INFO),
                             machPtr,
                             &count)
        }
    }
    guard kerr == KERN_SUCCESS else {
        return nil
    }
    return Float(info.resident_size) / (1024 * 1024)
}



/// CPU usage
///
/// - Returns: Use of CPU in 'M'
func cpuUsage() -> Float {
    let basicInfoCount = MemoryLayout<mach_task_basic_info_data_t>.size / MemoryLayout<natural_t>.size
    
    var kern: kern_return_t
    
    var threadList = UnsafeMutablePointer<thread_act_t>.allocate(capacity: 1)
    var threadCount = mach_msg_type_number_t(basicInfoCount)
    
    var threadInfo = thread_basic_info.init()
    var threadInfoCount: mach_msg_type_number_t
    
    var threadBasicInfo: thread_basic_info
    var threadStatistic: UInt32 = 0
    
    kern = withUnsafeMutablePointer(to: &threadList) {
        $0.withMemoryRebound(to: (thread_act_array_t?.self), capacity: 1) {
            task_threads(mach_task_self_, $0, &threadCount)
        }
    }
    if kern != KERN_SUCCESS {
        return -1
    }
    
    if threadCount > 0 {
        threadStatistic += threadCount
    }
    
    var totalUsageOfCPU: Float = 0.0
    
    for i in 0..<threadCount {
        threadInfoCount = mach_msg_type_number_t(THREAD_INFO_MAX)
        
        kern = withUnsafeMutablePointer(to: &threadInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                thread_info(threadList[Int(i)], thread_flavor_t(THREAD_BASIC_INFO), $0, &threadInfoCount)
            }
        }
        if kern != KERN_SUCCESS {
            return -1
        }
        
        threadBasicInfo = threadInfo as thread_basic_info
        
        if threadBasicInfo.flags & TH_FLAGS_IDLE == 0 {
            totalUsageOfCPU = totalUsageOfCPU + Float(threadBasicInfo.cpu_usage) / Float(TH_USAGE_SCALE) * 100.0
        }
    }
    
    return totalUsageOfCPU
}


/// Show FPS
///
/// - Parameters:
///   - frame: CGRect
///   - toView: add to some view, default add to key window
func wn_showFPS(frame: CGRect = CGRect.init(x: 15, y: UIScreen.main.bounds.size.height - 80.0, width: 60.0, height: 25.0), toView: UIView? = UIApplication.shared.keyWindow) -> Void {
    
    let fpsLabel = WNFPSLabel.init(frame: frame)
    
    if let toView = toView {
        if toView.isKind(of: UIView.classForCoder()) {
            toView.addSubview(fpsLabel)
        } else {
            wn_print("toView Is Not Belong UIView Class")
        }
    } else {
        wn_print("toView Is Not Exist")
    }
}


/// FPSLabel
class WNFPSLabel: UILabel {
    
    private var link: CADisplayLink?
    private var count: Int = 0
    private var lastTime: TimeInterval = 0
    private var defaultSize: CGSize = CGSize.init(width: 60.0, height: 25.0)
    
    override init(frame: CGRect) {
        
        var targetFrame = frame
        if frame.size.width == 0 && frame.size.height == 0{
            targetFrame.size = defaultSize
        }
        
        super.init(frame: targetFrame)
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
        self.textAlignment = .center
//        self.isUserInteractionEnabled = false
        self.textColor = UIColor.white
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.7)
        self.font = UIFont.systemFont(ofSize: 14)
        
        weak var weakSelf = self
        link = CADisplayLink.init(target: weakSelf ?? self, selector: #selector(WNFPSLabel.tick(link:)))
        link?.add(to: RunLoop.main, forMode: .commonModes)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tick(link: CADisplayLink) {
        if lastTime == 0 {
            lastTime = link.timestamp
            return
        }
        count += 1
        
        let delta = link.timestamp - lastTime
        if delta < 1 {
            return
        }
        lastTime = link.timestamp
        
        let fps = Double(count) / delta
        count = 0
        
        let progress = fps / 60.0;
        self.textColor = UIColor(hue: CGFloat(0.27 * ( progress - 0.2 )) , saturation: 1, brightness: 0.9, alpha: 1)
        self.text = "\(Int(fps+0.5)) FPS"
    }
    
    deinit {
        link?.invalidate()
    }
}
