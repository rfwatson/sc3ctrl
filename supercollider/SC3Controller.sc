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
        }.add;
        nodes.add(node);
        
        node = OSCresponderNode(nil, '/sc3ctrl/help') { |t, r, msg|
          { msg[1].asString.openHelpFile }.defer
        }.add;
        nodes.add(node);
       
        node = OSCresponderNode(nil, '/sc3ctrl/class') { |t, r, msg|
          { msg[1].interpret.openCodeFile }.defer
        }.add;
        nodes.add(node);

        node = OSCresponderNode(nil, '/sc3ctrl/implementations') { |t, r, msg|
          { SC3Controller.methodTemplates(msg[1]) }.defer
        }.add;
        nodes.add(node);       
        
        node = OSCresponderNode(nil, '/sc3ctrl/references') { |t, r, msg|
          { SC3Controller.methodReferences(msg[1]) }.defer
        }.add;
        nodes.add(node);
        
        node = OSCresponderNode(nil, '/sc3ctrl/stop') { |t, r, msg|
          thisProcess.stop;
        }.add;
        nodes.add(node);
        
        node = OSCresponderNode(nil, '/sc3ctrl/clear') { |t, r, msg|
          {
            Document.listener.string = ""; "";
          }.defer;
        }.add;
        nodes.add(node);
      }
    }
  }

  // adapated from Kernel.sc
	*methodTemplates { |name|
		var out, found = 0, namestring;
		out = CollStream.new;
		out << "Implementations of '" << name << "' :\n";
		Class.allClasses.do({ arg class;
			class.methods.do({ arg method;
				if (method.name == name, {
					found = found + 1;
					namestring = class.name ++ ":" ++ name;
					out << "   " << namestring << " :     ";
					if (method.argNames.isNil or: { method.argNames.size == 1 }, {
						out << "this." << name;
						if (name.isSetter, { out << "(val)"; });
					},{
						out << method.argNames.at(0);
						if (name.asString.at(0).isAlpha, {
							out << "." << name << "(";
							method.argNames.do({ arg argName, i;
								if (i > 0, {
									if (i != 1, { out << ", " });
									out << argName;
								});
							});
							out << ")";
						},{
							out << " " << name << " ";
							out << method.argNames.at(1);
						});
					});
					out.nl;
				});
			});
		});
		if(found == 0)
		{
			Post << "\nNo implementations of '" << name << "'.\n";
		}
		{
			out.collection.newTextWindow(name.asString);
		};
	}

  // adapted from Kernel.sc
	*methodReferences { |name|
		var out, references;
		name = name.asSymbol;
		out = CollStream.new;
		references = Class.findAllReferences(name);

		if (references.notNil, {
			out << "References to '" << name << "' :\n";
			references.do({ arg ref; out << "   " << ref.asString << "\n"; });
			out.collection.newTextWindow(name.asString);
		},{
			Post << "\nNo references to '" << name << "'.\n";
		});
	}
}