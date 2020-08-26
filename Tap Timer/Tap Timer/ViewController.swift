//
//  ViewController.swift
//  Tap Timer
//
//  Created by Bryan Smith on 8/26/20.
//

import UIKit
import CoreData
import SwiftUI

class ViewController: UIViewController {
    
    @ObservedObject var stopWatchManager = StopWatchManager()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stopwatchLabel: UILabel!
    @IBOutlet weak var stopwatchButtonOutlet: UIButton!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items:[Solve]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        stopwatchLabel.text = String(format: "%.2f", stopWatchManager.secondsElapsed)
        
        fetchsolves()
    }
    
    @IBAction func stopwatchButton(_ sender: Any) {
        if stopWatchManager.mode == .stopped {
            stopWatchManager.start()
            stopwatchButtonOutlet.setTitle("Stop", for: .normal)
        }
        if stopWatchManager.mode == .running {
            stopWatchManager.pause()
            stopwatchButtonOutlet.setTitle("Reset", for: .normal)
        }
        if stopWatchManager.mode == .paused {
            stopWatchManager.stop()
            stopwatchButtonOutlet.setTitle("Start", for: .normal)
            self.fetchsolves()
        }
        stopwatchButtonOutlet.setNeedsDisplay()
    }
    
    func fetchsolves() {
        // Fetch data from CoreData to display in the TableView
        do {
            self.items = try context.fetch(Solve.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
 
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SolveCell", for: indexPath)
        
        // get solve from array and set the label
        
        let solve = self.items![indexPath.row]
        
        cell.textLabel?.text = String(solve.solveTime)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // selected solve
        let solve = self.items![indexPath.row]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let solveDate = formatter.string(from: solve.solveDate!)
        let solveTime = String(solve.solveTime)
        
        // create alert
        _ = UIAlertController(title: solveDate, message: solveTime, preferredStyle: .alert)

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
        
            // which solve to remove
            let solveToRemove = self.items![indexPath.row]
            
            // remove the solve
            self.context.delete(solveToRemove)
            
            // save the data
            do {
                try self.context.save()
            } catch {
                
            }
            
            // refetch the data
            self.fetchsolves()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}

