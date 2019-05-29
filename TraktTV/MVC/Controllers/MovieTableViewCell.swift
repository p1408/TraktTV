//
//  MovieTableViewCell.swift
//  TraktTV
//
//  Created by pedro cortez osorio on 5/26/19.
//  Copyright © 2019 gamestorming. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var year : UILabel!
    @IBOutlet weak var overview : UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fillCell(_ movie: Movie){
        title.text = movie.tittleMovie
        year.text = "\(movie.yearMovie ?? 0)" 
        overview.text = movie.overview
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
