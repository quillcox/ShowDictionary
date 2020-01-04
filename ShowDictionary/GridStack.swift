// https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-views-in-a-grid
// 12/22/19

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<rows, id: \.self) { row in
                VStack(alignment: .leading) {
                    HStack {
                        ForEach(0..<self.columns) { column in
                            self.content(row, column)
                        }
                    }
                    Divider()
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}
