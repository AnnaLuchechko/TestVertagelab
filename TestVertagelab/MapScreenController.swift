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
        
    private var markers: [GMSMarker] = []
    private var placesData: Places?
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
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
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
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
        
        setupView()
        runSnapKitAutoLayout()
        
        // Get places from API
        PlacesService().getPlaces (completion: { [weak self] (places, error) in
            if(error.isEmpty) {
                self?.placesData = places
                self?.placeMarkers(places: places?.places ?? nil)
                self?.placesTableView.reloadData()
            } else {
                print(error)
            }
        })
    }
    
    private func placeMarkers(places: [Places.Place]?) {
        guard let places = places else { return }
        for place in places {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
            marker.title = place.name
            marker.map = googleMapView
            markers.append(marker)
        }
    }

    // Set email as emailTextField from LoginScreenController to MapScreenController
    func setTitle(newTitle: String) {
        emailTextField.text = newTitle
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(markers.count >= indexPath.row) {
            googleMapView.animate(toLocation: markers[indexPath.row].position)
        } else {
            print("marker not found")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placesData?.places.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.font = UIFont(name: "Noteworthy", size: 20.0)
        cell.textLabel!.text = "\(indexPath.row + 1). \(placesData?.places[indexPath.row].name ?? "")"
        return cell
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
            make.centerX.equalTo(view.snp.centerX)
        }
        
        placesTableView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.width)
            make.top.equalTo(googleMapView.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
}
