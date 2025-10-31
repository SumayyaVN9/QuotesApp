//
//  ContentView.swift
//  QuotesApp
//
//  Created by DDUKK on 09/08/1947 Saka.
//

import SwiftUI


struct ContentView: View {
    @StateObject var  viewmodel = QuotesViewModel()
    @State var newQuote = ""
    @State var EditingQuoteID : UUID? = nil
    @State var editText : String = ""
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                TextField("Search", text: $viewmodel.searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
//                    Divider()
//                    .background(Color.black)
                HStack{
                    TextField("Add Quotes", text: $newQuote)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add"){
                        if !newQuote.isEmpty{
                            viewmodel.AddQuotes(newQuote)
                            newQuote = ""
                        }
                    }
                    .buttonStyle(.borderedProminent)
//                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal)
//                Divider()
//                    .background(Color.black)
                
                List{
                    ForEach($viewmodel.quotes.filter{
                        viewmodel.searchText.isEmpty ? true:
                        $0.text.wrappedValue.localizedStandardContains(viewmodel.searchText)
                        
                    }){
                        $quote in
                        if(EditingQuoteID == $quote.id){
                            TextField("", text: $editText,onCommit: {
                                quote.text = editText
                                EditingQuoteID = nil
                                
                            })
                        }else{
                            Text(quote.text)
                                .onTapGesture {
                                    EditingQuoteID = quote.id
                                    editText = quote.text
                                }
                        }
                    }.onDelete(perform: viewmodel.DeleteQuote)

                    
                }
                
            }        //end of vstack
             .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Favorite Quotes")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.blue)
                        .multilineTextAlignment(.center)

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
