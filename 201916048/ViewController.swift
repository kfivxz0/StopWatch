//
//  ViewController.swift
//  201916048
//
//  Created by 203a29 on 2022/06/10.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var TimeLable: UILabel!
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    
    var timer:Timer = Timer()
    var count:Int = 0
    var timerCounting:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStopButton.setTitleColor(UIColor.green, for: .normal)
        
    }

    @IBAction func resetTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Timer를 Reset 하시겠습니까?", message: "타이머를 재설정 하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel , handler: { (_)in
            //do nothing
        }))
        alert.addAction(UIAlertAction(title: "예", style: .default , handler: { (_)in
            self.count = 0
            self.timer.invalidate()
            self.TimeLable.text = self.maketimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("START",for: .normal)
            self.startStopButton.setTitleColor(UIColor.green, for: .normal)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func startStopTapped(_ sender: UIButton) {
        if(timerCounting)
        {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("START",for: .normal)
            startStopButton.setTitleColor(UIColor.green, for: .normal)
        }
        else{
            timerCounting = true
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerCounter() -> Void{
        
        count = count + 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = maketimeString(hours: time.0, minutes: time.1, seconds: time.2)
        TimeLable.text = timeString
    }
    
    
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> ( Int, Int, Int)
    {
        return ((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))
    }
    
    
    
    func maketimeString(hours: Int, minutes: Int, seconds: Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}
