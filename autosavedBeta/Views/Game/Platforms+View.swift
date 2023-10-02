//
//  Platforms+View.swift
//  autosavedBeta
//
//  Created by Asia Serrano on 9/30/23.
//

import SwiftUI

struct PlatformsView: View {

    @State var expanded: [PlatformEnum] = .init()
    @Binding var editMode: EditMode
    @ObservedObject var dict: PropertyDictionary

    init(_ edit: Binding<EditMode>, _ d: PropertyDictionary) {
        self._editMode = edit
        self.dict = d
    }

    private var editing: Bool { self.editMode.isEditing }
    
    var body: some View {

        Section(content: {
            List {
                ForEach(self.dict.platformKeys) {
                    DisclosureView($0, $expanded, $editMode, dict).tag($0)
                }.onDelete(perform: delete)
            }
        }, header: {
            let bool: Bool = !self.editing
            NavigationLink(destination: {
                AddPlatformView(dict)
                    .navigationBarBackButtonHidden(true)
            }, label: {
                HStack(alignment: .center, spacing: 5) {
                    Text(TypeEnum.platform.value).font(.footnote)
                    IconView("chevron.right", .blue, 10).hide(bool)
                }
            })
            .disabled(bool)
            .foregroundColor(bool ? .gray : .blue)
        })
    }

    private func delete(_ off: IndexSet) -> Void {
        withAnimation { off.forEach(self.dict.removePlatform) }
    }

}

extension PlatformsView {

    struct DisclosureView: View {

        @Binding var expanded: [PlatformEnum]
        @Binding var editMode: EditMode
        @ObservedObject var dict: PropertyDictionary

        let key: PlatformEnum

        init(_ p: PlatformEnum,_ exp: Binding<[PlatformEnum]>, _ edit: Binding<EditMode>, _ d: PropertyDictionary) {
            self.key = p
            self._editMode = edit
            self._expanded = exp
            self.dict = d
        }

        private var contains: Bool {
            self.expanded.contains(self.key)
        }
        
        private var binding: Binding<Bool> {
            Binding(get: { self.contains }, set: {
                if $0 { if !self.contains { self.expanded.append(self.key) } }
                else { self.expanded.removeAll(where: { $0 == self.key }) }
            })
        }

        var body: some View {
            DisclosureGroup(self.key.value, isExpanded: self.binding) {
                ForEach(self.dict.getFormats(self.key)) { format in
                    HStack(alignment: .center) {
                        IconView(format.icon)
                        Text(format.value)
                    }.tag(format)
                }.onDelete(perform: delete)
            }
        }

        private func delete(_ off: IndexSet) -> Void {
            withAnimation { off.forEach { self.dict.removeFormat(self.key, $0) } }
        }

    }

}

//struct PlatformView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlatformView()
//    }
//}
