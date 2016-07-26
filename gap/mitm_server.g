LoadPackage("scscp");
Read("mitm.g");

#############################################################################
#
# Ping-pong example
#
# Take an object x and return OpenMath object produced with MitM_OM 
#
InstallSCSCPprocedure( "MitM_OMobj", x -> OMPlainString( MitM_OM( x ) ) );

#############################################################################
#
# If ping-pong example fails and you suspect that the OpenMath code produced
# by MitM_OM is invalid, you may try this to get the OpenMath code as a string
# and inspect it in your client.
#
InstallSCSCPprocedure( "MitM_OMstring", MitM_OM );

#############################################################################
#
# Generic procedure to evaluate OpenMath code and return back the result.
#
InstallSCSCPprocedure( "EvaluateOpenMath", IdFunc );

#############################################################################
#
# Generic procedure to evaluate GAP command and return back the OpenMath 
# object produced with MitM_OM .
#
GAPtoOpenMath:=function( string )
local stream, result;
if not IsString( string ) then
  Error("The argument must be a string");
fi;
if not string[Length(string)] = ';' then
  Add( string, ';');
fi;
stream := InputTextString(string);
result := READ_COMMAND_REAL(stream, true);
return OMPlainString( MitM_OM( result[2] ) );
end;

InstallSCSCPprocedure( "GAPtoOpenMath", GAPtoOpenMath );

#############################################################################
#
# Generic procedures for conversions between GAP code and OpenMath
#
#############################################################################
#
# OpenMathToOpenMath( <OpenMath plain string> )
#
# Evaluates OpenMath code given as an input (without OMOBJ tags) wrapped in 
# OMPlainString, for example:
# EvaluateBySCSCP( "OpenMathToOpenMath", 
#   [ OMPlainString("<OMA><OMS cd=\"arith1\" name=\"plus\"/><OMI>1</OMI><OMI>2</OMI></OMA>")],
#   "localhost",26133 ); 
OpenMathToOpenMath:=function( omc )
return omc;
end;

OpenMathToString:=function( omc )
return StripLineBreakCharacters(PrintString(omc));
end;

StringToOpenMath:=function( s )
if not IsString(s) then
  Error("The argument must be a string");
fi;
return EvalString(s);
end;

StringToString:=function( string )
local stream, result;
if not IsString( string ) then
  Error("The argument must be a string");
fi;
if not string[Length(string)] = ';' then
  Add( string, ';');
fi;
stream := InputTextString(string);
result := READ_COMMAND_REAL(stream, true);
return StripLineBreakCharacters(PrintString(result[2]));
end;

InstallSCSCPprocedure( "OpenMathToOpenMath", OpenMathToOpenMath, 
	"Evaluates OpenMath code given as an input (without OMOBJ tags) wrapped in OMPlainString", 1, 1 );

InstallSCSCPprocedure( "OpenMathToString", OpenMathToString );

InstallSCSCPprocedure( "StringToOpenMath", StringToOpenMath );

InstallSCSCPprocedure( "StringToString", StringToString );

#############################################################################
#
# Start SCSCP server locally.
#
# To make it accessible from outside, uncomment the 1st call to RunSCSCPserver
# and comment out the 2nd one below.
#
# RunSCSCPserver(true, 26133);
RunSCSCPserver("localhost", 26133);

