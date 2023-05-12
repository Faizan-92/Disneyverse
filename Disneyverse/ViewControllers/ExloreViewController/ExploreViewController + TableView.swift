//
//  ExploreViewController + TableView.swift
//  Disneyverse
//
//  Created by Faizan Memon on 11/05/23.
//

import Foundation
import UIKit

extension ExploreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CharacterInfoTableViewCell.className,
            for: indexPath
        ) as! CharacterInfoTableViewCell
        
        cell.setupCell(viewModel: .init(info: viewModel.characters[indexPath.row]))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = viewModel.characters[indexPath.row]
        let viewModel = CharacterDetailViewModel(
            imageUrl: URL(string: selectedCharacter.imageUrl ?? ""),
            name: selectedCharacter.name,
            filmsList: selectedCharacter.films ?? [],
            videoGamesList: selectedCharacter.videoGames ?? [],
            sourceUrl: URL(string: selectedCharacter.sourceUrl ?? "")
        )
        let characterDetailViewController = CharacterDetailViewController(viewModel: viewModel)
        Logger.log("didSelectRowAt \(indexPath.row)")
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(characterDetailViewController, animated: true)
        }
    }
}

extension ExploreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
}
