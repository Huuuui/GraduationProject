//
//  StarList.swift
//  Graduation_Project002
//
//  Created by gzy on 2020/3/9.
//  Copyright © 2020 Graduation_Project. All rights reserved.
//

import SwiftUI

struct StarList: View {
    @ObservedObject var store = StarStore()
    var body: some View {
        NavigationView {
            List {
                ForEach(store.stardates) { star in
                    NavigationLink(destination: Text("ttt")) { // Book()
                        StarView(image: star.image, title: star.title, text: star.text, bookclass: star.bookclass)
                    }
                }
                .onDelete { index in
                    self.store.stardates.remove(at: index.first!)
                    
                }
                .onMove { (source: IndexSet, destination: Int) in
                    self.store.stardates.move(fromOffsets: source, toOffset: destination)
                    
                }
            }
            .navigationBarTitle(Text("收藏"))
        .navigationBarItems(trailing: EditButton())
        }
    }
}

struct StarList_Previews: PreviewProvider {
    static var previews: some View {
        StarList()
    }
}

struct StarView: View {
    var image: String
    var title: String
    var text: String
    var bookclass: String
    var body: some View {
        return HStack{
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:80, height:90)
                .background(Color.blue)
                .cornerRadius(20)
                .padding(.trailing, 4)
            VStack(alignment: .leading, spacing: 8.0) {
                Text(title)
                    .font(.system(size: 20, weight: .bold))
                
                Text(text)
                    .lineLimit(2)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
                Text(bookclass)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                
            }
        }
        .padding(.vertical, 8)
    }
}

struct Stardate: Identifiable {
    var id = UUID()
    var image: String
    var title: String
    var text: String
    var bookclass: String
}

let StardateD = [
    Stardate(image: "test", title:"《百年孤独》", text:"作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪重要的经典文学巨著之一", bookclass:"现代名著"),
    
    Stardate(image: "test", title:"《百年孤独》", text:"作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪重要的经典文学巨著之一", bookclass:"现代名著"),
    
    Stardate(image: "test", title:"《百年孤独》", text:"作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪重要的经典文学巨著之一", bookclass:"现代名著"),
    
    Stardate(image: "test", title:"《百年孤独》", text:"作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪重要的经典文学巨著之一", bookclass:"现代名著"),
    
    Stardate(image: "test", title:"《百年孤独》", text:"作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪重要的经典文学巨著之一", bookclass:"现代名著"),
    
    Stardate(image: "test", title:"《百年孤独》", text:"作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪重要的经典文学巨著之一", bookclass:"现代名著"),
    
    Stardate(image: "test", title:"《百年孤独》", text:"作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪重要的经典文学巨著之一", bookclass:"现代名著"),
    
    Stardate(image: "test", title:"《百年孤独》", text:"作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪重要的经典文学巨著之一", bookclass:"现代名著"),
    
    Stardate(image: "test", title:"《百年孤独》", text:"作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪重要的经典文学巨著之一", bookclass:"现代名著"),
    
    Stardate(image: "test", title:"《百年孤独》", text:"作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪重要的经典文学巨著之一", bookclass:"现代名著"),
    
    Stardate(image: "test", title:"《百年孤独》", text:"作品描写了布恩迪亚家族七代人的传奇故事，以及加勒比海沿岸小镇马孔多的百年兴衰，反映了拉丁美洲一个世纪以来风云变幻的历史。作品融入神话传说、民间故事、宗教典故等神秘因素，巧妙地糅合了现实与虚幻，展现出一个瑰丽的想象世界，成为20世纪重要的经典文学巨著之一", bookclass:"现代名著")
]
