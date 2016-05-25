//
//  Conductor.swift
//  melodic_drum_test1_SWIFT
//
//  A lot of code is copied from the AnalogSynthX by Matthew Fecher from AudioKit
//
//  Created by Vijay Weemhoff on 25-05-16.
//  Copyright © 2016 Vijay Weemhoff. All rights reserved.
//

import Foundation
import AudioKit

class Conductor: AKMIDIListener {
    /// Globally accessible singleton
    static let sharedInstance = Conductor()
    
    var core = CoreInstrument(voiceCount: 3)
    //var bitCrusher: AKBitCrusher
    //var fatten: Fatten
    //var filterSection: FilterSection
    //var multiDelay: MultiDelay
    //var multiDelayMixer: AKDryWetMixer
    
    var masterVolume = AKMixer()
    var reverb: AKCostelloReverb
    var reverbMixer: AKDryWetMixer
    
    var midiBendRange: Double = 2.0
    
    init() {
        AKSettings.audioInputEnabled = true
        //bitCrusher = AKBitCrusher(core)
        //bitCrusher.stop()
        
        //filterSection = FilterSection(bitCrusher)
        //filterSection.output.stop()
        
        //fatten = Fatten(filterSection)
        //multiDelay = MultiDelay(fatten)
        //multiDelayMixer = AKDryWetMixer(fatten, multiDelay, balance: 0.0)
        
        masterVolume = AKMixer(core)
        reverb = AKCostelloReverb(masterVolume)
        reverb.stop()
        
        reverbMixer = AKDryWetMixer(masterVolume, reverb, balance: 0.0)
        
        // uncomment this to allow background operation
        // AKSettings.playbackWhileMuted = true
        
        AudioKit.output = reverbMixer
        AudioKit.start()
        
        let midi = AKMIDI()
        midi.createVirtualPorts()
        midi.openInput("Session 1")
        midi.addListener(self)
    }
    
    // MARK: - AKMIDIListener protocol functions
    
    func receivedMIDINoteOn(note: Int, velocity: Int, channel: Int) {
        core.playNote(note, velocity: velocity)
    }
    func receivedMIDINoteOff(note: Int, velocity: Int, channel: Int) {
        core.stopNote(note)
    }
    func receivedMIDIPitchWheel(pitchWheelValue: Int, channel: Int) {
        let bendSemi =  (Double(pitchWheelValue - 8192) / 8192.0) * midiBendRange
        core.globalbend = bendSemi
    }
    
}