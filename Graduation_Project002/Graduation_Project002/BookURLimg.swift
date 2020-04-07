import SwiftUI
import SDWebImageSwiftUI
import Foundation
import CoreLocation

struct BookURLimg: View {
    
    @State var bookimg: URL
    @State var booktitle: String
    @State var bookauthor: String
    @State var bookclass: String
    @State var booktxt: String
    @State var bookfen: String
    @State var jieyue: Bool = false
    
    var body: some View {
        ScrollView {
            VStack{
                HStack {
                    
                        WebImage(url: bookimg)
                        .resizable()
                        .frame(width:120, height:170)
                        .cornerRadius(5)
                        .padding(.all,5)
                        .background(Color.white)
                    
                    VStack(alignment: .leading ,spacing: 29) {
                        Text("作品名称：" + self.booktitle)
                        
                        Text("作者：" + self.bookauthor)
                        
                        Text("类别：" + self.bookclass)
                        
                        Text("豆瓣评分：" + self.bookfen)
                    }
                    Spacer()
                }
                .padding(.bottom,20)
                
                Text("简介：   \n" + "     " + self.booktxt)
                Divider()
                Spacer()
                HStack {
                    Button(action: {
                        self.jieyue.toggle()
                    }) {
                        Image(systemName:"\(self.jieyue ? "star.fill" : "star")")
                            .resizable()
                            .frame(width:40 , height:40)
                        Text("\(self.jieyue ? "已借阅" : "未借阅")")
                    }
                    Spacer()
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName:"star")
                            .resizable()
                            .frame(width:40 , height:40)
                        Text("收藏")
                    }
                    
                }
                .padding()
                
                
            }
            .background(BlurView(style: .systemChromeMaterial))
            //.navigationBarTitle(self.booktitle)
            
        }
        
        
        
    }
}

struct BookURLimg_Previews: PreviewProvider {
    static var previews: some View {
        Book( userid: .constant(""), bookimg: "123", booktitle: "test", bookauthor: "test", bookclass: "test", booktxt: "test",bookfen:"123", bookisbn: "")
    }
}
