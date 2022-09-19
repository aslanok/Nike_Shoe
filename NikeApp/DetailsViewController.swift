//
//  DetailsViewController.swift
//  NikeApp
//
//  Created by MacBook on 18.09.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imgPhoto: UIImageView!
    var selectedNumber : String?
    var selectedItem : Entity? = nil
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapped1 = UITapGestureRecognizer(target: self, action: #selector(usrChose1))
        lbl1.isUserInteractionEnabled = true
        lbl1.addGestureRecognizer(tapped1)
        let tapped2 = UITapGestureRecognizer(target: self, action: #selector(usrChose2))
        lbl2.isUserInteractionEnabled = true
        lbl2.addGestureRecognizer(tapped2)
        let tapped3 = UITapGestureRecognizer(target: self, action: #selector(usrChose3))
        lbl3.isUserInteractionEnabled = true
        lbl3.addGestureRecognizer(tapped3)
        let tapped4 = UITapGestureRecognizer(target: self, action: #selector(usrChose4))
        lbl4.isUserInteractionEnabled = true
        lbl4.addGestureRecognizer(tapped4)
        let tapped5 = UITapGestureRecognizer(target: self, action: #selector(usrChose5))
        lbl5.isUserInteractionEnabled = true
        lbl5.addGestureRecognizer(tapped5)
        let tapped6 = UITapGestureRecognizer(target: self, action: #selector(usrChose6))
        lbl6.isUserInteractionEnabled = true
        lbl6.addGestureRecognizer(tapped6)
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = selectedItem?.brandtext
        lblBrand.text = selectedItem?.brandtext
        lblDescription.text = selectedItem?.descriptiontext
        imgPhoto.image = UIImage(data: (selectedItem?.image as! Data)) //Böyle kalmalı
        if let price = selectedItem?.price {
            lblPrice.text = "$\(price)"
        }
        
        
    }
    
    @objc func usrChose1() {
        lbl1.backgroundColor = .black
        lbl2.backgroundColor = .white
        lbl3.backgroundColor = .white
        lbl4.backgroundColor = .white
        lbl5.backgroundColor = .white
        lbl6.backgroundColor = .white
        selectedNumber = lbl1.text
    }
    @objc func usrChose2() {
        lbl2.backgroundColor = .black
        lbl1.backgroundColor = .white
        lbl3.backgroundColor = .white
        lbl4.backgroundColor = .white
        lbl5.backgroundColor = .white
        lbl6.backgroundColor = .white
        selectedNumber = lbl2.text
    }
    @objc func usrChose3() {
        lbl3.backgroundColor = .black
        lbl1.backgroundColor = .white
        lbl2.backgroundColor = .white
        lbl4.backgroundColor = .white
        lbl5.backgroundColor = .white
        lbl6.backgroundColor = .white
        selectedNumber = lbl3.text
    }
    @objc func usrChose4() {
        lbl4.backgroundColor = .black
        lbl1.backgroundColor = .white
        lbl2.backgroundColor = .white
        lbl3.backgroundColor = .white
        lbl5.backgroundColor = .white
        lbl6.backgroundColor = .white
        selectedNumber = lbl4.text
    }
    @objc func usrChose5() {
        lbl5.backgroundColor = .black
        lbl1.backgroundColor = .white
        lbl2.backgroundColor = .white
        lbl3.backgroundColor = .white
        lbl4.backgroundColor = .white
        lbl6.backgroundColor = .white
        selectedNumber = lbl5.text
    }
    @objc func usrChose6() {
        lbl6.backgroundColor = .black
        lbl1.backgroundColor = .white
        lbl2.backgroundColor = .white
        lbl3.backgroundColor = .white
        lbl4.backgroundColor = .white
        lbl5.backgroundColor = .white
        selectedNumber = lbl6.text
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let selectedNumber = selectedNumber {
            print(selectedNumber)
        }
        uyariVer()
    }
    
    func uyariVer() {
        let uyariMesaji : UIAlertController = UIAlertController(title: "Attention!", message: "Are you sure you want to add shoe size \(selectedNumber ?? "Hatali") to your shopping cart?  ", preferredStyle: UIAlertController.Style.alert)
        let okButton : UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
            //Ok butonuna basınca olacaklar
            print("ok butonuna tıklandı")
        }
            
        uyariMesaji.addAction(okButton)
        // burda kullaniciya uyari mesajı sunduk, animasyonlu mu olsun evet, tamamlanınca bir şey olsun mu hayır olmasın
        self.present(uyariMesaji, animated: true, completion: nil)
    }
    
}
