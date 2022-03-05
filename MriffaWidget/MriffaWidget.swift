//
//  MriffaWidget.swift
//  MriffaWidget
//
//  Created by Sergei Volkov on 13.10.2021.
//

import WidgetKit
import SwiftUI

var FavoritesCount: Int = 0

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> MriffaEntry {
        MriffaEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (MriffaEntry) -> ()) {
        let entry = MriffaEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [MriffaEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let repeartInterval = UDKeys.AppGroup.load(key: UDKeys.refreshMinutes) as? Int ?? 30
        
        if FavoritesCount == 0 {
            let entry = MriffaEntry(date: currentDate)
            entries.append(entry)
        } else {
            for _ in 0 ..< FavoritesCount {
                let entryDate = Calendar.current.date(byAdding: .minute, value: repeartInterval, to: currentDate)!
                let entry = MriffaEntry(date: entryDate)
                entries.append(entry)
            }
        }
        
        
        
        
        

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct MriffaEntry: TimelineEntry {
    private let affirmations: [AffirmationModel]
    private let categories: Set<CategoryModel>
    let theme: ThemeModel
    let date: Date
    
    init(date: Date) {
        self.date = date
        self.affirmations = MriffaWidgetDataManager.Affirmation.loadAffirmations()
        self.categories = MriffaWidgetDataManager.Categories.loadSelectedCategory()
        self.theme = MriffaWidgetDataManager.Theme.loadSelectedTheme()
        ?? ThemeModel(image: "0", font: UIFont.familyNames.first!, index: 0, fontSize: 12)
        print(#function, theme.image.description)
    }
    
    var filteredAffirmation: AffirmationModel? {
        affirmations.filter { $0.isFavorite }
        .randomElement()
    }
    
    
}

struct MriffaWidgetView: View {
    
    let theme: ThemeModel
    let affirmation: String
    let fontSize: CGFloat

    var body: some View {
        
        Text(affirmation)
            .padding()
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .font(.custom(theme.font, size: fontSize).bold())
            .minimumScaleFactor(0.05)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(
            Image(theme.image + "_preview")
                .resizable()
                .scaledToFill()
                .overlay(Color.black.opacity(0.5))
                .blur(radius: 2)
        )
        
    }
}

struct MriffaWidgetEntryView : View {
    
//    private static let deeplinkURL = URL(string: "widget-deeplink://")!
    private static let deeplink = "widget-deeplink://"
    
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            MriffaWidgetView(theme: entry.theme, affirmation: entry.filteredAffirmation?.text ?? LocalTxt.noFavoritesAffirmations, fontSize: 16)
                
        case .systemMedium:
            MriffaWidgetView(theme: entry.theme, affirmation: entry.filteredAffirmation?.text ?? LocalTxt.noFavoritesAffirmations, fontSize: 20)
                
        case .systemLarge:
            MriffaWidgetView(theme: entry.theme, affirmation: entry.filteredAffirmation?.text ?? LocalTxt.noFavoritesAffirmations, fontSize: 30)
                
        case .systemExtraLarge:
            MriffaWidgetView(theme: entry.theme, affirmation: entry.filteredAffirmation?.text ?? LocalTxt.noFavoritesAffirmations, fontSize: 36)
                
        default:
            MriffaWidgetView(theme: entry.theme, affirmation: entry.filteredAffirmation?.text ?? LocalTxt.noFavoritesAffirmations, fontSize: 20)
                
        }
        
    }
}

@main
struct MriffaWidget: Widget {
    let kind: String = "MriffaWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MriffaWidgetEntryView(entry: entry)
        }
        .configurationDisplayName(NSLocalizedString("Mriffa Widget", comment: "widget name"))
        .description(NSLocalizedString("Mriffa widget shows random affirmation from favorites.", comment: "widget description"))
    }
}

//struct MriffaWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        MriffaWidgetEntryView(entry: MriffaEntry(date: Date()))
//            .previewContext(WidgetPreviewContext(family: .systemMedium))
//    }
//}
