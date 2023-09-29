//
//  ViewModel.swift
//  api
//
//  Created by Student16 on 12/09/23.
//
import Foundation

struct game: Codable, Identifiable {
    let id: Int?
    let title: String?
    let thumbnail: String?
    let short_description:String?
    let game_url:String?
    let genre: String?
    let platform: String?
    let publisher:String?
    let developer: String?
    let release_date: String?
    
    let freetogame_profile_url: String?
}
class ViewModel : ObservableObject {
    @Published var games : [game] = []
    func fetch(){
        guard let url = URL(string: "https://www.freetogame.com/api/games" ) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
            guard let data = data, error == nil else{
                return
            }
            do {
                let parsed = try JSONDecoder().decode([game].self, from: data)
                
                DispatchQueue.main.async {
                    self?.games = parsed
                }
            }catch{
                print(error)
            }
        }
        
        task.resume()
    }
    
    
}
