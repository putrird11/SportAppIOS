//
//  WorkoutViewController.swift
//  sport
//
//  Created by PUTRI RAHMADEWI on 09/04/22.
//

import UIKit

class WorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  
  @IBOutlet weak var tableView: UITableView!
  let detailList = [
    ["Jumping Jack","Push Up"],
    ["Bridge","Crunches"],
    ["Plank","Dead Bug"]
  ]
  
  let listWaktu = [
    ["20s","20s"],
    ["30s","30s"],
    ["30s","30s"]
  ]
  
  
  var continentIndex: Int = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if continentIndex == 0 {
      title = "Level: Beginner"
    }else if continentIndex == 1 {
      title = "Level: Intermediate"
    }else if continentIndex == 2{
      title = "Level: Advanced"
    }
    
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }
  
  @IBAction func buttonStart(_ sender: UIButton) {
    if continentIndex == 0 {
      performSegue(withIdentifier: "segueToBeginner", sender: nil)
    }else if continentIndex == 1 {
      performSegue(withIdentifier: "segueToAdvanced", sender: nil)
    }else if continentIndex == 2{
      performSegue(withIdentifier: "segueToExpert", sender: nil)
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return detailList[continentIndex].count
  }
  
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell", for: indexPath)
    cell.textLabel?.text = detailList[continentIndex][indexPath.row]
    cell.detailTextLabel?.text = listWaktu[continentIndex][indexPath.row]
    cell.accessoryType = .detailButton
    return cell
  }
  
}
