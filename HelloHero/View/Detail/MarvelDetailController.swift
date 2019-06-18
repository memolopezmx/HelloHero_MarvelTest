//
//  MarvelDetailController.swift
//  HelloHero
//
//  Created by Memo on 6/18/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation
import UIKit

extension MarvelDetailController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return MarvelDetailEnum.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case MarvelDetailEnum.thumbnail.rawValue:
            return 1
        case MarvelDetailEnum.description.rawValue:
            return 1
        case MarvelDetailEnum.comics.rawValue:
            return self.character.Comics.Items.count
        case MarvelDetailEnum.series.rawValue:
            return self.character.Series.Items.count
        case MarvelDetailEnum.stories.rawValue:
            return self.character.Stories.Items.count
        case MarvelDetailEnum.events.rawValue:
            return self.character.Events.Items.count
        case MarvelDetailEnum.readMore.rawValue:
            return self.character.Urls.count
        default:
            return Int()
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case MarvelDetailEnum.thumbnail.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetail_Thumbnail_Cell.identifier,
                                                        for: indexPath) as? MarvelDetail_Thumbnail_Cell {
                self.marvelDetail_ThumbnailCell_ReloadDelegate = cell
                self.marvelDetail_ThumbnailCell_ReloadDelegate?.marvelDetail_ThumbnailCell_ReloadDelegate(thumbnail: self.character.Thumbnail,
                                                                                                          name: self.character.Name)
                return cell
            }
            return UITableViewCell()
        case MarvelDetailEnum.description.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetail_Description_Cell.identifier,
                                                        for: indexPath) as? MarvelDetail_Description_Cell {
                self.marvelDetail_Description_CellDelegate = cell
                self.marvelDetail_Description_CellDelegate?.marvelDetail_Description_CellDelegate(_description: self.character.Description)
                return cell
            }
            return UITableViewCell()
        case MarvelDetailEnum.comics.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetail_ComicItemCell.identifier,
                                                        for: indexPath) as? MarvelDetail_ComicItemCell {
                
                self.marvelDetail_ComicCell_ReloadDelegate = cell
                self.marvelDetail_ComicCell_ReloadDelegate?.marvelDetail_ComicCell_Reload(comicItem: self.character.Comics.Items[indexPath.row])
                return cell
            }
            return UITableViewCell()
        case MarvelDetailEnum.series.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetail_SeriesItemCell.identifier,
                                                        for: indexPath) as? MarvelDetail_SeriesItemCell {
                self.marvelDetail_SeriesCell_ReloadDelegate = cell
                self.marvelDetail_SeriesCell_ReloadDelegate?.marvelDetail_SeriesCell_Reload(serieItem: self.character.Series.Items[indexPath.row])
                return cell
            }
            return UITableViewCell()
        case MarvelDetailEnum.stories.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetail_StoriesItemCell.identifier,
                                                        for: indexPath) as? MarvelDetail_StoriesItemCell {
                
                self.marvelDetail_StorieCell_ReloadDelegate = cell
                self.marvelDetail_StorieCell_ReloadDelegate?.marvelDetail_StorieCell_Reload(storieItem: self.character.Stories.Items[indexPath.row])
                return cell
            }
            return UITableViewCell()
        case MarvelDetailEnum.events.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetail_EventsItemCell.identifier,
                                                        for: indexPath) as? MarvelDetail_EventsItemCell {
                self.marvelDetail_EventsCell_ReloadDelegate = cell
                self.marvelDetail_EventsCell_ReloadDelegate?.marvelDetail_EventsCell_Reload(eventItem: self.character.Events.Items[indexPath.row])
                return cell
            }
            return UITableViewCell()
        case MarvelDetailEnum.readMore.rawValue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MarvelDetail_ReadMore_ItemCell.identifier,
                                                        for: indexPath) as? MarvelDetail_ReadMore_ItemCell {
                self.marvelDetail_ReadMoreCell_ReloadDelegate = cell
                self.marvelDetail_ReadMoreCell_ReloadDelegate?.marvelDetail_ReadMoreCell_Reload(marvelUrl: self.character.Urls[indexPath.row])
                return cell
            }
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
}
extension MarvelDetailController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case MarvelDetailEnum.thumbnail.rawValue:
            return MarvelDetail_Thumbnail_Cell.height
        case MarvelDetailEnum.description.rawValue:
            return MarvelDetail_Description_Cell.height
        case MarvelDetailEnum.comics.rawValue:
            return MarvelDetail_ComicItemCell.height
        case MarvelDetailEnum.series.rawValue:
            return MarvelDetail_SeriesItemCell.height
        case MarvelDetailEnum.stories.rawValue:
            return MarvelDetail_StoriesItemCell.height
        case MarvelDetailEnum.events.rawValue:
            return MarvelDetail_EventsItemCell.height
        case MarvelDetailEnum.readMore.rawValue:
            return MarvelDetail_ReadMore_ItemCell.height
        default:
            return CGFloat()
        }
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension MarvelDetailController {
    func setupUI() {
        setupView() // HomeViewController
        setupTableView() // TableView
    }
    func setupView() {
        self.view.backgroundColor = .white
    }
    func setupTableView() {
        
        constrainTableView()
        
        self.tableView.register(MarvelDetail_Thumbnail_Cell.self, forCellReuseIdentifier: MarvelDetail_Thumbnail_Cell.identifier)
        self.tableView.register(MarvelDetail_Description_Cell.self, forCellReuseIdentifier: MarvelDetail_Description_Cell.identifier)
        self.tableView.register(MarvelDetail_ComicItemCell.self, forCellReuseIdentifier: MarvelDetail_ComicItemCell.identifier)
        self.tableView.register(MarvelDetail_SeriesItemCell.self, forCellReuseIdentifier: MarvelDetail_SeriesItemCell.identifier)
        self.tableView.register(MarvelDetail_StoriesItemCell.self, forCellReuseIdentifier: MarvelDetail_StoriesItemCell.identifier)
        self.tableView.register(MarvelDetail_EventsItemCell.self, forCellReuseIdentifier: MarvelDetail_EventsItemCell.identifier)
        self.tableView.register(MarvelDetail_ReadMore_ItemCell.self, forCellReuseIdentifier: MarvelDetail_ReadMore_ItemCell.identifier)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    func constrainTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 0.0).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: 0.0).isActive = true
    }
}

public class MarvelDetailController: UIViewController {
    
    var tableView: UITableView = {
        let t = UITableView(frame: CGRect.zero, style: .grouped)
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = UIColor.grayMarvel
        t.showsVerticalScrollIndicator = false
        t.showsHorizontalScrollIndicator = false
        t.bounces = false
        return t
    }()
    
    var character = MarvelCharacter()
    
    // Protocols
    var marvelDetail_ThumbnailCell_ReloadDelegate: MarvelDetail_ThumbnailCell_ReloadDelegate?
    var marvelDetail_Description_CellDelegate: MarvelDetail_Description_CellDelegate?
    var marvelDetail_ComicCell_ReloadDelegate: MarvelDetail_ComicCell_ReloadDelegate?
    var marvelDetail_SeriesCell_ReloadDelegate: MarvelDetail_SeriesCell_ReloadDelegate?
    var marvelDetail_StorieCell_ReloadDelegate: MarvelDetail_StorieCell_ReloadDelegate?
    var marvelDetail_EventsCell_ReloadDelegate: MarvelDetail_EventsCell_ReloadDelegate?
    var marvelDetail_ReadMoreCell_ReloadDelegate: MarvelDetail_ReadMoreCell_ReloadDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }

    convenience init(character: MarvelCharacter) {
        self.init()
        self.character = character
    }
    
}