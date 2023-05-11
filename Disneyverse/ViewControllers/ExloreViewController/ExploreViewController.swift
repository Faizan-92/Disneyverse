//
//  ExploreViewController.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import UIKit

final class ExploreViewController: UIViewController {

    let viewModel = ExploreViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchAllCharacters()
        viewModel.fetchCharacter(havingName: "Mike")
    }

}

