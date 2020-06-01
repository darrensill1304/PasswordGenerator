//
//  ContentView.swift
//  PasswordGenerator
//
//  Created by Darren Sill on 01/06/2020.
//  Copyright © 2020 Darren Sill. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var az : Bool = true
    @State private var AZ : Bool = false
    @State private var nums : Bool = false
    @State private var spec : Bool = false
    @State private var pwdLength : Float = 6.0
    @State private var password : String = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack {
                HStack {
                    Toggle(isOn: $az) {
                        Text("a-z")
                        }.padding()
                    
                    Toggle(isOn: $AZ) {
                        Text("A-Z")
                    }.padding()
                }
                
                HStack {
                    Toggle(isOn: $nums) {
                        Text("0-9")
                    }.padding()
                    Toggle(isOn: $spec) {
                        Text("Special ")
                    }.padding()
                }
                
                VStack {
                    Slider(value: $pwdLength, in: 1...50, step: 1.0)
                    Text("Length: \(Int(pwdLength))")
                }.padding()
            }
            
            Spacer()
            
            VStack {
                Button(action: {
                    self.password = generatePassword(useAzLower: self.az, useAzUpper: self.AZ, useNum: self.nums, useSpecial: self.spec, length: Int(self.pwdLength))
                }) {
                    Text("Generate")
                }
                .disabled(!az && !AZ && !nums && !spec)
                
                Text(password)
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing], 20.0)
            }
            
            Spacer()
        }
    }
}

func generatePassword(useAzLower : Bool, useAzUpper : Bool, useNum : Bool, useSpecial : Bool, length : Int) -> String {
    
    var pwd = ""
    
    var chars : Array<String> = []
    
    if useAzLower { chars.append(contentsOf: Characters.a_z) }
    if useAzUpper { chars.append(contentsOf: Characters.A_Z) }
    if useNum { chars.append(contentsOf: Characters.nums) }
    if useSpecial { chars.append(contentsOf: Characters.spec) }
    
    for _ in 1...length {
        let shuffledChars = chars.shuffled()
        pwd += shuffledChars[0]
    }
    
    return pwd
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
