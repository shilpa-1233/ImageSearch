
import UIKit

class ImageSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var viewinner: UIView!    
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var imageSmall: UIImageView!
    
    var callBckCheckBoxClicked : (()-> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func customize(modelUserData: Hit) {
        imageSmall.setImage(for: modelUserData.previewURL ?? "https://pixabay.com/get/35bbf209e13e39d2_640.jpg")
        self.lblHeading.text = modelUserData.setLabelText()
        viewSeparator.backgroundColor = .lightGray
        lblHeading.textColor = .white
    }
    
}
