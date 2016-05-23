//
//  Instrument.swift
//  melodic_drum_test1_SWIFT
//
//  Created by ciskavriezenga on 23-05-16.
//  Copyright © 2016 Vijay Weemhoff. All rights reserved.
//

import AudioKit


class Voice : AKVoice {
  /// Globally accessible singleton
  static let sharedInstance = Voice()
  
  
  var osc = AKOscillator()
  
  // We'll be using these simply to control volume independent of velocity
  var oscMixer: AKMixer
  
  var sourceMixer: AKMixer
  var adsr: AKAmplitudeEnvelope

  
  override init() {
    oscMixer = AKMixer(osc)
    
    //set default volum osc Mixer
    oscMixer.volume = 0.5
    
    
    sourceMixer = AKMixer(oscMixer)
    
    AudioKit.output = osc;
    
    adsr = AKAmplitudeEnvelope(sourceMixer)
    
    super.init()
    
    //TODO - understand this!
    avAudioNode = adsr.avAudioNode
  }
  
  
  /// Tells whether the node is processing (ie. started, playing, or active)
  /*override var isStarted: Bool {
    //return osc.isPlaying
  }*/
  
  /// Function to start, play, or activate the node, all do the same thing
  override func start() {
    // Do not automatically start the VCOs because the logic about that is higher up
    osc.start()
    
    adsr.start()
    NSLog("Voice - start function");
    
  }
  
  /// Function to stop or bypass the node, both are equivalent
  override func stop() {
    adsr.stop()
  }
}
