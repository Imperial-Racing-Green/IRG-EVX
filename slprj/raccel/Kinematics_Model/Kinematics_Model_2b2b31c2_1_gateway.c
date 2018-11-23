#include "__cf_Kinematics_Model.h"
#ifdef MATLAB_MEX_FILE
#include "tmwtypes.h"
#else
#include "rtwtypes.h"
#endif
#include "nesl_rtw.h"
#include "Kinematics_Model_2b2b31c2_1.h"
void Kinematics_Model_2b2b31c2_1_gateway ( void ) { NeModelParameters
modelparams = { ( NeSolverType ) 0 , 0.001 , 1 , 0.001 , 0 , 0 , 0 , 0 , (
SscLoggingSetting ) 0 , 464905652 , } ; NeSolverParameters solverparams = { 0
, 0 , 1 , 0 , 0 , 0.001 , 1e-06 , 1e-09 , 0 , 0 , 100 , 0 , 1 , 0 , 1e-06 , 0
, ( NeLocalSolverChoice ) 0 , 0.0001 , 0 , 3 , 2 , ( NeLinearAlgebraChoice )
0 , ( NeEquationFormulationChoice ) 0 , 1024 , 1 , 0.001 , } ; const
NeOutputParameters * outputparameters = NULL ; NeDae * dae ; size_t
numOutputs = 0 ; { static const NeOutputParameters outputparameters_init [ ]
= { { 0 , 0 , "Kinematics_Model/Solver\nConfiguration" , } , } ;
outputparameters = outputparameters_init ; numOutputs = sizeof (
outputparameters_init ) / sizeof ( outputparameters_init [ 0 ] ) ; }
Kinematics_Model_2b2b31c2_1_dae ( & dae , & modelparams , & solverparams ) ;
nesl_register_simulator_group ( "Kinematics_Model/Solver Configuration_1" , 1
, & dae , & solverparams , & modelparams , numOutputs , outputparameters , 1
) ; }
