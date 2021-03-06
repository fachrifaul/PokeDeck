//
//  DetailInteractor.swift
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

protocol DetailBusinessLogic
{
    func loadPokemonDetail(request: Detail.PokeDex.Request)
}

protocol DetailDataStore
{
    var pokemon: Pokemon { get set }
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore
{
    
    var presenter: DetailPresentationLogic?
    var worker = DetailWorker()
    var pokemon = Pokemon()
    
    // MARK: Do load Pokemon
    
    func loadPokemonDetail(request: Detail.PokeDex.Request){
        worker.fetchPokemonDetail("\(self.pokemon.pokedexId)") {(success, pokemon) in
            let response = Detail.PokeDex.Response(success: success, pokemon:pokemon)
            self.presenter?.presentPokemonDetail(response: response)
        }
        
    }
}
