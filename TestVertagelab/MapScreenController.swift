//
//  MapScreenController.swift
//  TestVertagelab
//
//  Created by Anna Luchechko on 20.01.2021.
//

import UIKit
import SnapKit
import GoogleMaps

class MapScreenController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    private let myArray: NSArray = ["First","Second","Third"]
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter email"
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.backgroundColor = .clear
        textField.layer.cornerRadius = 8.0
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont(name: "Noteworthy", size: 20.0)
        textField.isEnabled = false
        return textField
    }()

    // Map view from GoogleMaps
    lazy var googleMapView: GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: 50.4467, longitude: 30.5101755, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect(), camera: camera)
        return mapView
    }()
    
    lazy var placesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        //title = "annaluchechko@gmail.com"
        
        setupView()
        runSnapKitAutoLayout()
        
        PlacesService().getPlaces (completion: { [weak self] (places, error) in
            print(places)
        })
    }
    
    private func setupView() {
        view.addSubview(googleMapView)
        view.addSubview(placesTableView)
        view.addSubview(emailTextField)

    }
    
    // Constraints via SnapKit
    private func runSnapKitAutoLayout() {
        emailTextField.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(40)
            make.top.equalTo(view.snp.topMargin)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        googleMapView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.width)
            make.top.equalTo(emailTextField.snp.bottom)
            //make.top.equalTo(view.snp.topMargin)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        placesTableView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.width)
            make.top.equalTo(googleMapView.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 50.450555, longitude: 30.5210808)
        marker.title = "Independence Square"
        marker.map = googleMapView
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.font = UIFont(name: "Noteworthy", size: 20.0)
        
        // "\(indexPath.row + 1)." - used for cell numeration (1.,2.,...)
        cell.textLabel!.text = "\(indexPath.row + 1). \(myArray[indexPath.row])"
    
        return cell
    }
    
}

