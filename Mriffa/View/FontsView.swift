//
//  FontsView.swift
//  Mriffa
//
//  Created by Sergei Volkov on 11.09.2021.
//

import SwiftUI

struct FontsView: View {
    
    var body: some View {
        
        List(UIFont.familyNames, id:\.self) { font in
            Text(font)
                .font(.custom(font, size: 24))
        }
        
    }
}

struct FontsView_Previews: PreviewProvider {
    static var previews: some View {
        FontsView()
    }
}
