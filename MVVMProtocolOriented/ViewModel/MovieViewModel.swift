//
//  MovieViewModel.swift
//  MVVMProtocolOriented
//
//  Created by Erkan on 14.09.2023.
//

import Foundation



class MovieViewModel{
    
    private let movieService: MovieService
     
     weak var outputMovies: MovieViewModelOutput?
    weak var outputSingleMovie: SingleMovieViewModelOutput?
    weak var outputSearchMovie: MovieSearchViewModelOutput?
   
    
    
    init(movieService: MovieService){
        self.movieService = movieService
    }
    
    
    
    
    
    func fetchTrendingMovies(){
        
        movieService.fetchTrendingMovies { result in
            switch result{
            case .success(let movie):
                self.outputMovies?.updateTrending(movie: movie)
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    
    
    func fetchSearchMovies(queryString: String){
        
        movieService.fetchSearchMovie(searchString: queryString) { result in
            switch result{
                
            case .success(let movie):
                self.outputSearchMovie?.updateSearchMovie(movie: movie)
                
            case .failure(let error):
                print(error)
                
            }
        }
        
        
    }
    
    
    func fetchSimilarMovies(movieID: Int){
        
        movieService.fetchSimilarMovies(movieID: movieID) { result in
            switch result{
            case .success(let movie):
                self.outputSingleMovie?.updateSimilarMovies(movie: movie)
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    func fetchTopRatedMovies(){
        
        movieService.fetchTopRatedMovies { result in
            switch result{
            case .success(let movie):
                self.outputMovies?.updateMovieTopRated(movie: movie)
            case .failure(let error):
                print(error)
            
            }
        }
        
    }
    
    
    func fetchUpcomingMovies(){
        movieService.fetchUpcomingMovies { result in
            switch result{
            case .success(let movie):
                self.outputMovies?.updateUpcomingMovie(movie: movie)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func fetchMovie(){
        
        
        movieService.fetchPopularMovies { result in
            switch result{
            case .success(let movie):
                
                self.outputMovies?.updateMovie(movie: movie)
            case .failure(let error):
                print(error)
            }
        }
    }

        
        
        func fetchSingleMovie(movieID: Int){
            movieService.fetchSingleMovie(movieID: movieID) { result in
                print(movieID)
                switch result{
                case .success(let singleMovie):
                    
                    self.outputSingleMovie?.updateSingleMovie(movie: singleMovie)
                    
                case .failure(let error):
                    print("aaaaaaa")
                    print(error)
                }
            }
        }
    
    func fetchMovieCredit(movieID: Int){
        movieService.fetchMovieCredit(movieID: movieID) { result in
            switch result{
            case .success(let movieCredit):
                self.outputSingleMovie?.updateMovieCredit(movie: movieCredit)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchMovieTrailer(movieID: Int){
     
        movieService.fetchMovieTrailer(movieID: movieID) { result in
            switch result{
            case .success(let movieTrailer):
            
                guard let movies = movieTrailer.results else{return}
                
                for i in movies{
                    if i.name == "Main Trailer"{
                        print(i.key)
                    }
                }
                
                self.outputSingleMovie?.updateMovieTrailer(movie: movieTrailer)
            case .failure(let error):
                print(error)
                
                
            }
        }
        
    }
    
    
}
