//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Luppino, Angelo on 2/15/16.
//  Copyright © 2016 Angelo Luppino. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}