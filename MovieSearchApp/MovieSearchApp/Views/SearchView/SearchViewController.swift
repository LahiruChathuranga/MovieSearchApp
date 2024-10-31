//
//  SearchViewController.swift
//  MovieSearchApp
//
//  Created by Lahiru Chathuranga on 2024-10-31.
//

import UIKit
import Combine

class SearchViewController: UIViewController, LoadingManagerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var searchbarContainerView: UIView!
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    @IBOutlet weak var labelNoSearchResults: UILabel!
    
    // MARK: - Variables
    var viewModel = SearchViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var searchTimer: Timer?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupBindings()
    }
    
    // MARK: - Actions
    @IBAction func didTapOnScreen(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - Functions
    
    func setupUI() {
        /// set the title
        self.title = "Movie Search"
        /// set the title color
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        /// set the search bar corner radius
        searchbarContainerView.setCornerRadius(20.0)
        
        /// set search field active
        searchTextField.becomeFirstResponder()
    }
    
    func createLoadMoreFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let loadMoreButton = UIButton(type: .system)
        loadMoreButton.setTitle("Load More", for: .normal)
        loadMoreButton.addTarget(self, action: #selector(loadMoreMovies), for: .touchUpInside)
        loadMoreButton.frame = footerView.bounds
        footerView.addSubview(loadMoreButton)
        return footerView
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: MovieInfoTableViewCell.cellIdentifire, bundle: Bundle.main),
                           forCellReuseIdentifier: MovieInfoTableViewCell.cellIdentifire)
        tableView.tableFooterView = createLoadMoreFooter()
        
        /// initially footer will be hidden
        tableView.tableFooterView?.isHidden = true
    }
    
    private func setupBindings() {
        viewModel.$movies
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movieData in
                if let self = self {
                    self.handleMovieData(movieData: movieData)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                if let message = message {
                    self?.showError(message)
                }
            }
            .store(in: &cancellables)
        viewModel.$isLoading.sink { [weak self] isLoading in
            if let self = self {
                self.LoadingHandler(isLoading: isLoading)
            }
        }.store(in: &cancellables)
    }
    
    private func LoadingHandler(isLoading: Bool) {
        isLoading ? startLoading() : stopLoading()
    }
    
    private func handleMovieData(movieData: [MovieModel]) {
        if movieData.isEmpty && searchTextField.text?.isEmpty == false {
            self.labelNoSearchResults.isHidden = false
        } else {
            self.labelNoSearchResults.isHidden = true
        }
        searchTextField.becomeFirstResponder()
        tableView.reloadData()
        
        tableView.tableFooterView?.isHidden = !PaginationManager.shared.isLoadMore
    }
    
    private func showError(_ message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return}
            /// need to hide the no results label
            labelNoSearchResults.isHidden = true
            
            let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    @objc private func textFieldDidChange(_ tf: UITextField) {
        searchTimer?.invalidate()
        if let searchText = tf.text, searchText.count >= 2 {
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { [weak self] _ in
                if let self = self {
                    self.searchMovieRequest(searchText: searchText)
                }
            })
        } else if tf.text?.count == 0 {
            /// removing all the movies as we're clearing the search text
            resetDataForEmptySearchText()
        }
    }
    
    private func searchMovieRequest(searchText: String) {
        /// if the search text is being updated
        /// pagination data should be reset
        /// movie items should be updated
        PaginationManager.shared.resetPaginationData()
        viewModel.movies.removeAll()
        /// load data for 1st page
        viewModel.searchMovies(query: searchText.lowercased(), page: 1)
    }
    
    @objc private func loadMoreMovies() {
        // Check if more pages are available
        let paginationInfo = PaginationManager.shared
        if paginationInfo.nextPage != 0 && paginationInfo.isLoadMore == true {
            viewModel.searchMovies(query: searchTextField.text?.lowercased() ?? "", page: paginationInfo.nextPage)
        }
    }
    
    func resetDataForEmptySearchText() {
        /// removing all the movies as we're clearing the search text
        viewModel.movies.removeAll()
        labelNoSearchResults.isHidden = true
        PaginationManager.shared.resetPaginationData()
    }
}
