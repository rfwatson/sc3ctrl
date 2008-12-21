// OSCresponderNode(nil, '/testme', { |...args| args.postln }).add

SC3Controller {
  classvar nodes;
  
  *initClass {
    nodes = List[];
    
    Platform.case(\osx) {
      StartUp.add {
        var node;
        node = OSCresponderNode(nil, '/sc3ctrl/cmd') { |t, r, msg|
          msg[1].asString.interpretPrint
        }.add
      }
    }
  }
}