import UIKit
import ReactorKit

class MockViewController: UIViewController, View {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
    }
    
    init(reactor: MockReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: MockReactor) {
        return
    }
}
