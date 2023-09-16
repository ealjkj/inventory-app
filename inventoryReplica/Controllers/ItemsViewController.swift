//
//  SignupViewController.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 29/06/23.
//

import UIKit
import Floaty
import Firebase

class ItemsViewController: UIViewController {
    
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalQuantityLabel: UILabel!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var foldersLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    
    
    let db = Firestore.firestore()
    let floaty = Floaty()
    var currentPage = 0
    var currentItem : Item?
    let pageSize = 3
    let folderCount = 1
    var items = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        // Floaty Button
        floaty.sticky = true
        tableView.addSubview(floaty)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addPressed))
        floaty.addGestureRecognizer(tapGesture)
        floaty.isUserInteractionEnabled = true
        
        // Tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ItemFolderCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        loadItems()
        
    }
    
    
    func updateUI(){
        tableView.reloadData()
        
        // Left and Right Buttons
        if currentPage == 0 {
            leftButton.isPointerInteractionEnabled = false
            leftButton.isHidden = true
        } else {
            leftButton.isPointerInteractionEnabled = true
            leftButton.isHidden = false
        }
        
        if currentPage == Int(items.count / pageSize) {
            rightButton.isPointerInteractionEnabled = false
            rightButton.isHidden = true
        } else {
            rightButton.isPointerInteractionEnabled = true
            rightButton.isHidden = false
        }
        
        // Items summary
        totalValueLabel.text = String(format: "%.2f", ItemManager.totalPrice)
        foldersLabel.text = String(folderCount)
        itemsLabel.text = String(ItemManager.itemCount)
        totalQuantityLabel.text = String(ItemManager.totalQuantity)
        
    }
    
    func loadItems() {
        ItemManager.queryItems { newItems in
            self.items = newItems
            self.updateUI()
            print("items updated")
        }
    }
    
    @objc func addPressed() {
        self.performSegue(withIdentifier: "ItemsToAdd", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemsToAdd" {
            if let viewController = segue.destination as? AddItemViewController {
                viewController.delegate = self
            }
        }
        
        if segue.identifier == "ItemsToItemDetails" {
            if let viewController = segue.destination as? ItemDetailsViewController, let item = currentItem {
                viewController.currentItem = item
            }
        }
        
        
    }
    
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        currentPage -= 1
        updateUI()
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        currentPage += 1
        updateUI()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
    
}


extension ItemsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let firstIndex = currentPage*pageSize
        let endIndex = min(firstIndex + pageSize, items.count)
        return items[firstIndex..<endIndex].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemFolderCell
        
        let firstIndex = currentPage*pageSize
        let endIndex = min(firstIndex + pageSize, items.count)
        let pageItems = items[firstIndex..<endIndex]
        let item = pageItems[firstIndex+indexPath.row]
        cell.configure(with: item)
        
        return cell
    }
    

}

extension ItemsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = ItemManager.items[indexPath.row]
        currentItem = item
        self.performSegue(withIdentifier: "ItemsToItemDetails", sender: self)
    }
    
}

extension ItemsViewController : AddItemsDelegate {
    func didUpdateData() {
        loadItems()
//        tableView.reloadData()
    }
}
