//
//  DetailWorker.swift
//  PokeDeck
//
//  Created by Fachri Work on 7/27/17.
//  Copyright (c) 2017 Decadev. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailWorker
{
    
    typealias DetailPokemonHandler = (Bool, Pokemon)->Void
    
    func fetchPokemonDetail(_ pokeId: String, completionHandler: DetailPokemonHandler?)
    {
        
        let apiUrl =  "\(URL_BASE)\(URL_POKEMON)\(pokeId)/"
        
        Alamofire.request(apiUrl).responseJSON { response in
            
            if let jsonValue = response.result.value {
                
                let json = JSON(jsonValue)
                var pokemon = Pokemon()
                
                if let name = json["name"].string{
                    pokemon.name = name
                }
                if let pokedexId = json["pkdx_id"].int{
                    pokemon.pokedexId = pokedexId
                }
                if let weight = json["weight"].string{
                    pokemon.weight = weight
                }
                if let height = json["height"].string{
                    pokemon.height = height
                }
                if let attack = json["attack"].int{
                    pokemon.attack = "\(attack)"
                }
                if let defense = json["defense"].int{
                    pokemon.defense = "\(defense)"
                }
                
                if let types = json["types"].array{
                    
                    if types.count>1 {
                        for type in types{
                            if let name = type["name"].string{
                                pokemon.type += "\(name.capitalized)/"
                            }
                        }
                    } else {
                        if let name = types[0]["name"].string{
                            pokemon.type = name.capitalized
                        }
                    }
                }
                
                
                if let evolutions = json["evolutions"].array {
                    if evolutions.count>0{
                        
                        if let nextEvolution = evolutions[0]["to"].string{
                            
                            if nextEvolution.range(of: "mega")==nil{
                                pokemon.nextEvolutionName = nextEvolution
                                
                                if let uri = evolutions[0]["resource_uri"].string{
                                    let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon", with: "")
                                    let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                    
                                    pokemon.nextEvolutionId = nextEvoId
                                    
                                    if let level = evolutions[0]["level"].int{
                                        pokemon.nextEvolutionLevel = "\(level)"
                                    } else {
                                        pokemon.nextEvolutionLevel = ""
                                    }
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                if let desc = json["descriptions"].array{
                    
                    if desc.count > 0{
                        if let url = desc[0]["resource_uri"].string {
                            let descURL = "\(URL_BASE)\(url)"
                            print(descURL)
                            
                            Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                                if let descJsonValue = response.result.value{
                                    let descJson = JSON(descJsonValue)
                                    
                                    if let description = descJson["description"].string{
                                        let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                        
                                        pokemon.description = newDescription
                                        
                                        completionHandler?(true, pokemon)
                                    }
                                }
                                
                            })
                            
                        }
                    }
                    
                    
                }
                
                print(pokemon)
                
            }
            else {
                completionHandler?(false, Pokemon())
            }
            
        }
    }
}
