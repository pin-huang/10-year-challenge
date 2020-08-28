//  10 year challenge
//
import UIKit // 匯入工具 UIKit

class ViewController: UIViewController {
    
    // 將 專輯圖檔 以陣列方式存入常數 ，讓 func displayNextImage() 作判斷使用
    let albumFile = ["19990707", "20000707", "20010706", "20031111", "20041105", "20061229", "20081023", "20111216", "20160721"]
    
    // 宣告常數 dateFormatter，並帶入 DateFormatter ，方便之後設定日期格式
    let dateformatter = DateFormatter()
    
    var albumImageName:String = "" // 宣告變數 textString 的型別為字串 (給 func selectAlbumVersion 使用)
    var dateString:String = "" // 宣告變數 dateString 的型別為字串 (給 func selectAlbumVersion 使用)
    var textString:String = "" // 宣告變數 textString 的型別為字串 (給 func selectAlbumVersion 使用)

    var albumNumber = Int() // 宣告變數，給 function displayNextImage 使用
    
    var timer:Timer? // 宣告變數 timer 的型別為 Timer? (給 計時器 func timeCounter 使用，可以在讀秒後播放下一張專輯照片)
    
    
    
    // 設置元件 UI ImageView ，並連結 IBOutlet albumCover (與 IBAction timeSlider 連動，以便隨之變換不同的專輯封面)
    @IBOutlet weak var albumCover: UIImageView!
    
    // 設置元件 UI DatePicker ，並連結 IBOutlet dateDisplay (與IBAction timeSlider 連動，以便隨之變換，顯示各專輯的發表日)
    // 要記得在 Main.storyboard 內的元件 UI DatePicker 四 Attribute Inspector 選擇 DatePicker Mode 為只顯示日期 (Date)
    @IBOutlet weak var dateDisplay: UIDatePicker!
    
    // 設置元件 UISlider ，並連結 IBOutlet timeLine (與IBAction timeSlider 建立連動關係)
    @IBOutlet weak var timeLine: UISlider!
    
    // 設置元件 UI Label ，並連結 IBOutlet dateDisplay (與IBAction timeSlider 連動，以便隨之變換，顯示各專輯的介紹)
    @IBOutlet weak var albumInfo: UILabel!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        timeCounter() // 為了在啟動 app 後立刻自動播放，必須先執行 計時器 功能
        
        albumCover.image = UIImage(named: String(albumFile[0])) // 預設 app 啟動後載入的專輯封面圖檔
        albumInfo.text = "五月天的第一張創作專輯是臺灣樂團五月天發表的第一張錄音室專輯，專輯名稱亦被稱為瘋狂世界。1997年開始，台灣的地下樂團開始冒出頭，以往被大眾忽略的地下搖滾，經由五月天的走紅，逐漸被大眾接受也造就了台灣樂壇一股樂團風潮… "
        
        

        dateformatter.dateFormat = "yyyy/MM/dd" // 定義 dateFormatter 的顯示格式，注意月份為大寫字母 MM (誤用小寫 mm 的話，會不連動變化)
        
        dateDisplay.locale = Locale(identifier: "zh-TW") // 定義 元件 UIDatePicker 的語系
        // dateDisplay.isEnabled = false // 不讓使用者點選 元件 UIDatePicker
        
    }
        

    
    // 宣告一個名為 selectAlbumVersion 的 function ，以 switch 來定義各專輯的封面圖檔、發表日期及簡介內容 (搭配後面的 function displayNextImage ，可依照變換元件 UI Image View (albumCover) 所顯示的專輯封面、元件 UI Label (albumInfo) 的專輯簡介，並連結到元件 UI DatePicker (dateDisplay) 更改其顯示日期)
    func selectAlbumVersion(num1:Int) {
        switch num1 {
                
        case 0:
            albumImageName = String(albumFile[0])
            dateString = "1999/07/07" // 第一張專輯發表日
            textString = "五月天的第一張創作專輯是臺灣樂團五月天發表的第一張錄音室專輯，專輯名稱亦被稱為瘋狂世界。1997年開始，台灣的地下樂團開始冒出頭，以往被大眾忽略的地下搖滾，經由五月天的走紅，逐漸被大眾接受也造就了台灣樂壇一股樂團風潮… "
            
        case 1:
            albumImageName = String(albumFile[1])
            dateString = "2000/07/07" // 第二張專輯發表日
            textString = "五月天的第二張錄音室專輯，此專輯也特地飛到日本的錄音室進行專輯錄製。該專輯銷售量超越前一張專輯，達到35萬張。專輯中附贈五月天全體團員在日本錄音時的相片寫真本。此張專輯獲得第12屆金曲獎最佳樂團獎。"
                
        case 2:
            albumImageName = String(albumFile[2])
            dateString = "2001/07/06" // 第三張專輯發表日
            textString = "五月天的第三張錄音室專輯，也是他們曲風邁向成熟的一個轉捩點。從第一首歌〈一顆蘋果〉層層疊起的空心吉他，轉趨成熟的錄音技巧以及編曲方式，使得內容較前兩張專輯來說更為豐富。歌迷可以感受到五月天已經不再是當初的學生樂團，而是變為成熟的樂手了。首批限量預購版為黃金紀念版 CD ，並附團員全體簽名封面及兩張大型海報。"

        case 3:
            albumImageName = String(albumFile[3])
            dateString = "2003/11/11" // 第四張專輯發表日
            textString = "第四張錄音室專輯是五月天團員服完兵役復出之後的第一張，具有跨越新里程碑的意義。專輯的概念是希望以此專輯當中的音樂來帶領我們穿梭過去、現在、未來，體驗這有如搭乘時光機一般的無比感受。 此專輯獲得第15屆金曲獎最佳樂團獎的殊榮。"
        
        case 4:
            albumImageName = String(albumFile[4])
            dateString = "2004/11/05" // 第五張專輯發表日
            textString = "五月天成立五周年之後的第五張錄音室專輯，專輯發行時還特地標上「五月天五周年」。在日本富士山下河口湖的錄音室製作此專輯，五人都出現一段創作爆發期，把對事物的感動換化成音樂、文字，最後從中選出了12首歌曲為此專輯的原創音樂密碼。專輯名稱是以知名小說家村上春樹的同名小說為命名。此專輯入圍第16屆金曲獎最佳樂團獎。"
            
        case 5:
            albumImageName = String(albumFile[5])
            dateString = "2006/12/29" // 第六張專輯發表日
            textString = "五月天所發表的第六張錄音室專輯，是繼2004年的第五張專輯《神的孩子都在跳舞》之後，睽違兩年的全創作專輯。也是離開滾石唱片成立相信音樂工作室後的第一張專輯。此專輯繼第二張專輯《愛情萬歲》之後，又以「愛」為主題來用音樂深入探討。此專輯在中國預購第一天20萬張被迅速搶定一空，全亞洲銷量在一個月內突破80萬張。"
        
        case 6:
            albumImageName = String(albumFile[6])
            dateString = "2008/10/23" // 第七張專輯發表日
            textString = "在2008年10月23日發行的第七張錄音室專輯，首批預購五萬張限量專輯附贈同年12月13日於台北市中山足球場的新歌演唱會門票。五月天這次與作家九把刀合作，九把刀的新書亦叫做《後青春期的詩》。 此張專輯獲得第20屆金曲獎最佳樂團獎的殊榮。"
        
        case 7:
            albumImageName = String(albumFile[7])
            dateString = "2011/12/16" // 第八張專輯發表日
            textString = "繼2008年《後青春期的詩》後睽違三年的第八張錄音室專輯專輯，標榜「這將會五月天的最後一張專輯，除非2012年不是世界末日」，呈現2012年是否為世界末日之年為概念。專輯分為末日版及明日版，兩版其分別處為曲目順序及部分曲目不同，原因是團員的意見不同，最終決議推出兩種版本。"
        
        case 8:
            albumImageName = String(albumFile[8])
            dateString = "2016/07/21" // 第九張專輯發表日
            textString = "暫別近五年後推出的第九張錄音室專輯並在日本於2017年2月1日發行日本限定盤《自伝 History of  Tomorrow》，其中追加收錄專輯中的兩首歌曲之日語版、及先前所發行的兩首日文單曲。五月天在中華音樂人交流協會以〈頑固〉拿下2016年度十大單曲和〈自傳〉2016年度十大專輯。"
        
        default:
            albumImageName = String(albumFile[0])
            dateString = "1999/07/07" // 第一張專輯發表日
            textString = "0"
                    }
       
        albumCover.image = UIImage(named: albumImageName) // 將上面的 專輯封面圖檔 帶入 IBOutlet albumCover (元件 UI Image View) 中
        
        let date = dateformatter.date(from: dateString)
        dateDisplay.date = date! // 將上面的 專輯發表日 帶入 IBOutlet dateDisplay (元件 UI DatePicker) 中
        let text = textString
        albumInfo.text = text // 將上面的 專輯簡介 帶入 IBOutlet albumInfo (元件 UI Label) 的顯示內容
            }
        

    // 宣告一個名為 displayNextImage 的 function (
    // 與計時器 function timer 連動，可以在讀秒後播放下一張專輯照片
    func displayNextImage() {
        if albumNumber >= albumFile.count {
            albumNumber = 0
            selectAlbumVersion(num1: albumNumber)
            albumCover.image = UIImage(named: albumImageName)
        } else {
            selectAlbumVersion(num1: albumNumber)
            albumCover.image = UIImage(named: albumImageName)
        }
        timeLine.value = Float(albumNumber)
        albumNumber += 1
    }

    // 宣告一個計時器，名為 timeCounter 的 function 與 func displayNextImage 連動，可以在讀秒後播放下一張專輯照片
    func timeCounter() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {(timer) in self.displayNextImage()}
                }
    

    
    // 設置 元件 UI Switch ，並連結 autoPlay 的 IBAction function 作自動播放 (讀秒後自動改變 UI Image View (albumCover)、UI DatePicker (dateDisplay) 及 UI Label (albumInfo) 的顯示內容)
    @IBAction func autoPlay(_ sender: UISwitch) {
        
            if sender.isOn {
                timeCounter() // 執行計時器 func timeCounter
                
            } else {
                timer?.invalidate() // 關閉計時，避免消秏系統資源
                }
    }
    

    
    // 宣告一個名為 timeLineSlider 的 IBAction function，滑動時，會改變 UI Image View (albumCover)、UI DatePicker (dateDisplay) 及 UI Label (albumInfo) 的顯示內容
    @IBAction func timeLineSlider(_ sender: UISlider) {
        sender.value.round() // 因為元件 UI Slider 的數值為 Float (浮點)，所以要將 slider 數值四捨五入取整數，讓 slider 的圓點滑動到整數的位置
        
        selectAlbumVersion(num1:Int(sender.value)) // 將元件 UI Slider 的值帶入 func selectAlbumVersion ，讓 元件 UI Image View (albumCover)、UI DatePicker (dateDisplay) 及 UI Label (albumInfo) 的顯示內容隨之變化
    }
}
