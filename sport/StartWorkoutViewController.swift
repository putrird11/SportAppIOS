//
//  StartWorkoutViewController.swift
//  sport
//
//  Created by PUTRI RAHMADEWI on 09/04/22.
//
import UIKit
import AVFoundation
import AVKit

class StartWorkoutViewController: UIViewController {
    
    var seconds = 40
    var timer = Timer()
    var resume = false
    var audioPlayer: AVAudioPlayer?
    var videoPlayer: AVPlayer?
    var playerLooper: AVPlayerLooper!
    var queuePlayer: AVQueuePlayer!
    let playerLayer = AVPlayerLayer()
    
    var playerLooper2: AVPlayerLooper!
    var queuePlayer2: AVQueuePlayer!
    let playerLayer2 = AVPlayerLayer()
    var videoPlayer2: AVPlayer?
    
    
    
    @IBOutlet weak var videoView2: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var countDown: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
        countDown.text = timeString(time: TimeInterval(seconds))
        video1()
    }
    
    func video1(){
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            guard let path = Bundle.main.path(forResource: "jumpingjack", ofType: "mp4") else {return }
            guard let path2 = Bundle.main.path(forResource: "pushup", ofType: "mp4") else {return }
            let url = URL(fileURLWithPath: path)
            let url2 = URL(fileURLWithPath: path2)
            
            let asset = AVAsset(url: url)
            let asset2 = AVAsset(url: url2)
            let playerItem = AVPlayerItem(asset: asset)
            let playerItem2 = AVPlayerItem(asset: asset2)
            
            queuePlayer = AVQueuePlayer(playerItem: playerItem)
            playerLayer.player = queuePlayer
            queuePlayer2 = AVQueuePlayer(playerItem: playerItem2)
            playerLayer2.player = queuePlayer2
            
            
            playerLayer.frame = videoView.bounds
            playerLayer2.frame = videoView2.bounds
            
            // Right Drawer
            //                        playerLayer.frame = CGRect (x: 21, y: 500, width: 300, height: 177)
            
            
            videoView.layer.addSublayer(playerLayer)
            videoView2.layer.addSublayer(playerLayer2)
            playerLooper2 = AVPlayerLooper(player: queuePlayer2, templateItem: playerItem2)
            playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
            queuePlayer.play()
            queuePlayer2.play()
            
        } catch {
            print(error)
        }
    }
    
    func audio(){
        let path = Bundle.main.path(forResource: "1-2-2-2", ofType:"wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print(error)
            // couldn't load file :(
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //fungsi start
    func start(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(StartWorkoutViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if seconds < 1{
            audio()
            seconds = 40
            countDown.text = timeString(time: TimeInterval(seconds))
            timer.invalidate()
            alert()
        }
        else{
            seconds -= 1
            countDown.text = timeString(time: TimeInterval(seconds))
            
        }
    }
    
    
    @IBAction func close(_ sender: UIButton) {
        pause()
        //        timer.invalidate()
        //                seconds = 60
        //                countDown.text = "60"
        showAlert()
        
    }
    
    @IBAction func unwind( _ sender: UIStoryboardSegue) {
        performSegue(withIdentifier: "unwind", sender: nil)
    }
    
    @IBAction func backToHom(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    
    
    func alert(){
        let alert = UIAlertController(title: "Time is up !!!", message: "You have completed the beginner workout", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Next", style: .destructive , handler: {  action in
            
            self.performSegue(withIdentifier: "toRestBeginner", sender: nil)
        }))
        
        present(alert, animated: true)
    }
    //
    
    func showAlert(){
        let alert = UIAlertController(title: "Are you sure?", message: "you current workout will end.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { [self] action in
            self.start()
            self.resume = false
        }))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive , handler: {  action in
            self.performSegue(withIdentifier: "homp", sender: nil)
        }))
        
        
        present(alert, animated: true)
    }
    
    func timeString(time: TimeInterval) -> String{
        let seconds = Int(time) % 60
        let minutes = Int(time) / 60 % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    //show action sheet
    //    func showActionsheet(){
    //        let actionSheet = UIAlertController(title: "Title", message: "you current workout will end.", preferredStyle: .actionSheet)
    //
    //        actionSheet.addAction(UIAlertAction(title: "Dismiss", style: .cancel , handler: { action in
    //            print("tapped Dismiss")
    //        }))
    //
    //        actionSheet.addAction(UIAlertAction(title: "One", style: .default , handler: { action in
    //            print("tapped Dismiss")
    //        }))
    //
    //        actionSheet.addAction(UIAlertAction(title: "Two", style: .default , handler: { action in
    //            print("tapped Dismiss")
    //        }))
    //
    //        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive , handler: { action in
    //            print("tapped Dismiss")
    //        }))
    //
    //        present(actionSheet, animated: true)
    //
    //    }
    
    
    @IBAction func pause(_ sender: UIButton) {
        pause()
        
    }
    
    @IBAction func mulai(_ sender: UIButton) {
        start()
    }
    
    
    func pause(){
        if self.resume == false {
            timer.invalidate()
            self.resume = true
        } else {
            self.resume = false
        }
    }
    
    
    
    
    
    
}
