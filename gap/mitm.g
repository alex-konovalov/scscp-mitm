LoadPackage("openmath");

#############################################################################
#
# OMsymLookup function in the OpenMath package looks up in the global 
# OMsymRecord that maps OpenMath symbols to GAP objects. Below we replace
# it by the version that treats the 'scscp_transient_mitm' content dictionary
# in a special way,    
#
MakeReadWriteGlobal( "OMsymLookup" );
UnbindGlobal( "OMsymLookup" );

BindGlobal("OMsymLookup", function( symbol )
local cd, name;
cd := symbol[1];
name := symbol[2];
if IsBound( OMsymRecord.(cd) ) then
  if IsBound( OMsymRecord.(cd).(name) ) then
    if not OMsymRecord.(cd).(name) = fail then
      return OMsymRecord.(cd).(name);
    else
      # the symbol is present in the CD but not implemented
	  # The number, format and sequence of arguments for the three error messages
	  # below is strongly fixed as it is needed in the SCSCP package to return
	  # standard OpenMath errors to the client
	  Error("OpenMathError: ", "unhandled_symbol", " cd=", symbol[1], " name=", symbol[2]);
    fi;
  else
    # the symbol is not present in the mentioned content dictionary.
	Error("OpenMathError: ", "unexpected_symbol", " cd=", symbol[1], " name=", symbol[2]);
  fi;
elif cd = "scscp_transient_mitm" then
  if IsBoundGlobal( name ) then
    if name <> "Exec" then
      return x -> CallFuncList( EvalString( name ), x );
    else
      Error("'Exec' function is not available" ); 
    fi;  
  else
    Error("There is no function with the name ", name ); 
  fi;
else
  # we didn't even find the cd
  Error("OpenMathError: ", "unsupported_CD", " cd=", symbol[1], " name=", symbol[2]);
fi;  	
end);