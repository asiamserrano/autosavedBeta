//
//  Platform+Definitions.swift
//  autosaveBeta
//
//  Created by Asia Serrano on 2/11/26.
//

import Foundation
import Core

extension Platform {

    public struct Builder: ModelKit.Model.Builder.Interface {
                
        public typealias Model = Platform

        public let system: System.Builder
        public let format: Format.Builder
        
        public init(system: System.Builder, format: Format.Builder) {
            if system.formatBuilders.contains(format) {
                self.system = system
                self.format = format
            } else {
                fatalError("Unable to cast system '\(system.rawValue)' and format '\(format.rawValue)' to platform builder")
            }
        }
        
    }
    
}

extension Platform.Builder: ProtocolKit.Random.Compound.Interface {
    
    public static var random: Self {
        let s: System.Builder = .random
        return .init(system: s, format: s.formatBuilders.random)
    }
    
    public var compound: Compound {
        .init(first: self.system, last: self.format)
    }
    
}


import SwiftUI

struct PlatformDefinitionsView: View {
    
    let systemBuilder: System.Builder = .random
    
    var formatBuilder: Format.Builder {
        .random(systemBuilder)
    }
    
    var systemProperty: Property {
        .init(builder: .system(systemBuilder))
    }
    
    var formatProperty: Property {
        .init(builder: .format(formatBuilder))
    }
    
    var platform: Platform {
        .init(system: systemProperty, format: formatProperty, .init(system: systemBuilder, format: formatBuilder))
    }
    
    var platformBuilder: Platform.Builder {
        platform.builder
    }
    
    var body: some View {
        Previewer {
//            Section("systemBuilder", content: {
//                Text(systemBuilder.id)
//            })
//            Section("propertyBuilder", content: {
//                Text(propertyBuilder.instance.id)
//            })
//            Section("platformBuilder", content: {
//                Text(platformBuilder.system.id)
//            })
            
//            CompoundView("systemBuilder", systemBuilder)
//            CompoundView("propertyBuilder", propertyBuilder.instance)
//            CompoundView("platformBuilder", platformBuilder.system)
            
            
            ContainerView("systemBuilder", systemBuilder.debug)
            ContainerView("formatBuilder", formatBuilder.debug)
            ContainerView("systemProperty", systemProperty.debug)
            ContainerView("formatProperty", formatProperty.debug)
            ContainerView("platform", platform.debug)
            ContainerView("platformBuilder", platformBuilder.debug)
            
        }
    }
    
    @ViewBuilder
    private func ContainerView(_ s: String, _ c: String.Container) -> some View {
        DisclosureGroup(s, content: {
            ForEach(c) { element in
                Section(element.key) {
                    Text(element.value)
                }
            }
        })
    }
    
    @ViewBuilder
    private func CompoundView(_ s: String, _ t: any Compoundable.Interface) -> some View {
        Section(s, content: {
            Text(t.id(.newLine))
        })
    }
    
}

#Preview {
    PlatformDefinitionsView()
}
