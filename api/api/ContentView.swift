import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var isSheetPresented = false
    
    
    @State var dado : Item?
    
    struct Item: Identifiable {
        let id = UUID()
        let dado: game
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(viewModel.games) { index in
                        HStack{
                            AsyncImage(url: URL(string: index.thumbnail!)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 100, height: 100)
                            .onTapGesture {
                                dado = Item(dado: index)
                                isSheetPresented.toggle()
                            }
                            
                            VStack{
                                Text(index.title!)
                            } .padding(40)
                            
                            Spacer()
                        }.padding(40)
                    }
                }
                .onAppear() {
                    viewModel.fetch()
                }
                .sheet(item: $dado) { item in
                    Text(item.dado.short_description!)
                    Image(item.dado.thumbnail!)
                }
                
                
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

