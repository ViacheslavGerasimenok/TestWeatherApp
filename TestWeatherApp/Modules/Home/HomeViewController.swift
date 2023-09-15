//
//  HomeViewController.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

protocol HomeView: AnyObject {
    func reloadData()
    func setEmptyView(isHidden: Bool)
    func setEditingButton(title: String)
    func endShakeLocationCells()
    func startShakeLocationCells()
    func showAlert(title: String, subtitle: String)
    func showLocationActionsAlert(indexPath: IndexPath)
    func showRenameAlert(indexPath: IndexPath, currentLocationName: String)
    func showDeleteAlert(indexPath: IndexPath, locationName: String)
}

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private(set) var presenter: (HomePresenter & HomeIn)?
    
    private var shakeTimer: Timer?
    
    private let locationCellId = String(describing: LocationCell.self)
    private var locationCellHeight: CGFloat {
        view.isRegular ? 120 : 112
    }
    
    private var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top: 8, left: .sideInset, bottom: 8, right: .sideInset)
    }
    
    private var collectionViewFlowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = .sideInset / 2
        layout.minimumInteritemSpacing = .sideInset / 2
        return layout
    }
    
    private var numberOfItemsInRow: Int {
        view.isRegular ? 4 : 2
    }
    
    // MARK: - Subviews
    
    private lazy var emptyView = EmptyView(title: "Add a locations to view the weather forecast")
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = collectionViewContentInset
        collectionView.backgroundColor = .white
        collectionView.register(LocationCell.self, forCellWithReuseIdentifier: locationCellId)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    init(out: @escaping HomeOut) {
        super.init(nibName: nil, bundle: .main)
        presenter = HomePresenterImpl(view: self, out: out)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        presenter?.viewDidLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.updateCollectionView()
            self?.collectionView.reloadData()
        })
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        navigationItem.title = "Locations"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "",
            style: .done,
            target: self,
            action: #selector(editLocationsTapped)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add location",
            style: .done,
            target: self,
            action: #selector(addLocationTapped)
        )
        
        view.backgroundColor = .white
        view.addSubviews(collectionView, emptyView)
    }
    
    private func setupLayout() {
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            emptyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // MARK: - Helpers
    
    private func updateCollectionView() {
        collectionView.contentInset = collectionViewContentInset
        collectionView.collectionViewLayout = collectionViewFlowLayout
    }
    
    @objc private func addLocationTapped() {
        presenter?.addLocationTapped()
    }
    
    @objc private func editLocationsTapped() {
        presenter?.editLocationsTapped()
    }
}

// MARK: - HomeView

extension HomeViewController: HomeView {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func setEmptyView(isHidden: Bool) {
        emptyView.isHidden = isHidden
    }
    
    func setEditingButton(title: String) {
        navigationItem.leftBarButtonItem?.title = title
    }
    
    func endShakeLocationCells() {
        shakeTimer?.invalidate()
        shakeTimer = nil
    }
    
    func startShakeLocationCells() {
        shakeTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { [weak self] _ in
            guard let locationsCount = self?.presenter?.locationsCount else { return }
            for i in 0...locationsCount {
                let indexPath = IndexPath(row: i, section: 0)
                self?.collectionView.cellForItem(at: indexPath)?.shake()
            }
        }
    }
    
    func showAlert(title: String, subtitle: String) {
        let alert = UIAlertController(
            title: title,
            message: subtitle,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showLocationActionsAlert(indexPath: IndexPath) {
        guard let sourceCell = collectionView.cellForItem(at: indexPath) else { return }

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = sourceCell

        let renameAction = UIAlertAction(title: "Rename", style: .default) { [weak self] _ in
            self?.presenter?.startLocationRenamingProcess(indexPath: indexPath)
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.presenter?.startLocationDeletingProcess(indexPath: indexPath)
        }
        
        alert.addAction(renameAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true)
    }
    
    func showRenameAlert(indexPath: IndexPath, currentLocationName: String) {
        let alert = UIAlertController(
            title: "Renaming",
            message: "Enter New Name",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let renameAction = UIAlertAction(title: "Rename", style: .default) { [weak alert, weak self] action in
            guard let newName = alert?.textFields?.first?.text else { return }
            self?.presenter?.renameLocationTapped(indexPath: indexPath, newName: newName)
        }
        
        alert.addAction(renameAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.text = currentLocationName
        }
        
        present(alert, animated: true)
    }
    
    func showDeleteAlert(indexPath: IndexPath, locationName: String) {
        let alert = UIAlertController(
            title: "Delete?",
            message: "Are you shure that you want delete \(locationName) location?",
            preferredStyle: .alert
        )
        
        let noAction = UIAlertAction(title: "No", style: .cancel)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.presenter?.deleteLocationTapped(indexPath: indexPath)
        }
        
        alert.addAction(noAction)
        alert.addAction(yesAction)
        
        present(alert, animated: true)
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.cellForItem(at: indexPath)?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.cellForItem(at: indexPath)?.transform = .identity
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItemAt(indexPath: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        presenter?.locationsCount ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: locationCellId, for: indexPath)
        guard let locationCell = cell as? LocationCell,
              let locationModel = presenter?.locationModelAt(indexPath: indexPath) else { return cell }
        locationCell.configure(viewModel: LocationCellViewModel(location: locationModel))
        return locationCell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let totalWidth = collectionView.bounds.width
        - collectionViewFlowLayout.minimumLineSpacing * CGFloat(numberOfItemsInRow - 1)
        - collectionViewContentInset.horizontal
        return CGSize(
            width: totalWidth / CGFloat(numberOfItemsInRow),
            height: locationCellHeight
        )
    }
}
