//
//  AddBetViewController.swift
//  WannaBetiOS
//
//  Created by Jaime Becker on 2/8/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class AddBetViewController: UIViewController {
    
    
    @IBOutlet weak var betTitleTextField: UITextField!
    @IBOutlet weak var betQuestionTextField: UITextField!
    
    let db = Firestore.firestore()
    
    var userChoice = "No"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func enterPressed(_ sender: UIButton) {
        // Send data
        if let betTitle = betTitleTextField.text, let betQuestion = betQuestionTextField.text,let user = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data:[
                K.FStore.userField: user, K.FStore.betTitleField: betTitle,
                K.FStore.betQuestionField: betQuestion,
                K.FStore.betUserChoiceField: userChoice
            ]) { (error) in
                if let e = error{
                    print("ERROR: Issue saving to Firestore: \(e)")
                }else{
                    print("SUCCESS!")
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
}
