//
//  HitsTableViewController.swift
//  development-pods-instantsearch
//
//  Created by Vladislav Fitc on 13/06/2019.
//  Copyright © 2019 Algolia. All rights reserved.
//

import Foundation
import UIKit
import InstantSearch

class MovieHitsTableViewController<HitType: Codable>: UITableViewController, HitsController {
    
  let cellIdentifier = "CellID"
  
  var hitsSource: HitsInteractor<HitType>?
  
  //MARK: - UITableViewDataSource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return hitsSource?.numberOfHits() ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    let hit = hitsSource?.hit(atIndex: indexPath.row)
    switch hit {
    case let movie as Movie:
      (cell as? UIView & MovieCell).flatMap(MovieCellViewState().configure)?(movie)
    case let movieHit as Hit<Movie>:
      MovieHitCellConfigurator.configure(cell)(movieHit)
    default:
      break
    }
    return cell
  }
  
  //MARK: - UITableViewDelegate
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 80
  }
  
}
