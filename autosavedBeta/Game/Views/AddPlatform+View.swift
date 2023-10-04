//
//  AddPlatform+View.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/30/23.
//

import SwiftUI


struct AddPlatformView: CloseableProtocol {

    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewObject: ViewObject

    @State var dismiss: Bool = false
    @State var platform: PlatformEnum? = nil
    @State var formats: [FormatEnum] = .init()

    @ObservedObject var dict: PropertyDictionary

    let disablePlatformSelect: Bool

    init(_ d: PropertyDictionary) {
        self.dict = d
        self.disablePlatformSelect = false
    }
    
    var body: some View {
        Form {
            NavigationLink(destination: {
                SelectPlatformView($platform)
            }, label: {
                FormView("Platform", self.platform?.value)
            }).disabled(self.disablePlatformSelect)

            if let plat: PlatformEnum = self.platform {
                
                Section("\(FormatEnum.DefaultEnum.physical.value) Format") {
                    let containsPhysical: Bool = self.formats.contains(plat.physical)
                    Toggle(plat.physical.value, isOn: Binding(get: { containsPhysical}, set: {
                        if $0 { if !containsPhysical { self.formats.append(plat.physical)}  }
                        else { self.formats.removeAll(where: { $0 == plat.physical }) }
                    }))
                }
                
                if !plat.digital.isEmpty {
                    Section("\(FormatEnum.DefaultEnum.digital.value) Formats") {
                        List {
                            ForEach(plat.digital) { digital in
                                let contains: Bool = self.formats.contains(digital)
                                Button(action: {
                                    if !contains { self.formats.append(digital)}
                                    else { self.formats.removeAll(where: { $0 == digital }) }
                                }, label: { CheckMarkView(digital.value, contains) })
                            }
                        }
                    }
                }
                
            }
        }
        .onChange(of: self.dismiss, perform: self.close)
        .onChange(of: self.platform, perform: { _ in self.formats = .init() })
        .toolbar {

            ToolbarItem(placement:.navigationBarLeading) {
                Button("Cancel", action: {
                    self.platform = nil
                    self.done()
                })
            }

            ToolbarItem(placement:.navigationBarTrailing) { Button("Done", action: self.done).disabled(self.formats.isEmpty) }
        }
    }

    private func done() -> Void {
        if let plat: PlatformEnum = self.platform {
            self.dict.insertPlatform(plat, self.formats)
        }
        self.dismiss = true
    }

}

extension AddPlatformView {

    struct SelectPlatformView: CloseableProtocol {
        
        @Environment(\.presentationMode) var presentationMode
        @EnvironmentObject var viewObject: ViewObject
        @State var dismiss: Bool = false
        @Binding var platform: PlatformEnum?

        init (_ b: Binding<PlatformEnum?>) {
            self._platform = b
        }

        var body: some View {
            List {
                ForEach(PlatformEnum.FamilyEnum.all) { type in
                    Picker(type.value, selection: $platform) {
                        ForEach(type.allPlatforms) { item in
                            Text(item.value).tag(createTag(item))
                        }
                    }.pickerStyle(.inline)
                }
            }
            .onChange(of: self.platform, perform: { _ in self.dismiss.toggle() })
            .onChange(of: self.dismiss, perform: self.close)

        }

        private func createTag(_ item: Any) -> PlatformEnum? {
            item as? PlatformEnum ?? nil
        }

    }

}



//struct AddPlatformView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
////            AddPlatformView()
//            AddPlatformView(.playstation(.PS4), [.physical(.disc), .digital(.psn)])
//        }
//    }
//}
