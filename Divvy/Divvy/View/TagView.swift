//
//  TagView.swift
//  Divvy
//
//  Created by Eki Uzamere on 10/29/23.
//

import SwiftUI

struct TagView: View {
    var maxLimit: Int
    @Binding var tags: [Tag]
    
    var title: String = ("Add Some Guests")
    var fontSize: CGFloat = 16
    
    @Namespace var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Text(title)
                .font(.callout)
                .foregroundColor(.white)
            //ScrollView...
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    // Displaying Tags
                    
                    ForEach(getRows(), id: \.self) {rows in
                        
                        HStack(spacing: 6) {
                            ForEach(rows){row in
                                //Row View...
                                RowView(tag: row)
                                
                            }
                        }
                        
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 80, alignment: .leading)
                .padding(.vertical)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(.white.opacity(0.15), lineWidth: 1)
            )
            // Animation...
            .animation(.easeInOut, value: tags)
            .overlay(
                //Limit...
                Text("\(getSize(tags: tags))/\(maxLimit)")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(12),
                alignment: .bottomTrailing
            )
        }
//        .onChange(of: tags) {
//            //getting newly inserted Value...
//            guard let last = tags.last else {
//                return
//            }
//
//            // getting Text Size...
//            let font = UIFont.systemFont(ofSize: fontSize)
//            let attributes = [NSAttributedString.Key.font: font]
//            let size = (last.text as NSString).size(withAttributes: attributes)
//            
//            // Updating Size...
//            tags[getIndex(tag: last)].size = size.width
//            
//        }
    }
    
    @ViewBuilder
    func RowView(tag: Tag)->some View{
        Text(tag.text)
        //applying same font size...
        // else size will vary...
            .font(.system(size: fontSize))
        // adding capsule...
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(.white)
            )
            .foregroundColor(Color("BG"))
            .lineLimit(1)
        // Delete ...
            .contentShape(Capsule())
            .contextMenu {
                Button("Delete") {
                    // deleting...
                    tags.remove(at: getIndex(tag: tag))
                }
            }
            .matchedGeometryEffect(id: tag.id, in: animation)
    }
    
    func getIndex(tag: Tag)->Int{
        let index = tags.firstIndex { currentTag in
            return tag.id == currentTag.id
        } ?? 0
        return index
    }
    
    //Basic Logic...
    //Splitting the array when it exceeds the screen size...
    
    func getRows()->[[Tag]]{
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
        //calculating text width...
        var totalWidth: CGFloat = 0
        
        // for safety extra 10...
        let screenWidth: CGFloat = UIScreen.main.bounds.width - 90
        
        tags.forEach {tag in
            
            // updating total width...
            
            //adding the capsule size into total width spacing...
            // 14 + 14 + 6 + 6
            // extra 6 for safety...
            totalWidth += (tag.size + 40)
            
            // checking if totalwidth is greater than size...
            if totalWidth > screenWidth {
                // adding rows in rows...
                // clearing the data...
                // checking for long string...
                totalWidth = (!currentRow.isEmpty || rows.isEmpty ? (tag.size + 40) : 0)
                rows.append(currentRow)
                currentRow.removeAll()
                currentRow.append(tag)
            } else {
                currentRow.append(tag)
            }
        }
        // Safe check...
        // if having any value storing it in rows...
        if !currentRow.isEmpty {
            rows.append(currentRow)
            currentRow.removeAll()
        }
       return rows
    }
      
}

#Preview {
    ContentView()
}

//Global Function...
func addTag(tags: [Tag], text: String, fontSize: CGFloat, maxLimit: Int, completion: @escaping (Bool, Tag)->()){
    
    //getting Text Size...
    let font = UIFont.systemFont(ofSize: fontSize)
    
    let attributes = [NSAttributedString.Key.font: font]
    
    let size = (text as NSString).size(withAttributes: attributes)
    
    let tag = Tag(text: text, size: size.width)
    
    if (getSize(tags: tags) + text.count) < maxLimit{
        completion(false, tag)
    } else {
        completion(true, tag)
    }
}

func getSize(tags: [Tag])->Int{
    var count: Int = 0
    
    tags.forEach { tag in
        count += tag.text.count
    }
    
    return count
}
