//
//  SearchViewController.swift
//  MVVMProtocolOriented
//
//  Created by Erkan on 14.09.2023.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, MovieSearchViewModelOutput {
   
    
    
    
    let collectionViewSearch: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    func updateSearchMovie(movie: Movie) {
        guard let movie = movie.results else {return}
        
        searchedMovies = movie
        
        DispatchQueue.main.async {
            self.collectionViewSearch.reloadData()
        }
        
        
    }
    

    
    let seachBar: UISearchBar = {
        
       let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Search something"
        return sb
    }()
    
    
    
    private let viewModel: MovieViewModel
    var searchedMovies: [Result] = []
    
    init(viewModel: MovieViewModel) {

        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.outputSearchMovie = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      //  print(searchText)
        viewModel.fetchSearchMovies(queryString: searchText)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seachBar.delegate = self
        setupCollectionView()
        
        //viewModel.fetchSearchMovies(queryString: "Transformers")
        
    }
    
    
    
    func setupCollectionView(){
        collectionViewSearch.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
        collectionViewSearch.delegate = self
        collectionViewSearch.dataSource = self
    }
    
    
    override func viewDidLayoutSubviews() {
        view.backgroundColor = .black
        navigationItem.titleView = seachBar
        view.backgroundColor = .black
        view.addSubview(collectionViewSearch)
        collectionViewSearch.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeft: 10, paddingRight: -10, width: 0, height: 0)
        

        
    }
    



}


extension SearchViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SearchCollectionViewCell else{return UICollectionViewCell()}
        cell.searchMovie(movie: searchedMovies[indexPath.row])
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = MovieDetailViewController(viewModel: viewModel)
        VC.movieID = searchedMovies[indexPath.row].id
        navigationController?.pushViewController(VC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    
    
}
