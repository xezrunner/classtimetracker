//
//  LiveActivityUtils.swift
//  classtimetracker
//
//  Created by Sebastian on 02/03/2023.
//

import Foundation
import ActivityKit

public func startLiveActivity(_ studyClass: StudyClass) -> () -> () {
    return {
        print("requesting live activity for \(studyClass.name)...")
        
        if !ActivityAuthorizationInfo().areActivitiesEnabled {
            print("Live activities unavailable.")
        }
        
        let initialContentState = StudyClassAttributes.ContentState(name: studyClass.name, duration: studyClass.duration, icon: studyClass.icon)
        let activityAttributes = StudyClassAttributes()
        
        let activityContent = ActivityContent(state: initialContentState, staleDate: Calendar.current.date(byAdding: .minute, value: 5, to: Date())!)
        
        do {
            _ = try Activity.request(attributes: activityAttributes, content: activityContent)
        } catch (let error) {
            print("error: \(error.localizedDescription)")
        }
    }
}

public func endAllLiveActivities() {
    Task {
        for it in Activity<StudyClassAttributes>.activities {
            await it.end(nil, dismissalPolicy: .immediate)
        }
        
    }
}
