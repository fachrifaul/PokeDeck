//
//  DeckCell.swift
//  PokeDeck
//
//  Created by Fachri Work on 7/27/17.
//  Copyright © 2017 Decadev. All rights reserved.
//

import UIKit

class DeckCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLabel.text = self.pokemon.name.capitalized
        thumbnailImageView.image = UIImage(named: "\(self.pokemon.pokedexId)")
        
    }
}
