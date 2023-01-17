//
//  ViewController.swift
//  sport
//
//  Created by PUTRI RAHMADEWI on 09/04/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

    @IBOutlet weak var tableView: UITableView!
    var levelList = ["Beginner","Intermediate","Advanced"]
    
    var detail = ["40 seconds | 2 exercise","1 minutes | 2 exercise","1 minutes | 2 exercise"]
    var selectedRow :Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToWorkout"{
            let vc = segue.destination as! WorkoutViewController
            vc.continentIndex = selectedRow
            
            
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levelList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = levelList[indexPath.row]
        cell.detailTextLabel?.text = detail[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        cell.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 40, leading: 16, bottom: 16, trailing: 16)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workoutVC = WorkoutViewController()
//        workoutVC.customInit(continentIndex: indexPath.row, title: levelList[indexPath.row])
//
//        self.navigationController?.pushViewController(workoutVC, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
        selectedRow = indexPath.row
        performSegue(withIdentifier: "segueToWorkout", sender: nil)
        
    }
    
    @IBAction func backToHome(_ unwindSegue: UIStoryboardSegue) {
        
    }


}

