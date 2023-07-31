//
//  Font+.swift
//  Shoong
//
//  Created by 금가경 on 2023/07/28.
//

import SwiftUI

extension Font {
    static func registerFonts() {
        self.register(name: "esamanruOTFLight", withExtension: "otf")
    }
    
    static func register(name: String, withExtension: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: withExtension),CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        else { return print("failed to regist \(name) font") }
    }
}
