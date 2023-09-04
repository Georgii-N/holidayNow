import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var texts = [
        GreetingTarget(image: UIImage(named: "outdoor_grill") ?? UIImage(), name: "Охота"),
        GreetingTarget(image: UIImage(systemName: "eraser.fill") ?? UIImage(), name: "Новый год"),
        GreetingTarget(image: UIImage(systemName: "righttriangle") ?? UIImage(), name: "Поздравления")]
    var collection = CustomCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.dataSource = self
        collection.delegate = self
        collection.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            collection.topAnchor.constraint(equalTo: view.topAnchor),
            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        texts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "Cell", for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        
        cell.setupInterestModel(model: texts[indexPath.row])
        
        return cell
    }
}
