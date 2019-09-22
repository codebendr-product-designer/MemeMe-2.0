//
//  TableViewController.swift
//  MemeMe 2.0
//
//  Created by codebendr on 20/09/2019.
//  Copyright © 2019 just pixel. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMemeButtonPressed))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
         tabBarController?.tabBar.isHidden = false
    }
    
    @objc func addMemeButtonPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EditMemeViewController") as! EditMemeViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

// MARK: - UITableViewDelegate
extension TableViewController  {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewController.meme = memes[indexPath.row]
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Table view data source
extension TableViewController {
    
    //    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return UITableView.automaticDimension
    //    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableViewCell
        
        cell.meme = memes[indexPath.row]
        
        return cell
    }
    
}
