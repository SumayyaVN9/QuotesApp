//
//  QuotesVM.swift
//  QuotesApp
//
//  Created by DDUKK on 09/08/1947 Saka.
//

import Foundation
import SwiftUI

class QuotesViewModel : ObservableObject{
    @Published var  quotes : [Quote] =
    [
        Quote(text: "Stay hungry, stay foolish."),
        Quote(text: "The best way to predict the future is to invent it."),
        Quote(text: "Simplicity is the ultimate sophistication.")
    ]
    @Published var searchText = ""
     
    var QuoteFilter : [Quote]       //Computed property->it calculates it when accessed.
    {
        if(searchText.isEmpty){
            return quotes
        }else{
            return quotes.filter {
                $0.text.localizedStandardContains(searchText)
            }
        }
    }
    
    func AddQuotes(_ text: String){
        quotes.append(Quote(text: text))
    }
    func DeleteQuote(at offset :IndexSet){
        quotes.remove(atOffsets: offset)
    }
  
}
