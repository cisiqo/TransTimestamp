//
//  ViewController.swift
//  TransTimestamp
//
//  Created by chengshq on 2019/6/27.
//  Copyright © 2019 chengshq. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var timer:Timer!
    
    @IBOutlet weak var currentTimestamp: NSTextField!
    @IBOutlet weak var stopBtn: NSButton!
    @IBOutlet weak var startBtn: NSButton!
    @IBOutlet weak var refreshBtn: NSButton!
    
    @IBOutlet weak var timestampText: NSTextField!
    @IBOutlet weak var transtotimeBtn: NSButton!
    @IBOutlet weak var datetimeText: NSTextField!
    
    @IBOutlet weak var yearText: NSTextField!
    @IBOutlet weak var monthText: NSTextField!
    @IBOutlet weak var dayText: NSTextField!
    @IBOutlet weak var hourText: NSTextField!
    @IBOutlet weak var minutesText: NSTextField!
    @IBOutlet weak var secondText: NSTextField!
    @IBOutlet weak var dateTimestampBtn: NSButton!
    @IBOutlet weak var timestampText2: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        currentTimestamp.stringValue = String(timeStamp)
        
        currentTimestamp.isSelectable = true
        timestampText2.isSelectable = true
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timestampTimer), userInfo: nil, repeats: true)
        
        stopBtn.action = #selector(stopTimestamp)
        refreshBtn.action = #selector(timestampTimer)
        startBtn.action = #selector(timerTimestamp)
        
        transtotimeBtn.action = #selector(transtoTime)
        dateTimestampBtn.action = #selector(dateTimestamp)
    }
    
    @objc func dateTimestamp() {
        let year = yearText.stringValue
        var month = monthText.stringValue
        var day = dayText.stringValue
        var hour = hourText.stringValue
        var minutes = minutesText.stringValue
        var second = secondText.stringValue
        
        if !year.isEmpty && Int(year) != 0 {
            if month.isEmpty || Int(month) == 0 {
                month = "12"
            }
            if day.isEmpty || Int(day) == 0 {
                if month == "1" || month == "01" || month == "3" || month == "03" || month == "5" || month == "05" || month == "7" || month == "07" || month == "8" || month == "08" || month == "10" || month == "12"  {
                    day = "31"
                }
                if month == "4" || month == "04" || month == "6" || month == "06" || month == "9" || month == "09" || month == "11"{
                    day = "30"
                }
                if month == "2" || month == "02" {
                    if Int(year) ?? 0 % 4 == 0 {
                        if Int(year) ?? 0 % 100 == 0 {
                            day = "28"
                        } else {
                            day = "29"
                        }
                    } else {
                        day = "28"
                    }
                }
            }
            if hour.isEmpty || Int(hour) == 0 {
                hour = "0"
            }
            if minutes.isEmpty || Int(minutes) == 0 {
                minutes = "0"
            }
            if second.isEmpty || Int(second) == 0 {
                second = "0"
            }
             let datetimeString:String = year + "/" + month + "/" + day + " " + hour + ":" + minutes + ":" + second
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
            let date = dformatter.date(from: datetimeString)
            let dateStamp:TimeInterval = date!.timeIntervalSince1970
            let dateStr:Int = Int(dateStamp)
            timestampText2.stringValue = String(dateStr)
        } else {
            timestampText2.stringValue = "Invaild year"
        }
    }
    
    @objc func transtoTime() {
        var timeStamp = Double(timestampText.stringValue) ?? 0
        if timeStamp != 0 {
            if timeStamp > 10000000000 {
                timeStamp = timeStamp / 1000
            }
            let timeInterval:TimeInterval = TimeInterval(timeStamp)
            let date = Date(timeIntervalSince1970: timeInterval)
            let dformatter = DateFormatter()
            dformatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
            datetimeText.stringValue = dformatter.string(from: date)
        }
    }
    
    @objc func timerTimestamp() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timestampTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timestampTimer() {
        let now = Date()
        let timeInterval:TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        currentTimestamp.stringValue = String(timeStamp)
    }
    
    @objc func stopTimestamp() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

