
import UIKit

class ImageSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var viewinner: UIView!
    @IBOutlet weak var btnRadio: UIButton!
    
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var lblHeading: UILabel!
        
    var callBckCheckBoxClicked : (()-> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func customize(modelUserData: ImageProtocol) {
        self.lblHeading.text = modelUserData.setLabelText()
        viewSeparator.backgroundColor = .lightGray
        lblHeading.textColor = .white
    }
    
}
