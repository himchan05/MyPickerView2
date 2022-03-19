//
//  ContentView.swift
//  MyPickerView2
//
//  Created by 박힘찬 on 2022/03/19.
//

import SwiftUI

enum School: String, CaseIterable {
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case university = "대학교"
}

struct list: Hashable {
    var id = UUID()
    var name: String
    var school: School
}

struct ContentView: View {
    
    @State var filteredValue = School.elementary
    @State var friendList = [list]()
    
    init() {
        var initlist = [list]()
        for i in 0...20 {
            let friend = list(name: "friend\(i)", school: School.allCases.randomElement() ?? .university)
            initlist.append(friend)
        }
        _friendList = State(initialValue: initlist)
    }
    
    var body: some View {
        VStack {
            Text(self.filteredValue.rawValue)
            
            Picker(" ", selection: self.$filteredValue) {
                Text("초등학교").tag(School.elementary)
                Text("중학교").tag(School.middle)
                Text("고등학교").tag(School.high)
                Text("대학교").tag(School.university)
            }
            .pickerStyle(.segmented)
            
            List {
                ForEach(friendList.filter({$0.school == filteredValue}), id: \.self) { friend in
                    GeometryReader { proxy in
                        HStack {
                            Text("\(friend.id)")
                                .frame(width: proxy.size.width / 3)
                            Text(friend.name)
                                .frame(width: proxy.size.width / 3)
                            Spacer()
                            Text(friend.school.rawValue)
                                .frame(width: proxy.size.width / 3)
                        }
                    }
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
