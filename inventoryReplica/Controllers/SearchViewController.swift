//
//  SearchViewController.swift
//  inventoryReplica
//
//  Created by ANGÉLICA ROSADO on 25/07/23.
//

import Foundation
import UIKit
import Firebase


class SearchViewController : UIViewController {
    let db = Firestore.firestore()
    var items = [Item]()
    var currentItem : Item?
    

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "itemCard")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        loadItems()
    }
    
    func loadItems() {
        ItemManager.queryItems { allItems in
            self.items = allItems
            self.updateUI()
        }
    }
    
    func updateUI() {
        collectionView.reloadData()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        if let searchPattern = searchBar.text {
            
            items =  ItemManager.items.filter { item in
                return item.containsPattern(searchPattern)
            }
            
            if searchPattern == "" {
                items = ItemManager.items
            }
            
            self.updateUI()
            
        } else {
            print("No pattern found")
        }
        
        
    }
    
}

extension SearchViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = ItemManager.items[indexPath.row]
        currentItem = item
        self.performSegue(withIdentifier: "SearchToItemsDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToItemsDetails" {
            if let viewController = segue.destination as? ItemDetailsViewController, let item = currentItem {
                viewController.currentItem = item
            }
        }
        
    }
}

extension SearchViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row  % items.count]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCard", for: indexPath) as! ItemCollectionViewCell
        cell.configure(with: item)
        return cell

    }
    
    
}
