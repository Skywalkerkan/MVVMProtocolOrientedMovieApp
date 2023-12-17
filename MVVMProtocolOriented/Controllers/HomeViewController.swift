//
//  ViewController.swift
//  MVVMProtocolOriented
//
//  Created by Erkan on 13.09.2023.
//

import UIKit

class HomeViewController: UIViewController, MovieViewModelOutput {
    
    
    
    
    func updateTrending(movie: Movie) {
        guard let movie = movie.results else{return}
        trendingMovies = movie
     //   print(movie)
        DispatchQueue.main.async {
            self.collectionViewTrending.reloadData()
            
            self.activityIndicator.stopAnimating()
            self.scrollView.isHidden = false
        }
        
    }
    
   
    
    
    func updateMovieTopRated(movie: Movie) {
        guard let movie = movie.results else{return}
        
        
        movieResults = movie
        DispatchQueue.main.async {
            self.collectionViewTopRated.reloadData()
        }
        
    
  
        
    }
    
    
    
    func updateUpcomingMovie(movie: Movie) {
        guard let movie = movie.results else{return}

        upcomingMovies = movie
     
       
        DispatchQueue.main.async {
            self.collectionViewUpcoming.reloadData()
            print("Bitti")
  
        }
        print("Evet")
      
    }
    
    
    
    func updateMovie(movie: Movie) {
        guard let movie = movie.results else{return}
       // print(movie)

        
        topRatedMovies = movie
        
        DispatchQueue.main.async {
            self.colletionViewPopular.reloadData()
            self.pageControl.numberOfPages = self.topRatedMovies.count
        }
        
      
    }
    
    
    
    
    

    
    private let pageControl: UIPageControl = {
       let pageControl = UIPageControl()
        pageControl.numberOfPages = 5
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    
    
    private let scrollView: UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let scrollStackViewContainer: UIStackView = {
       let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    

    
    
    
    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit // Görüntü ölçeklendirme modunu ayarlayabilirsiniz.
      //  imageView.backgroundColor = .red
        imageView.clipsToBounds = false
        return imageView
    }()
    
   
    
    
    var movieImages: [Data] = []
    
    var movieResults: [Result] = []
    var upcomingMovies: [Result] = []
    var topRatedMovies: [Result] = []
    var trendingMovies: [Result] = []

    
    
    private let viewModel: MovieViewModel
    
    
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.outputMovies = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let trendingMovieLabel: UILabel = {
       let label = UILabel()
        label.text = "   Trending"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let upcomingMovieLabel: UILabel = {
       let label = UILabel()
        label.text = "   Upcoming Movies"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let topRatedMovieLabel: UILabel = {
       let label = UILabel()
        label.text = "   Top Rated"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    
    let collectionViewTrending: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    
    }()
    
    let collectionViewTopRated: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    
    }()
    
    let collectionViewUpcoming: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    
        
    }()
    
    let colletionViewPopular: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView

        
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator

    }()
     
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        activityIndicator.startAnimating()


        
        viewModel.fetchMovie()
        viewModel.fetchUpcomingMovies()
        viewModel.fetchTopRatedMovies()
        viewModel.fetchTrendingMovies()
        
        
        
    
       
        
        collectionViewSetup()

        
 
        
        
   
        
        
        
        view.backgroundColor = .black

        
    }
    
    
    func collectionViewSetup(){
        
        collectionViewTopRated.register(TopRatedCollectionViewCell.self, forCellWithReuseIdentifier: "cellTopRated")
        collectionViewUpcoming.register(TopRatedCollectionViewCell.self, forCellWithReuseIdentifier: "cellUpcoming")
        colletionViewPopular.register(TopRatedCollectionViewCell.self, forCellWithReuseIdentifier: "cellPopular")
        collectionViewTrending.register(TopRatedCollectionViewCell.self, forCellWithReuseIdentifier: "cellTrending")

        collectionViewTopRated.backgroundColor = .clear
        collectionViewUpcoming.backgroundColor = .clear
        colletionViewPopular.backgroundColor = .clear
        collectionViewTrending.backgroundColor = .clear

        
        collectionViewTopRated.delegate = self
        collectionViewTopRated.dataSource = self
        collectionViewUpcoming.delegate = self
        collectionViewUpcoming.dataSource = self
        colletionViewPopular.delegate = self
        colletionViewPopular.dataSource = self
        collectionViewTrending.delegate = self
        collectionViewTrending.dataSource = self
    }

    
    
    let backView: UIView = {
        
     let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    override func viewDidLayoutSubviews() {

        view.addSubview(scrollView)
        scrollView.addSubview(scrollStackViewContainer)
        title = "Home"
        if let navigationController = self.navigationController {
            navigationController.navigationBar.barTintColor = UIColor.red
            navigationController.navigationBar.tintColor = UIColor.white // Başlık ve düğme renkleri
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }

        
        scrollView.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        scrollStackViewContainer.anchor(top: scrollView.topAnchor, bottom: scrollView.bottomAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 0)
        scrollStackViewContainer.addArrangedSubview(backView)
        
        /*scrollStackViewContainer.addArrangedSubview(colletionViewPopular)
        scrollStackViewContainer.addArrangedSubview(pageControl)
        scrollStackViewContainer.addArrangedSubview(trendingMovieLabel)
        scrollStackViewContainer.addArrangedSubview(collectionViewTrending)
        scrollStackViewContainer.addArrangedSubview(upcomingMovieLabel)
        scrollStackViewContainer.addArrangedSubview(collectionViewUpcoming)
        scrollStackViewContainer.addArrangedSubview(collectionViewTopRated)*/
        
        backView.addSubview(colletionViewPopular)
        backView.addSubview(pageControl)
        backView.addSubview(trendingMovieLabel)
        backView.addSubview(collectionViewTrending)
        backView.addSubview(upcomingMovieLabel)
        backView.addSubview(collectionViewUpcoming)
        backView.addSubview(collectionViewTopRated)
        backView.addSubview(topRatedMovieLabel)
        
        
        backView.anchor(top: scrollStackViewContainer.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.height*0.65 + 275)

    
        
        colletionViewPopular.anchor(top: backView.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.height/4)
        
        pageControl.anchor(top: colletionViewPopular.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 35)
        

        
        trendingMovieLabel.anchor(top: pageControl.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 30)

        
        collectionViewTrending.anchor(top: trendingMovieLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 130)

        
        
        upcomingMovieLabel.anchor(top: collectionViewTrending.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 30)
       
        collectionViewUpcoming.anchor(top: upcomingMovieLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.height/5)
    
        topRatedMovieLabel.anchor(top: collectionViewUpcoming.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: 30)
        
        
        collectionViewTopRated.anchor(top: topRatedMovieLabel.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0, width: 0, height: view.frame.size.height/5)

        
    }

}




extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell
        
        switch collectionView {
        case collectionViewTopRated:
            guard let topRatedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTopRated", for: indexPath) as? TopRatedCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            topRatedCell.movieNameLabel.text = movieResults[indexPath.row].title
            topRatedCell.backGroundPath =  movieResults[indexPath.row].posterPath
            
            cell = topRatedCell
            
        case collectionViewUpcoming:
            guard let upcomingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellUpcoming", for: indexPath) as? TopRatedCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            upcomingCell.movieNameLabel.text = upcomingMovies[indexPath.row].title
            upcomingCell.backGroundPath =  upcomingMovies[indexPath.row].posterPath
            
            cell = upcomingCell
            
        case colletionViewPopular:
            guard let popularcell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellPopular", for: indexPath) as? TopRatedCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            popularcell.movieNameLabel.text = topRatedMovies[indexPath.row].title
            popularcell.backGroundPath =  topRatedMovies[indexPath.row].backdropPath
            
            cell = popularcell
            
            
        case collectionViewTrending:
            print("aaa")
            guard let trendingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTrending", for: indexPath) as? TopRatedCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            trendingCell.movieNameLabel.text = trendingMovies[indexPath.row].title
            trendingCell.backGroundPath =  trendingMovies[indexPath.row].backdropPath
            
            cell = trendingCell
            
        default:
            print("ok")
            cell = UICollectionViewCell()
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case collectionViewTopRated:
            return movieResults.count
        case collectionViewUpcoming:
            return upcomingMovies.count
        case colletionViewPopular:
            return topRatedMovies.count
        case collectionViewTrending:
            return trendingMovies.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView{
         
        case colletionViewPopular:
            return CGSize(width: view.frame.size.width - 20 , height: view.frame.size.height/4)

        case collectionViewTrending:
            return CGSize(width: view.frame.size.width/2 , height: 130)
        
        case collectionViewUpcoming:
            return CGSize(width: view.frame.size.width/3 , height: view.frame.size.height/5)

        case collectionViewTopRated:
            return CGSize(width: view.frame.size.width/3 , height: view.frame.size.height/5)
            
            
            
        default:
            return CGSize()
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

        
        switch collectionView{
        case collectionViewTopRated:
            let VC = MovieDetailViewController(viewModel: viewModel)
            VC.movieID = movieResults[indexPath.row].id
            navigationController?.pushViewController(VC, animated: true)
        case collectionViewUpcoming:
            let VC = MovieDetailViewController(viewModel: viewModel)
            VC.movieID = upcomingMovies[indexPath.row].id
            navigationController?.pushViewController(VC, animated: true)
        case colletionViewPopular:
            let VC = MovieDetailViewController(viewModel: viewModel)
            VC.movieID = topRatedMovies[indexPath.row].id
            navigationController?.pushViewController(VC, animated: true)
            
        case collectionViewTrending:
            let VC = MovieDetailViewController(viewModel: viewModel)
            VC.movieID = trendingMovies[indexPath.row].id
            navigationController?.pushViewController(VC, animated: true)
            
        default: break
        
        }
        
    }
    
    

    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView{
            
        case colletionViewPopular:
            return CGFloat(20)
            
        case collectionViewTrending:
            return CGFloat(10)
            
        case collectionViewTopRated:
            return CGFloat(10)
            
        case collectionViewUpcoming:
            return CGFloat(10)
        default:
            return CGFloat(40)
        }
    }
    
   
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView{
            
        case colletionViewPopular:
            pageControl.currentPage = indexPath.row
            
            
        default: 
            break
            
        }
    }
    

    
    
    
}
