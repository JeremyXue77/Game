//
//  GameListView.swift
//  Game
//
//  Created by Jeremy Xue on 2020/8/20.
//  Copyright © 2020 JeremyXue. All rights reserved.
//

import UIKit

protocol GameListViewDelegate: AnyObject {
    func gameListView(_ gameListView: GameListView, didSelectItem item: GameListView.GameItem)
}

class GameListView: UIView {
    
    // MARK: Properties
    weak var delegate: GameListViewDelegate?
    private let items: [GameItem] = GameItem.allCases
    private let cellIdentifier: String = "GameItemCell"
    
    // MARK: IBOutlets
    @IBOutlet weak var listTableView: UITableView!
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupListTableView()
    }
    
    // MARK: Setting Methods
    private func setupListTableView() {
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.tableFooterView = UIView()
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
}

// MARK: - GameListView + UITableViewDataSource
extension GameListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.text
        return cell
    }
}

// MARK: - GameListView + UITableViewDelegate
extension GameListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        delegate?.gameListView(self, didSelectItem: item)
    }
}

// MARK: - Nested Types
extension GameListView {
    
    enum GameItem: Int, CaseIterable {
        case flipCards = 0, numberReaction, perfectPath
        
        var text: String {
            switch self {
            case .flipCards:      return "記憶配對"
            case .numberReaction: return "數字反應力"
            case .perfectPath:    return "完美路徑"
            }
        }
    }
}
