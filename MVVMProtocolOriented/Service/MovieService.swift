//
//  MovieService.swift
//  MVVMProtocolOriented
//
//  Created by Erkan on 14.09.2023.
//

import Foundation
import UIKit







protocol MovieService{
    
    func fetchPopularMovies(completion: @escaping(Swift.Result<Movie, Error>) -> Void )
  //  func fetchMovieImage(backDropPath: String, completion: @escaping (Swift.Result<Data, Error>) -> Void)
    
    func fetchUpcomingMovies(completion: @escaping(Swift.Result<Movie, Error>) -> Void)
    
    func fetchTopRatedMovies(completion: @escaping(Swift.Result<Movie, Error>) -> Void)
    
    func fetchSingleMovie(movieID: Int, completion: @escaping(Swift.Result<SingleMovie, Error>) -> Void)
    
    func fetchMovieCredit(movieID: Int, completion: @escaping(Swift.Result<MovieCredit, Error>) -> Void)
    
    func fetchMovieTrailer(movieID: Int, completion: @escaping (Swift.Result<MovieTrailer, Error>) -> Void)

    func fetchSimilarMovies(movieID: Int, completion: @escaping (Swift.Result<Movie, Error>) -> Void)
    
    func fetchSearchMovie(searchString: String, completion: @escaping (Swift.Result<Movie, Error>) -> Void)
    
    func fetchTrendingMovies(completion: @escaping (Swift.Result<Movie, Error>) -> Void)


    
}


protocol MovieCellService{
    
    func fetchMovieImage(backDropPath: String, completion: @escaping (Swift.Result<Data, Error>) -> Void)
    
    
    
}







