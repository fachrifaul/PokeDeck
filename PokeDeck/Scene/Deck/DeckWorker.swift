//
//  DeckWorker.swift
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

class DeckWorker
{
     typealias DeckPokemonHandler = (Bool, [Pokemon])->Void
    
    func fetchPokemon(_ completionHandler: DeckPokemonHandler?)
  {
    let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
    
    var pokemon = [Pokemon]()
    do {
        let csv = try CSV(contentsOfURL: path)
        let rows = csv.rows
        
        for row in rows {
            let pokeId = Int(row["id"]!)!
            let name = row["identifier"]!
            
            var poke = Pokemon()
            poke.name = name
            poke.pokedexId = pokeId
            
            pokemon.append(poke)
        }
        
        completionHandler?(true, pokemon)
    } catch let err as NSError{
        print(err.debugDescription)
        completionHandler?(false, [])
    }
  }
}