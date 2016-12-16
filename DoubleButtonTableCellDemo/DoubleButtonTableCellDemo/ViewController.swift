//
//  ViewController.swift
//  DoubleButtonTableCellDemo
//
//  Created by Christian Schraga on 12/16/16.
//  Copyright © 2016 Straight Edge Digital. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DoubleButtonCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let dummyData = ["Stark", "Targaeryan", "Boratheon", "Martell", "Lannister", "Tyrell", "Walder Frey"]
    let identifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.register(DoubleButtonTableViewCell.self, forCellReuseIdentifier: identifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cell = result as? DoubleButtonTableViewCell {
            
            var text = "No Title"
            if indexPath.row < dummyData.count {
                text = dummyData[indexPath.row]
                cell.color = indexPath.row % 3 == 0 ? UIColor.lightGray : UIColor.darkGray
                cell.load(text: text, indexPath: indexPath, buttonDelegate: self, leftButtonImage: UIImage(named:"clearButton"), rightButtonImage: UIImage(named:"rightCircleCarat"))
                
            }
            
            return cell
        }
        return result
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell clicked at row:\(indexPath.row) but didn't click button")
    }
    
    //Delegate from Cell
    func doubleButtonCell(cell: DoubleButtonTableViewCell, buttonClicked: DoubleButtonType) {
        if let row = cell.indexPath{
            print("cell in row:\(row) clicked the \(buttonClicked == .left ? "left" : "right") button")
        } else {
            print("button clicked but row not set")
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

