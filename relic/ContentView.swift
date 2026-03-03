//
//  ContentView.swift
//  relic
//
//  Created by 최지한 on 7/7/25.
//

import SwiftUI

struct Artifact: Identifiable {
    let id = UUID()
    let name: String
    let fileURL: URL
    let description: String
}

struct ContentView: View {
    @State private var artifacts: [Artifact] = []
    
    private let koreanNames: [String: String] = [
        "comb-pattern pottery": "빗살무늬토기",
        "lute-shaped bronze dagger": "요령식 동검",
        "Gilt-bronze Standing Buddha": "금동여래입상",
        "Bronze Ritual Object with Farming Scene": "농경문 청동기",
        "Lacquered sutra case with Inlaid Mother-of-pearl Design": "나전경함",
        "Stone Seated Ksitigarbha Bodhisattva": "『정덕십년』이 새겨진 석조 지장보살좌상",
        "Gilt‑bronze Seated Avalokitesvara Bodhisattva": "금동관음보살좌상",
        "Bronze Helmet": "청동 투구",
        "Stone Seated Buddha": "석조여래좌상"
    ]
    
    private let artifactDescriptions: [String: String] = [
        "comb-pattern pottery": "오이도패총 출토 빗살무늬토기, 한국민족문화대백과사전",
        "lute-shaped bronze dagger": "요령식 동검, 국립중앙박물관",
        "Gilt-bronze Standing Buddha": "금동여래입상, 국립중앙박물관",
        "Bronze Ritual Object with Farming Scene": "농경문 청동기, 국립중앙박물관",
        "Lacquered sutra case with Inlaid Mother-of-pearl Design": "나전경함, 국립중앙박물관",
        "Stone Seated Ksitigarbha Bodhisattva": "「정덕십년」이 새겨진 석조 지장보살좌상, 국립중앙박물관",
        "Gilt‑bronze Seated Avalokitesvara Bodhisattva": "금동관음보살좌상, 국립중앙박물관",
        "Bronze Helmet": "청동 투구, 국립중앙박물관",
        "Stone Seated Buddha": "석조여래좌상, 국립중앙박물관"
    ]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(artifacts) { artifact in
                        NavigationLink {
                            ZStack {
                                ARQuickLookView(modelFile: artifact.fileURL)
                                    .navigationTitle(artifact.name)
                                    .navigationBarTitleDisplayMode(.inline)
                                VStack {
                                    Image(artifact.name)
                                        .resizable()
                                        .scaledToFit()
                                    Text(artifact.description)
                                }
                            }
                        } label: {
                            Text(artifact.name)
                        }
                    }
                } footer: {
                    Text("ⓒ 국립중앙박물관")
                }
            }
            .navigationTitle("내 손 안에 유물")
            .onAppear {
                loadArtifacts()
            }
        }
    }
    
    private func loadArtifacts() {
        let usdzURLs = Bundle.main.urls(forResourcesWithExtension: "usdz", subdirectory: nil)!
        artifacts = usdzURLs.map { url in
            let baseName = url.deletingPathExtension().lastPathComponent
            let displayName = koreanNames[baseName]!
            let description = artifactDescriptions[baseName]!
            return Artifact(name: displayName, fileURL: url, description: description)
        }
    }
}

#Preview {
    ContentView()
}
