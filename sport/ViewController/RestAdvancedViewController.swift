//
//  RestAdvancedViewController.swift
//  sport
//
//  Created by PUTRI RAHMADEWI on 09/04/22.
//

import UIKit

class RestAdvancedViewController: UIViewController {
  
  var seconds = 20
  var timer = Timer()
  var resume = false
  
  
  @IBOutlet weak var countDown: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    start()
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
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RestAdvancedViewController.counter), userInfo: nil, repeats: true)
  }
  
  //Function Start Counter
  @objc func counter(){
    if seconds < 1{
      seconds = 20
      countDown.text = String(seconds)
      showActionsheet()
      timer.invalidate()
    }else{
      seconds -= 1
      countDown.text = String(seconds)
    }
    
  }
  
  
  
  @IBAction func skip(_ sender: UIButton) {
    showActionsheet()
  }
  
  
  func showActionsheet(){
    let actionSheet = UIAlertController(title: "Congratulation !! workout completed", message: "You still have your energy?", preferredStyle: .actionSheet)
    
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: { action in
    }))
    
    actionSheet.addAction(UIAlertAction(title: "Repeat workout", style: .default , handler: { action in
      self.navigationController?.popViewController(animated: true)
    }))
    
    actionSheet.addAction(UIAlertAction(title: "Choose another level", style: .destructive , handler: { action in
      self.performSegue(withIdentifier: "home", sender: nil)
    }))
    present(actionSheet, animated: true)
  }
}
