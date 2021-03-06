//
//  DetailViewController.swift
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

protocol DetailDisplayLogic: class
{
    func displayPokemon(viewModel: Detail.PokeDex.ViewModel)
}

class DetailViewController: UIViewController, DetailDisplayLogic
{
    var interactor: DetailBusinessLogic?
    var router: (NSObjectProtocol & DetailRoutingLogic & DetailDataPassing)?
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokeDexIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var currentEvolutionImageView: UIImageView!
    @IBOutlet weak var nextEvolutionImageView: UIImageView!
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //setupUI()
        loadPokemonDetail()
    }
    
    // MARK: Do something
    
    
    func loadPokemonDetail()
    {
        let request = Detail.PokeDex.Request()
        interactor?.loadPokemonDetail(request: request)
    }
    
    func displayPokemon(viewModel: Detail.PokeDex.ViewModel)
    {
        let pokemon = viewModel.pokemon
        
        nameLabel.text = pokemon.name.capitalized
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImageView.image = img
        currentEvolutionImageView.image = img
        pokeDexIdLabel.text = "\(pokemon.pokedexId)"
        
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        typeLabel.text = pokemon.type
        descriptionLabel.text = pokemon.description
        
        if pokemon.nextEvolutionId == "" {
            evolutionLabel.text = "No Evolutions"
            nextEvolutionImageView.isHidden = true
            
        } else {
            let str = "Next Evolution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            evolutionLabel.text = str
            
            nextEvolutionImageView.isHidden = false
            nextEvolutionImageView.image = UIImage(named: pokemon.nextEvolutionId)
            
        }
        
        //nameTextField.text = viewModel.name
    }
    @IBAction func onBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
