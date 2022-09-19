//
//  SecondViewController.swift
//  NikeApp
//
//  Created by MacBook on 16.09.2022.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,NSFetchedResultsControllerDelegate {
    
    var frc : NSFetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    var pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        let sorter = NSSortDescriptor(key: "price", ascending: false)
        fetchRequest.sortDescriptors = [sorter]
        return fetchRequest
    }
    
    func getFRC() -> NSFetchedResultsController<NSFetchRequestResult> {
        frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: pc, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        frc = getFRC()
        frc.delegate = self
        
        do{
            try frc.performFetch()
        } catch {
            print(error)
            return
        }
        self.tableView.reloadData()
        
        
        //getDatas()
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    /*
    func getDatas () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //çekme isteği oluşturuyoruz
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Products")
        fetchRequest.returnsObjectsAsFaults = false //büyük verilerle çalışınca kullanman lazım
        
        do {
            let sonuclar = try context.fetch(fetchRequest) //sonuclar dizisi geldi
            for sonuc in sonuclar as! [NSManagedObject] {
                let brandName = sonuc.value(forKey: "brandtext") as? String
            }
            
            
        } catch {
            print("hata var")
        }
        
        
    }
    */
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = frc.sections?[section].numberOfObjects
        return numberOfRows!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let dataRow = frc.object(at: indexPath) as! Entity
        cell.lblBrand.text = dataRow.brandtext
        cell.imagePhoto.image = UIImage(data: (dataRow.image)! as Data)
//        cell.imgPhoto.image = UIImage(data: (dataRow.image)! as Data)
        cell.lblDescription.text = dataRow.descriptiontext
        if let data_price = dataRow.price {
            cell.lblPrice.text = "$\(data_price)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let managedObject : NSManagedObject = frc.object(at: indexPath) as! NSManagedObject
        pc.delete(managedObject)
        
        do{
            try pc.save()
        }catch{
            print(error)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        if segue.identifier == "edit" {
            let selectedCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: selectedCell)
            let addPhotoVC : addPhotoViewController = segue.destination as! addPhotoViewController
            let selectedItem : Entity = frc.object(at: indexPath!) as! Entity
            addPhotoVC.selectedItem = selectedItem
        }
         */
        if segue.identifier == "goToDetails" {
            let selectedCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: selectedCell)
            let detailsVC : DetailsViewController = segue.destination as! DetailsViewController
            let selectedItem : Entity = frc.object(at: indexPath!) as! Entity
            detailsVC.selectedItem = selectedItem
        }

    }
    
    
}


/*
 //
 //  TableViewController.swift
 //  PhotoStore
 //
 //  Created by MacBook on 15.08.2022.
 //

 import UIKit
 import CoreData

 class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
     
     var frc : NSFetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
     var pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
     func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
         let sorter = NSSortDescriptor(key: "titletext", ascending: true)
         fetchRequest.sortDescriptors = [sorter]
         return fetchRequest
     }
     
     func getFRC() -> NSFetchedResultsController<NSFetchRequestResult> {
         frc = NSFetchedResultsController(fetchRequest: fetchRequest(), managedObjectContext: pc, sectionNameKeyPath: nil, cacheName: nil)
         return frc
     }
     
     
     override func viewDidLoad() {
         super.viewDidLoad()
         frc = getFRC()
         frc.delegate = self
         
         do{
             try frc.performFetch()
         } catch {
             print(error)
             return
         }
         self.tableView.reloadData()
         
         
     }

     override func numberOfSections(in tableView: UITableView) -> Int {
         return 1
     }

     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         let numberOfRows = frc.sections?[section].numberOfObjects
         return numberOfRows!
     }

     
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
         let dataRow = frc.object(at: indexPath) as! Entity
         cell.lblTitle.text = dataRow.titletext
         cell.lblDescription.text = dataRow.descriptiontext
         cell.imgPhoto.image = UIImage(data: (dataRow.image)! as Data)

         return cell
     }
     
     func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
         tableView.reloadData()
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "edit" {
             let selectedCell = sender as! UITableViewCell //seçileni uitableviewcell'e çevirdik
             let indexPath = tableView.indexPath(for: selectedCell)
             let addPhotoVC : addPhotoViewController = segue.destination as! addPhotoViewController
             let selectedItem : Entity = frc.object(at: indexPath!) as! Entity
             addPhotoVC.selectedItem = selectedItem
         }
     }
     
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         let managedObject : NSManagedObject = frc.object(at: indexPath) as! NSManagedObject
         pc.delete(managedObject)
         
         do{
             try pc.save()
         }catch{
             print(error)
         }

     }
     

 }
 */
