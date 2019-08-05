//
//  CameraViewController.swift
//  fakestagram
//
//  Created by Lòpez Estrada Arturo D3 on 27.04.2019.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation

class CameraViewController: UIViewController {
    
   // @IBOutlet weak var imageView: UIImageView!
    
    let client = CreatePostClient()
    //var imagePiker: UIImagePickerController!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        enableBasicLocationServices()

        // Do any additional setup after loading the view.
        
        //class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
        super.viewWillAppear(animated)
    }
    
    @IBAction func onTapCapture(_ sender: Any){
        choosePicture()
        print("posting....")
    }

@IBAction func onTapSnap(_ sender: UIButton){
    print("posting....")
    let img = UIImage(named: "cat")!
    createPost(img: img)
}

@objc func choosePicture(){
    let pikerController = UIImagePickerController()
    pikerController.allowsEditing = true
    pikerController.delegate = self
    
    let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    actionSheet.addAction(UIAlertAction(title: "Camara", style: .default, handler: { (action) in
        pikerController.sourceType = .camera
        self.present(pikerController, animated: true, completion: nil)
    }))
    
    actionSheet.addAction(UIAlertAction(title: "Biblioteca", style: .default, handler: { (action) in
        pikerController.sourceType = .photoLibrary
        self.present(pikerController, animated: true, completion: nil)
    }))
    
    actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
    present(actionSheet, animated: true, completion: nil)
}

func enableBasicLocationServices(){
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined:
        self.locationManager.requestWhenInUseAuthorization()
    case .restricted, .denied:
        print("Disable location features")
    case .authorizedWhenInUse, .authorizedAlways:
        print("Enable location features")
    }
}

func createPost(img: UIImage){
    guard let imgBase64 = img.encodedBase64() else {return}
    let timestamp = Date().currentTimestamp()
    client.create(title: String(timestamp), imageData: imgBase64, location: currentLocation) { post in
        print(post)
    }
}

}

extension CameraViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
    }
}

extension CameraViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:  [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage]as? UIImage else {return}
        //createPost(img: imagen)
        createPost(img: image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

//
//
//        func imagePikerController(_ piker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
//            imagePiker.dismiss(animated: true, completion: nil)
//            imageView.image = info[.originalImage] as? UIImage
//
//            guard let imgBase64 = imageView.image?.encodedBase64() else { return }
//            let payload = CreatePostBase64(title: "Tac - \(Date().currentTimestamp())",
//                image_data: imgBase64)
//            client.create(body: payload) { post in
//                print(post)
//
//        }
//        }
//
//    }
//
//
//    @IBAction func takePhoto(_ sender: Any){
//        imagePiker = UIImagePickerController()
//        imagePiker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
//        imagePiker.sourceType = .camera
//
//        present(imagePiker, animated:  true, completion: nil)
//    }
//
//
//
//    @IBAction func onTapSnap(_ sender: UIButton) {
////        guard let img = UIImage(named: "cat"),
////              let imgBase64 = img.encodedBase64() else { return }
////        let payload = CreatePostBase64(title: "Tac - \(Date().currentTimestamp())",
////            image_data: imgBase64)
////        client.create(body: payload) { post in
////            print(post)
////        }
//        print("post...")
//        let img = UIImage(named: "cat")!
//        (img: img)
//    }
//

