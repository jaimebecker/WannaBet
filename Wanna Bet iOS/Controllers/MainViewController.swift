//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var bets: [Bet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        
        loadMessages()
    }
    
    /* Loads messages into the table view on the main view*/
    func loadMessages(){
        db.collection(K.FStore.collectionName).addSnapshotListener { (querySnapshot, error) in
            self.bets = []
            if let e = error {
                print("ERROR: Issue retrieving from data store: \(e)")
            }else{
                if let snapshotDocuments = querySnapshot?.documents{
                    // Iterate through data in db
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let title = data[K.FStore.betTitleField] as? String, let question = data[K.FStore.betQuestionField] as? String{
                            
                            let bet = Bet(betTitle: title, betQuestion: question)
                            self.bets.append(bet)
                            
                            // Need to add the DispatchQueue part when updating UI in a closure
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    /* Couldn't figure out how to attach this action to the tab on tab bar??
     so just made it a separate button for now ¯\_(ツ)_/¯ */
    @IBAction func addButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.Segues.mainToAddBet, sender: self)
    }
    
}

extension ChatViewController: UITableViewDataSource{
    /* How many rows in table view*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bets.count
    }
    
    /* What each row has in table*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Give cell for table view
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Table.cell, for: indexPath)
        
        // Give it the bet title name
        cell.textLabel?.text = bets[indexPath.row].betTitle
        return cell
    }
    
    
}

extension ChatViewController: UITableViewDelegate{
    /* Method for later -- what happens when you select a row*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
