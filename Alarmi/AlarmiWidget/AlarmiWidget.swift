//
//  AlarmiWidget.swift
//  AlarmiWidget
//
//  Created by Woody on 2022/07/25.
//  Copyright © 2022 MoTe. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), relevance: nil, configuration: ConfigurationIntent())
    }

    func getSnapshot(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (SimpleEntry) -> Void
    ) {
        if context.isPreview {

        } else {

        }
        let entry = SimpleEntry(date: Date(), relevance: nil, configuration: configuration)
        completion(entry)
    }

    func getTimeline(
        for configuration: ConfigurationIntent,
        in context: Context,
        completion: @escaping (Timeline<Entry>) -> Void
    ) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        for minuteOffset in 0 ..< 60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: minuteOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, relevance: nil, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let relevance: TimelineEntryRelevance? // 관련성
    let configuration: ConfigurationIntent
}

struct AlarmiWidgetEntryView : View {
    @Environment(\.widgetFamily) var family: WidgetFamily

    var entry: Provider.Entry

    var body: some View {
        switch family {
        case .systemSmall:
            Image("work-in-progress")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(10)
        case .systemMedium:
            Image("comfort-zone")
                .resizable()
                .aspectRatio(contentMode: .fit)
        case .systemLarge:
            VStack {
                Image("sleeping")
                    .resizable()
                    .aspectRatio(contentMode: .fit) 
                Image("sleeping")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

        @unknown default:
            fatalError()
        }
    }
}

@main
struct AlarmiWidget: Widget {
    let kind: String = "AlarmiWidget"

    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: kind, provider: Provider()) { entry in
//            AlarmiWidgetEntryView(entry: entry)
//        }
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            AlarmiWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct AlarmiWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            AlarmiWidgetEntryView(entry: SimpleEntry(date: Date(), relevance: nil, configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            AlarmiWidgetEntryView(entry: SimpleEntry(date: Date(), relevance: nil, configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            AlarmiWidgetEntryView(entry: SimpleEntry(date: Date(), relevance: nil, configuration: ConfigurationIntent()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))

        }
    }
}
