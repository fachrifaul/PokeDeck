//
//  DeckModels.swift
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

enum Deck
{
  // MARK: Use cases
  
  enum Pokedex
  {
    struct Request
    {
    }
    struct Response
    {
        var success: Bool
        var pokemon: [Pokemon]
    }
    struct ViewModel
    {
        var success: Bool
        var pokemon: [Pokemon]
    }
  }
}
