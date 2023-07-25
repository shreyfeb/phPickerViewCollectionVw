//
//  ViewController.swift
//  phPickerViewCollectionVw
//
//  Created by Shrey Shah on 7/8/23.
//

import UIKit
import PhotosUI

class ViewController: UIViewController{

    
    @IBOutlet weak var photoCollectionview: UICollectionView!
    
    var selectedImage = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btnAddImage(_ sender: UIBarButtonItem) {
        var imagePickerConfig = PHPickerConfiguration()
        imagePickerConfig.selectionLimit = 4
        
        let phPickerVC = PHPickerViewController(configuration: imagePickerConfig)
        phPickerVC.delegate = self
        self.present(phPickerVC, animated: true)
    }
    

    
    
}
extension ViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                if let image = object as? UIImage{
                    print(image)
                    self.selectedImage.append(image)
                }
                DispatchQueue.main.async {
                    self.photoCollectionview.reloadData()
                }
            }
        }
    }
    
    
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? photoCell else{
            return UICollectionViewCell()
        }
        Cell.imgShowPreview.image = selectedImage[indexPath.row]
        return Cell
    }
}
extension ViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width / 3 - 1, height: collectionView.frame.size.height/5 - 1 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
