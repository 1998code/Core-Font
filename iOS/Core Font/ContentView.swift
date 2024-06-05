//
//  ContentView.swift
//  Core Font
//
//  Created by Ming on 3/6/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isFontInstalled") private var isFontInstalled = false
    var body: some View {
        NavigationStack {
            ZStack {
                Image("bgHero")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 15)
                    .ignoresSafeArea(.all)
                VStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                        Text("abcdefghijklmnopqrstuvwxyz")
                        Text("1234567890")
                    }
                    .font(.custom("CoreFont-Regular", size: 40))
                    .padding()
                    Spacer()
                    Button(action: {
                        isFontInstalled ? uninstallFont() : installFont()
                    }) {
                        Text(isFontInstalled ? "Installed" : "INSTALL NOW")
                            .font(.custom("CoreFont-Regular", size: 25))
                    }.buttonStyle(.borderedProminent)
                        .disabled(isFontInstalled)
                }.frame(width: 350, height: 550)
            }
            .navigationTitle("Preview")
            .toolbar {
                Text("Regular")
                    .font(.custom("CoreFont-Regular", size: 20))
            }
        }
    }

    func installFont() {
         let fontURLs = [Bundle.main.url(forResource: "Regular", withExtension: "otf")!] as CFArray

         CTFontManagerRegisterFontURLs(fontURLs, .none, true) { errors, done in
             if done {
                 print("Fonts registered successfully")
                 isFontInstalled = true
             } else {
                 print("Font registration failed: \(errors)")
             }
             return true
         }
                
        // for familyName in UIFont.familyNames {
        //     for fontName in UIFont.fontNames(forFamilyName: familyName) {
        //         print(fontName)
        //     }
        // }
    }

    func uninstallFont() {
        let fontName = "CoreFont-Regular"
        var error: Unmanaged<CFError>?
        CTFontManagerUnregisterFontsForURL(Bundle.main.url(forResource: "Regular", withExtension: "otf")! as CFURL, .none, &error)
        if let error = error {
            print("Failed to unregister font: \(error.takeUnretainedValue())")
        } else {
            print("Font unregistered successfully")
            isFontInstalled = false
        }
    }
}

#Preview {
    ContentView()
}
