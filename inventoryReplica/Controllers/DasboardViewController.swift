//
//  DasboardViewController.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 24/07/23.
//

import Foundation
import Firebase

class DashboardViewController : UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var itemsLabel : UILabel!
    @IBOutlet weak var foldersLabel : UILabel!
    @IBOutlet weak var totalQtyLabel : UILabel!
    @IBOutlet weak var totalPricelabel : UILabel!
    
    let db = Firestore.firestore()
    let numOfRecentItems = 5
    var currentItem : Item?
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "itemCard")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        loadItems()
    }
    
    override open var shouldAutorotate: Bool {
            return false
        }
    
    func updateUI() {
        print("updating ui")
        let folderCount = 1
        
        totalPricelabel.text = String(format: "%.2f", ItemManager.totalPrice)
        foldersLabel.text = String(folderCount)
        itemsLabel.text = String(ItemManager.itemCount)
        totalQtyLabel.text = String(ItemManager.totalQuantity)
        
        collectionView.reloadData()
    }
    
    
    func loadItems() {
        ItemManager.queryItems { items in
            self.updateUI()
        }
    }
    
}


extension DashboardViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = ItemManager.items[indexPath.row]
        currentItem = item
        self.performSegue(withIdentifier: "DashboardToItemDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing!")
        if segue.identifier == "DashboardToItemDetails" {
            if let viewController = segue.destination as? ItemDetailsViewController, let item = currentItem {
                viewController.currentItem = item
            }
        }
        
    }
}

extension DashboardViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(numOfRecentItems)
        print(ItemManager.itemCount)
        print(ItemManager.items)
        return min(ItemManager.itemCount, numOfRecentItems)

        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sortedItemList = ItemManager.items.sorted(by: { $0.createdAt > $1.createdAt })
        let mostRecentItems = Array(sortedItemList.prefix(numOfRecentItems))
        
        let item = mostRecentItems[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCard", for: indexPath) as! ItemCollectionViewCell
        cell.configure(with: item)
        return cell
    }
    
    
}
