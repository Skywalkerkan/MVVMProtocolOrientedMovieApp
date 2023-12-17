//
//  RelatedMovieCollectionViewCell.swift
//  MVVMProtocolOriented
//
//  Created by Erkan on 9.10.2023.
//

import UIKit

class RelatedMovieCollectionViewCell: UICollectionViewCell {
    var backGroundPath: String?{
        didSet{
            guard let backGroundPath = backGroundPath else{return}
        //    print(backGroundPath)
            
            if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(backGroundPath)"){
               // print(imageURL)
                DispatchQueue.main.async {
                    self.movieImage.sd_setImage(with: imageURL)
                }
            }
            
            
        }
        
        
        
        
    }
    

    let movieImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    
    let characterLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
    //    label.backgroundColor = .red
        label.font = .systemFont(ofSize: 12.5)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
  
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(movieImage)
     //   addSubview(characterLabel)
       // backgroundColor = .red
            
        movieImage.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
       
        
    }
    
    


    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
