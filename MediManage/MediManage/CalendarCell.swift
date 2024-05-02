import UIKit

class CalendarCell: UICollectionViewCell {
    var textLabel: UILabel!
    var dotView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel = UILabel(frame: contentView.bounds)
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
        
        dotView = UIView(frame: CGRect(x: contentView.bounds.width - 10, y: 5, width: 5, height: 5))
        dotView.backgroundColor = .black
        dotView.layer.cornerRadius = 2.5
        dotView.isHidden = true
        contentView.addSubview(dotView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showDot(_ show: Bool) {
        dotView.isHidden = !show
    }
}

// Sources:
//https://developer.apple.com/documentation/corefoundation/cgrect
//https://developer.apple.com/documentation/foundation/nscoder
