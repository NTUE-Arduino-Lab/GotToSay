import SwiftUI
 
struct SearchBar: View {
    @Binding var text: String
 
    @State private var isEditing = false
	@Environment(\.colorScheme) var colorScheme
    var body: some View {
        HStack {
            //textfieldbug
			_TextField(title: "地點", text: $text, changeColor: true)
                .padding(7)
                .padding(.horizontal, 25)
				.background(Color.white)
                .cornerRadius(8)
				.frame(width: 200, height: 40)
				.overlay(
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 5)
                            }
                        }
                    }
                )
			
                .padding(.horizontal, 5)
//                .onTapGesture {
//                    self.isEditing = true
//                }
 
//            if isEditing {
//                Button(action: {
//                    self.isEditing = false
//                    self.text = ""
//                    // Dismiss the keyboard
//                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//
//                }) {
//                    Text("取消")
//                }
//                .font(.headline)
//                .background(Color.white)
//                .padding(.trailing, 10)
//
//            }
		
		}.padding(.top)
    }
}
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
