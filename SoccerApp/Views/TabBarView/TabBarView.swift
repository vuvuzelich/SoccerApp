//
//  TabBarView.swift
//  Synenergy
//
//  Created by Макс Лахман on 12.01.2024.
//

import SwiftUI

enum Tab : String, CaseIterable {
    case home = "sparkles"
    case ugol = "gearshift.layout.sixspeed"
    
    var title : String {
        switch self {
        case .home :
            return "Home"
        case .ugol:
            return "Metrics"
        }
    }
}


struct AnimatedTab : Identifiable {
    var id: UUID = UUID()
    var tab : Tab
    var isAnimating : Bool?
}


extension View {
    @ViewBuilder
    func setUpTab(_ tab : Tab) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(tab)
            .toolbar(.hidden, for: .tabBar)
    }
}

struct TabBarView: View {
    @State private var activeTab : Tab = .home
    @State private var allTabs : [AnimatedTab] = Tab.allCases.compactMap { tab -> AnimatedTab in
        return .init(tab: tab)
    }
    var body: some View {
        VStack(spacing: 0){
            TabView(selection: $activeTab){
                NavigationStack{
                    HomeView()
                }.setUpTab(.home)
                NavigationStack{
                    Tab2()
                }.setUpTab(.ugol)
            }
            CustomTabBarView()
        }
    }
    
    
    @ViewBuilder
    func CustomTabBarView() -> some View {
        HStack(spacing : 0){
            ForEach($allTabs) { $animatedTab in
                let tab = animatedTab.tab
                
                ZStack{
                    HStack(spacing : 2){
                        if activeTab == tab {
                            Image(systemName: tab.rawValue)
                                .font(.title2)
                            Text(tab.title)
                                .font(.caption2)
                                .textScale(.secondary)
                        } else {
                            Image(systemName: tab.rawValue)
                                .font(.title2)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(activeTab == tab ? Color("LightBlue") : Color.white)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            activeTab = tab
                        }
                    }
                    
                }
                
            }.padding(.top, 20)
        }.background(Color("MainColorSecond"))
    }
}



#Preview {
    TabBarView()
        .environment(HomeMenuProductsViewModel())
}
