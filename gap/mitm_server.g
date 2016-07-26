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
# Start SCSCP server locally.
#
# To make it accessible from outside, uncomment the 1st call to RunSCSCPserver
# and comment out the 2nd one below.
#
# RunSCSCPserver(true, 26133);
RunSCSCPserver("localhost", 26133);

