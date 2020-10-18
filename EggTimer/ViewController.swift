import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var percentageLabel: UILabel!
    
    @IBOutlet weak var cookingTime1: UILabel!
    @IBOutlet weak var cookingTime2: UILabel!
    @IBOutlet weak var cookingTime3: UILabel!
    
    let eggTimes: [String: Float] = [
        "Soft": 270,
        "Medium": 350,
        "Hard": 420
    ]
    
    var cookingTime: Float = 0
    var secondsPassed: Float = 0
    var progress: Float = 0
    
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        playSound(soundName: "Rooster-Crowing")
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!

        cookingTime = eggTimes[hardness]!
        
        secondsPassed = 0
        progress = 0
        titleLabel.text = "Cooking time for \(hardness) is \(Int(cookingTime)) seconds..."
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        progress = secondsPassed / cookingTime
        progressLabel.text = String("\(Int(secondsPassed)) s")
        
        progressBar.progress = progress
        percentageLabel.text = "\(Int(progress * 100)) %"
        
        if secondsPassed < cookingTime {
            secondsPassed += 1
        } else {
            timer.invalidate()
            
            titleLabel.text = "Done !"
            
            playSound(soundName: "Rooster-Crowing")
        }
    }
    
    func initialise() {
        cookingTime1.text = String("\(eggTimes["Soft"]!) s")
        cookingTime2.text = String("\(eggTimes["Medium"]!) s")
        cookingTime3.text = String("\(eggTimes["Hard"]!) s")
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
