//
//  PlacesService.swift
//  TestVertagelab
//
//  Created by Anna Luchechko on 21.01.2021.
//

import Foundation
import Alamofire

class PlacesService {
    
    let url: String = "https://nc0aevq3i3.api.quickmocker.com/kyiv/places"//"https://2fjd9l3x1l.api.quickmocker.com/kyiv/places"
    
    func getPlaces(completion: @escaping (Places?, String) -> Void) {
        AF.request(url, method: .get, parameters: nil).responseJSON { response in
            guard let placesData = response.data else {
                completion(nil, response.error?.localizedDescription ?? "error not localized")
                return
            }
            
            do {
                let places = try JSONDecoder().decode(Places.self, from: placesData)
                completion(places, "")
            } catch {
                completion(nil, error.localizedDescription)
            }
        }
    }
}
    
