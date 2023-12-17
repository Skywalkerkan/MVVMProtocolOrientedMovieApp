//
//  MovieDetailViewController.swift
//  MVVMProtocolOriented
//
//  Created by Erkan on 17.09.2023.
//

import UIKit
import SDWebImage


class MovieDetailViewController: UIViewController, SingleMovieViewModelOutput, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    
    func updateSimilarMovies(movie: Movie) {
        guard let movies = movie.results else{return}
        
        similarMovies = movies
        
        
        DispatchQueue.main.async {
            
            self.collectionViewSimilarMovies.reloadData()
            
        }
        
    }
    
    
    
   

    
  
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case collectionViewCast:
            return movieCast.count
        
        case collectionViewSimilarMovies:
            return similarMovies.count
        default:
            return 0
        }
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case collectionViewCast:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CastCollectionViewCell else{return UICollectionViewCell()}
            cell.characterLabel.text = movieCast[indexPath.row].name
            cell.backGroundPath = movieCast[indexPath.row].profilePath
            return cell
            
        case collectionViewSimilarMovies:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? RelatedMovieCollectionViewCell else{return UICollectionViewCell()}
            
            cell.backGroundPath = similarMovies[indexPath.row].backdropPath
            return cell
        default:
            return UICollectionViewCell()
        }
        

        
      
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView{
            
        case collectionViewSimilarMovies:
            print(similarMovies[indexPath.row].id)
            
            let VC = MovieDetailViewController(viewModel: viewModel)
            VC.movieID = similarMovies[indexPath.row].id
            navigationController?.pushViewController(VC, animated: true)
            
        case collectionViewCast:
            print(movieCast[indexPath.row].originalName)
            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView{
            
        case collectionViewCast:
            return CGSize(width: view.frame.size.width/5 - 20, height: view.frame.size.width/3 - 20)
        
        case collectionViewSimilarMovies:
            return CGSize(width: view.frame.size.width/2.5, height: view.frame.size.height / 8)

            
        default:
            return CGSize()
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 18)
    }
    
    
    
    var movieCast: [Cast] = []
    var characters: [Cast] = []
    var similarMovies: [Result] = []
    
    func updateMovieCredit(movie: MovieCredit) {
        guard let credits = movie.cast else{return}
        movieCast = credits
        characters = Array(credits.prefix(4))
       
        DispatchQueue.main.async {
            self.collectionViewCast.reloadData()
        }
    }
    
    
    func updateMovieTrailer(movie: MovieTrailer) {
       // print(movie)
    }
    
    
    
    
    private let viewModel: MovieViewModel
    
    
    var movieInfo: String = ""
    
    
    init(viewModel: MovieViewModel) {
        print(viewModel)
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.outputSingleMovie = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var movieID: Int = 1{
        
        didSet{
            viewModel.fetchSingleMovie(movieID: movieID)
            viewModel.fetchMovieCredit(movieID: movieID)
            viewModel.fetchMovieTrailer(movieID: movieID)
            viewModel.fetchSimilarMovies(movieID: movieID)
        }
        
    }
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let stackContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
        
    }()
    
    let containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collectionViewCast: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       // layout.scrollDirection = .horizontal
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
    
        return collectionView
    }()
    
    
    let collectionViewSimilarMovies: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
       // layout.scrollDirection = .horizontal
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

    
        return collectionView
    }()

    
    let backdropImage: UIImageView = {
        let imageview = UIImageView()
         imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.backgroundColor = UIColor(white: 1, alpha: 0.1)
         return imageview
     }()

    let posterImage: UIImageView = {
       let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.backgroundColor = .white
        imageview.layer.cornerRadius = 10
        imageview.clipsToBounds = true
        return imageview
    }()
    
    
    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .black)
        label.textAlignment = .center
        return label
    }()
    
    
    
    let releaseDateLabel: UILabel = {


        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textColor = .lightGray
         label.font = .systemFont(ofSize: 14, weight: .black)
         label.textAlignment = .left
         label.numberOfLines = 0
         return label
    }()
    
    let sureLabel: UILabel = {
        let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.textColor = .lightGray
         label.font = .systemFont(ofSize: 14, weight: .black)
         label.textAlignment = .left
         label.numberOfLines = 0
         return label
    }()
    
    
    let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.tintColor = UIColor(red: 250/255, green: 102/255, blue: 95/255, alpha: 1)
        button.backgroundColor = UIColor(red: 236/255, green: 38/255, blue: 100/255, alpha: 1)
        
        // Metni ve resmi içeren bir yatay stack view oluşturun
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        
        // Metni ayarlayın
        let title = UILabel()
        title.text = "Play"
        title.textColor = .white
      
        
        // Resmi ayarlayın
        let image = UIImageView(image: UIImage(systemName: "play.fill"))
        image.tintColor = .white
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(title)
        
        // Stack view'i düğmeye ekle
        button.addSubview(stackView)
        
        // Stack view'i düğmenin içinde konumlandırın
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor)
        ])
        
        return button
    }()

    
    
    let imdbImage: UIImageView = {
        let imdbImage = UIImageView()
        imdbImage.image = UIImage(named: "imdb")
        imdbImage.translatesAutoresizingMaskIntoConstraints = false
       //  imageview.backgroundColor = .white
        imdbImage.layer.cornerRadius = 10
        imdbImage.clipsToBounds = true
         return imdbImage
    }()
    
    let imdbLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15, weight: .black)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let summaryLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let castLabel: UILabel = {
     let label = UILabel()
        label.text = "Movie Casts"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let summaryTitleLabel: UILabel = {
        let label = UILabel()
           label.text = "Summary"
           label.textColor = .white
           label.font = .boldSystemFont(ofSize: 15)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()
    
    
    let relatedMoviesLabel: UILabel = {
        let label = UILabel()
           label.text = "Related Movies"
           label.textColor = .white
           label.font = .boldSystemFont(ofSize: 15)
           label.translatesAutoresizingMaskIntoConstraints = false
           return label
       }()

    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        view.backgroundColor = .black
        
        view.addSubview(scrollView)
    
        
        
        scrollView.anchor(top: view.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        

        
        
        
        
        view.addSubview(backdropImage)
        view.addSubview(posterImage)
        view.addSubview(movieNameLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(sureLabel)
        view.addSubview(playButton)
        view.addSubview(imdbImage)
        view.addSubview(imdbLabel)
        view.addSubview(summaryTitleLabel)
        view.addSubview(summaryLabel)
        view.addSubview(relatedMoviesLabel)
        
        backdropImage.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.height/3.3)
        posterImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: backdropImage.bottomAnchor, leading: backdropImage.leadingAnchor, trailing: nil, paddingTop: 0, paddingBottom: -15, paddingLeft: 20, paddingRight: 0, width: view.frame.size.width/3.3, height: 0)
        movieNameLabel.anchor(top: posterImage.topAnchor, bottom: nil, leading: posterImage.trailingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: 0)
        releaseDateLabel.anchor(top: movieNameLabel.bottomAnchor, bottom: nil, leading: movieNameLabel.leadingAnchor, trailing: movieNameLabel.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        sureLabel.anchor(top: releaseDateLabel.bottomAnchor, bottom: nil, leading: releaseDateLabel.leadingAnchor, trailing: releaseDateLabel.trailingAnchor, paddingTop: 7, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        playButton.anchor(top: backdropImage.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 15, paddingBottom: 0, paddingLeft: 20, paddingRight: -20, width: 0, height: 40)
        imdbImage.anchor(top: sureLabel.bottomAnchor, bottom: nil, leading: sureLabel.leadingAnchor, trailing: nil, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 50, height: 25)
        imdbLabel.anchor(top: nil, bottom: nil, leading: imdbImage.trailingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 10, paddingRight: 0, width: 0, height: 0)
        imdbLabel.centerYAnchor.constraint(equalTo: imdbImage.centerYAnchor).isActive = true
        
        
        collectionViewCast.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionViewSimilarMovies.register(RelatedMovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell2")

        
        view.addSubview(collectionViewCast)
        view.addSubview(castLabel)
        view.addSubview(collectionViewSimilarMovies)
        castLabel.anchor(top: playButton.bottomAnchor, bottom: nil, leading: playButton.leadingAnchor, trailing: nil, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 20)
        collectionViewCast.anchor(top: castLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 3, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.width/3 - 20)
        summaryTitleLabel.anchor(top: collectionViewCast.bottomAnchor, bottom: nil, leading: castLabel.leadingAnchor, trailing: nil, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        summaryLabel.anchor(top: summaryTitleLabel.bottomAnchor, bottom: nil, leading: summaryTitleLabel.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 2, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        relatedMoviesLabel.anchor(top: summaryLabel.bottomAnchor, bottom: nil, leading: summaryLabel.leadingAnchor, trailing: summaryLabel.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        collectionViewSimilarMovies.anchor(top: relatedMoviesLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 5, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.height / 8 + 5)
        
        
        collectionViewCast.dataSource = self
        collectionViewCast.delegate = self
        collectionViewSimilarMovies.dataSource = self
        collectionViewSimilarMovies.delegate = self
        
    }
    
    
 
 
    
    

    
    func updateSingleMovie(movie: SingleMovie) {
        
        
        
        guard let posterPath = movie.posterPath else{return}
        guard let backdropPath = movie.backdropPath else{return}
        guard let releaseDate = movie.releaseDate else{return}
        guard let genres = movie.genres else{return}
        guard let runTime = movie.runtime else{return}
        guard let imdbPuan = movie.voteAverage else{return}
        guard let summary = movie.overview else{return}
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 1
        numberFormatter.maximumFractionDigits = 1
        
        guard let imdbPuanString = numberFormatter.string(from: NSNumber(value: imdbPuan)) else{return}
        
        
        var releaseYear: String = ""
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: releaseDate) {
            // Calendar ile tarihin yılını alma
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            releaseYear = "\(year)"
            
        } else {
            print("Geçersiz tarih formatı")
        }
        
        
        
        var dakika: Int = runTime % 60
        var saat: Int = runTime / 60
        
        var oynatmaSuresi: String = "\(saat)h \(dakika)min · Movie HD"
        
        
        
        var genreAll: String = ""

        var number = 0
        
        var genre2 = Array(genres.prefix(2))
       

        for genre in genre2{
            
  
            
            guard let genreName = genre.name else{return}
            
           
            if number != genre2.count - 1{
                genreAll += "\(genreName), "
            }else{
                genreAll += "\(genreName)"
            }
            number += 1
        }
        
        
       
        movieInfo  = "\(releaseYear) · \(genreAll)"
        
        let attributedString = NSMutableAttributedString(string: movieInfo)

        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points

        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        // *** Set Attributed String to your label ***
       
        
        
       DispatchQueue.main.async {
            self.releaseDateLabel.attributedText = attributedString
           self.sureLabel.text = oynatmaSuresi
           self.imdbLabel.text = "\(imdbPuanString)/10"
           self.summaryLabel.text = summary
           self.movieNameLabel.text = movie.originalTitle
            //self.releaseDateLabel.text = self.movieInfo
        }
        

        
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)"){
            DispatchQueue.main.async {
                self.posterImage.sd_setImage(with: imageURL)

            }
        }
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)") {
            DispatchQueue.main.async {
                self.backdropImage.sd_setImage(with: imageURL) { (image, error, cacheType, url) in
                    if let originalImage = image {
                        self.backdropImage.image = originalImage
                        
                        // UIVisualEffectView ile bulanıklaştırma efekti oluşturun
                        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
                        let blurView = UIVisualEffectView(effect: blurEffect)
                        blurView.frame = self.backdropImage.bounds
                        
                        // Bulanıklaştırma efektini görüntüye ekle
                        self.backdropImage.addSubview(blurView)
                        
                        let gradientLayer = CAGradientLayer()
                        gradientLayer.frame = self.backdropImage.bounds

                        // Renkler ve opaklık ayarlamalarını yapın
                        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
                        gradientLayer.locations = [0.7, 1.0] // Alt tarafı daha karanlık yapmak için

                        // Gradyan katmanını imageView'a ekleyin
                        self.backdropImage.layer.addSublayer(gradientLayer)
                        
                        
                    }
                }
            }
        }
        
        
        
    }
    

    
    



    
    
}
