//
//  CoreDataViewModel.swift
//  Shoong
//
//  Created by Sup on 2023/08/02.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    @State var numOne: Int = 0
    @State var numTwo: Int = 0

    
    let container: NSPersistentContainer
    
    
    @Published var templatesSavedEntities: [TemplatesEntity] = [] //최근을 위한 Template배열
    @Published var pairsSavedEntities: [PairSet] = [] //보관함을 위한 PairSet([Template,Card]) 배열
    
    
    
    // container 초기화
    init() {
        container = NSPersistentContainer(name: "CoreDataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Core Data loading erroe \(error)")
            } else {
                print("Successfully loaded Core Data ")
            }
        }
        
        // container 초기화할 때 각 Entity fetch해주기
        fetchTemplates()
        fetchPairs()
        
    }
    
    // ---------- Mark : 최근에 들어있는 Template에 대한 함수들 총4가지 [시작] ----------------
    
    // 1. Template에 대한 fetch
    func fetchTemplates() {
        
        let request = NSFetchRequest<TemplatesEntity>(entityName: "TemplatesEntity")
        
        do {
            // fetch성공시 templatesSavedEntities에 TemplatesEntity를 배열 형태로 담아주기
            templatesSavedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("error fetching \(error)")
        }
        
    }
    
    // 2. Temaplte 추가
    @MainActor  //UI update은 main Thread에서 이루어져야해서 @MainActor사용
    func addTemplate<V: View>(templateImageD: V, scale: CGFloat){
        
        // 저장된 tempalte 파일이 있으면서 && 저장된 tempalte이 5개 일때부터 추가될때마다 1개씩 삭제
        if !templatesSavedEntities.isEmpty && (templatesSavedEntities.count > 4) {
            deleteTemplate()
        }
        
        // tempalte저장 entity가져오기
        let newTemplate = TemplatesEntity(context: container.viewContext)
        
        // tempalteView 이미지 rendering
        let renderingtemplateView = ImageRenderer(content: templateImageD)
        
        // 화질 문제로 무조건 rendering을 원하는 뷰에 @Environment(\.displayScale) var displayScale 를 넣어주고 displayscale을 addTemplate(scale:)로 넣어줘야 화질의 문제가 없음
        renderingtemplateView.scale = scale
        
        //tempalteView를 Rendering한다음 UiImage로 변환
        if let TemplateViewUimage = renderingtemplateView.uiImage {
            // UiImage를 data로 변환해서 TemplatesEntity의 templateImageD에 담아주기
            newTemplate.templateImageD = TemplateViewUimage.pngData()
        }
        // data저장
        saveData()
        
        
    }
    
    // 3. Temaplte 삭제
    func deleteTemplate(){
        
        // template가 1개라도 있으면 templatesSavedEntities 배열에서 첫번째 삭제
        if !templatesSavedEntities.isEmpty{
            container.viewContext.delete(templatesSavedEntities.removeFirst())
        }
        // 변경내용 저장
        saveData()
    }
    
    // 4. Temaplte 저장
    func saveData(){
        
        do {
            try container.viewContext.save() // container saving
            fetchTemplates() // save되면 Templates fetch시켜주기
        } catch let error {
            print("Error saving \(error)")
        }
        
    }
    // ---------- Mark : 최근에 들어있는 Template에 대한 함수들 [끝] ----------------
    
    // ---------- Mark : 보관함에 들어있는 Pair(Template,Card)에 대한 함수들 총 4가지 [시작] ----------------
    
    // 1. Pair(Template,Card)에 대한 fetch
    func fetchPairs() {
        
        let request = NSFetchRequest<PairEntity>(entityName: "PairEntity")
    
        do {
            // fetch 성공시 fetchedPairs에 Entity넣어주고
            let fetchedPairs = try container.viewContext.fetch(request)
            // PairEntity객체를 받아 PairSet으로 반환 [PairSet1, PairSet2 ...]
            // ==>> [ [templateImageD, cardImageD], [templateImageD, cardImageD] ..] 형태로 반환
            pairsSavedEntities = fetchedPairs.map { PairSet(templateImageD: $0.templateImageD!, cardImageD: $0.cardImageD!) }
        } catch let error {
            print("error fetching pairs \(error)")
        }

        
    }
    
    // 2. Pair(Template,Card) 추가
    @MainActor //UI update은 main Thread에서 이루어져야해서 @MainActor사용
    func addPair<V1: View, V2: View>(templateView: V1, CardView: V2, scale: CGFloat) {
        
        // PairSet이 있으면서 && PairSet의 개수가 10개 초과면 삭제
        if !pairsSavedEntities.isEmpty && (pairsSavedEntities.count > 9) {
            deletePair()
        }
        
        let newPair = PairEntity(context: container.viewContext)
        
        // 각 화면 rendering
        let renderingTemplateView = ImageRenderer(content: templateView)
        let renderingCardView = ImageRenderer(content: CardView)
        
        // 화질 문제로 무조건 rendering을 원하는 뷰에 @Environment(\.displayScale) var displayScale 를 넣어주고 displayscale을 addPair(scale:)로 넣어줘야 화질의 문제가 없음
        renderingTemplateView.scale = scale
        renderingCardView.scale = scale
        
        // renering한 화면 UiImage로 변환
        if let templateViewUimage = renderingTemplateView.uiImage, let CardViewUimage = renderingCardView.uiImage  {
            // UiImage들을 data로 변환하여 각 Attribute에 할당
            newPair.templateImageD = templateViewUimage.pngData()
            newPair.cardImageD = CardViewUimage.pngData()
            
        }
        
        // 변경내용 저장
        savePairData()
    }
    
    
    

    // 3. Pair(Template,Card) 삭제
    func deletePair() {
        
        // pairSavedEntities 배열에 적어도 하나의 요소가 있는지 확인
        if !pairsSavedEntities.isEmpty {
            let request = NSFetchRequest<PairEntity>(entityName: "PairEntity")
            
            do {
                let fetchedPairs = try container.viewContext.fetch(request)
                
                // Core Data에서 첫 번째 PairEntity 객체를 찾아 삭제
                if let firstPair = fetchedPairs.first {
                    container.viewContext.delete(firstPair)
                    savePairData() // 변경 사항을 저장하고 pairSavedEntities 배열 업데이트
                }
            } catch let error {
                print("error fetching pairs \(error)")
            }
        }
        
    }
    
    // 4. Pair(Template,Card)저장
    func savePairData(){
        
        do {
            try container.viewContext.save()
            fetchPairs()
        } catch let error {
            print("Error saving \(error)")
        }
        
    }
    
    // ---------- Mark : 보관함에 들어있는 Pair(Template,Card)에 대한 함수들 [끝] ----------------
    
    
    
    
    
}
