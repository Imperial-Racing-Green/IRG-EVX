#include "__cf_Kinematics_Model.h"
#include "rt_logging_mmi.h"
#include "Kinematics_Model_capi.h"
#include <math.h>
#include "Kinematics_Model.h"
#include "Kinematics_Model_private.h"
#include "Kinematics_Model_dt.h"
extern void * CreateDiagnosticAsVoidPtr_wrapper ( const char * id , int nargs
, ... ) ; RTWExtModeInfo * gblRTWExtModeInfo = NULL ; extern boolean_T
gblExtModeStartPktReceived ; void raccelForceExtModeShutdown ( ) { if ( !
gblExtModeStartPktReceived ) { boolean_T stopRequested = false ;
rtExtModeWaitForStartPkt ( gblRTWExtModeInfo , 2 , & stopRequested ) ; }
rtExtModeShutdown ( 2 ) ; }
#include "slsv_diagnostic_codegen_c_api.h"
const int_T gblNumToFiles = 0 ; const int_T gblNumFrFiles = 0 ; const int_T
gblNumFrWksBlocks = 0 ;
#ifdef RSIM_WITH_SOLVER_MULTITASKING
boolean_T gbl_raccel_isMultitasking = 1 ;
#else
boolean_T gbl_raccel_isMultitasking = 0 ;
#endif
boolean_T gbl_raccel_tid01eq = 0 ; int_T gbl_raccel_NumST = 3 ; const char_T
* gbl_raccel_Version = "9.1 (R2018a) 06-Feb-2018" ; void
raccel_setup_MMIStateLog ( SimStruct * S ) {
#ifdef UseMMIDataLogging
rt_FillStateSigInfoFromMMI ( ssGetRTWLogInfo ( S ) , & ssGetErrorStatus ( S )
) ;
#else
UNUSED_PARAMETER ( S ) ;
#endif
} static DataMapInfo rt_dataMapInfo ; DataMapInfo * rt_dataMapInfoPtr = &
rt_dataMapInfo ; rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr = & (
rt_dataMapInfo . mmi ) ; const char * gblSlvrJacPatternFileName =
"slprj\\raccel\\Kinematics_Model\\Kinematics_Model_Jpattern.mat" ; const
int_T gblNumRootInportBlks = 0 ; const int_T gblNumModelInputs = 0 ; extern
rtInportTUtable * gblInportTUtables ; extern const char * gblInportFileName ;
const int_T gblInportDataTypeIdx [ ] = { - 1 } ; const int_T gblInportDims [
] = { - 1 } ; const int_T gblInportComplex [ ] = { - 1 } ; const int_T
gblInportInterpoFlag [ ] = { - 1 } ; const int_T gblInportContinuous [ ] = {
- 1 } ;
#include "simstruc.h"
#include "fixedpoint.h"
B rtB ; X rtX ; DW rtDW ; static SimStruct model_S ; SimStruct * const rtS =
& model_S ; void MdlInitialize ( void ) { boolean_T tmp ; int_T tmp_p ; char
* tmp_e ; tmp = false ; if ( tmp ) { tmp_p = strcmp ( "ode23t" ,
ssGetSolverName ( rtS ) ) ; if ( tmp_p != 0 ) { tmp_e =
solver_mismatch_message ( "ode23t" , ssGetSolverName ( rtS ) ) ;
ssSetErrorStatus ( rtS , tmp_e ) ; } } } void MdlStart ( void ) {
NeslSimulator * tmp ; boolean_T tmp_p ; NeuDiagnosticManager *
diagnosticManager ; NeModelParameters modelParameters ; real_T tmp_e ;
NeuDiagnosticTree * diagnosticTree ; int32_T tmp_i ; char * msg ;
NeslSimulationData * simulationData ; real_T time ; NeModelParameters
modelParameters_p ; real_T time_p ; NeParameterBundle expl_temp ; { void * *
slioCatalogueAddr = rt_slioCatalogueAddr ( ) ; void * r2 = ( NULL ) ; void *
* pOSigstreamManagerAddr = ( NULL ) ; const int maxErrorBufferSize = 16384 ;
char errMsgCreatingOSigstreamManager [ 16384 ] ; bool
errorCreatingOSigstreamManager = false ; const char *
errorAddingR2SharedResource = ( NULL ) ; * slioCatalogueAddr =
rtwGetNewSlioCatalogue ( rt_GetMatSigLogSelectorFileName ( ) ) ;
errorAddingR2SharedResource = rtwAddR2SharedResource (
rtwGetPointerFromUniquePtr ( rt_slioCatalogue ( ) ) , 1 ) ; if (
errorAddingR2SharedResource != ( NULL ) ) { rtwTerminateSlioCatalogue (
slioCatalogueAddr ) ; * slioCatalogueAddr = ( NULL ) ; ssSetErrorStatus ( rtS
, errorAddingR2SharedResource ) ; return ; } r2 = rtwGetR2SharedResource (
rtwGetPointerFromUniquePtr ( rt_slioCatalogue ( ) ) ) ;
pOSigstreamManagerAddr = rt_GetOSigstreamManagerAddr ( ) ;
errorCreatingOSigstreamManager = rtwOSigstreamManagerCreateInstance (
rt_GetMatSigLogSelectorFileName ( ) , r2 , pOSigstreamManagerAddr ,
errMsgCreatingOSigstreamManager , maxErrorBufferSize ) ; if (
errorCreatingOSigstreamManager ) { * pOSigstreamManagerAddr = ( NULL ) ;
ssSetErrorStatus ( rtS , errMsgCreatingOSigstreamManager ) ; return ; } } {
bool externalInputIsInDatasetFormat = false ; void * pISigstreamManager =
rt_GetISigstreamManager ( ) ; rtwISigstreamManagerGetInputIsInDatasetFormat (
pISigstreamManager , & externalInputIsInDatasetFormat ) ; if (
externalInputIsInDatasetFormat ) { } } tmp = nesl_lease_simulator (
"Kinematics_Model/Solver Configuration_1" , 0 , 0 ) ; rtDW . o1x35mltkr = (
void * ) tmp ; tmp_p = pointer_is_null ( rtDW . o1x35mltkr ) ; if ( tmp_p ) {
Kinematics_Model_2b2b31c2_1_gateway ( ) ; tmp = nesl_lease_simulator (
"Kinematics_Model/Solver Configuration_1" , 0 , 0 ) ; rtDW . o1x35mltkr = (
void * ) tmp ; } simulationData = nesl_create_simulation_data ( ) ; rtDW .
cj1ktnc3lk = ( void * ) simulationData ; diagnosticManager =
rtw_create_diagnostics ( ) ; rtDW . cqqyhb1oov = ( void * ) diagnosticManager
; modelParameters . mSolverType = NE_SOLVER_TYPE_DAE ; modelParameters .
mSolverTolerance = 0.001 ; modelParameters . mVariableStepSolver = true ;
modelParameters . mFixedStepSize = 0.001 ; modelParameters . mStartTime = 0.0
; modelParameters . mLoadInitialState = false ; modelParameters .
mUseSimState = false ; modelParameters . mLinTrimCompile = false ;
modelParameters . mLoggingMode = SSC_LOGGING_NONE ; modelParameters .
mRTWModifiedTimeStamp = 4.64905652E+8 ; tmp_e = 0.001 ; modelParameters .
mSolverTolerance = tmp_e ; tmp_e = 0.0 ; modelParameters . mFixedStepSize =
tmp_e ; tmp_p = true ; modelParameters . mVariableStepSolver = tmp_p ;
diagnosticManager = ( NeuDiagnosticManager * ) rtDW . cqqyhb1oov ;
diagnosticTree = neu_diagnostic_manager_get_initial_tree ( diagnosticManager
) ; tmp_i = nesl_initialize_simulator ( ( NeslSimulator * ) rtDW . o1x35mltkr
, & modelParameters , diagnosticManager ) ; if ( tmp_i != 0 ) { tmp_p =
error_buffer_is_empty ( ssGetErrorStatus ( rtS ) ) ; if ( tmp_p ) { msg =
rtw_diagnostics_msg ( diagnosticTree ) ; ssSetErrorStatus ( rtS , msg ) ; } }
expl_temp . mRealParameters . mN = 0 ; expl_temp . mRealParameters . mX =
NULL ; expl_temp . mLogicalParameters . mN = 0 ; expl_temp .
mLogicalParameters . mX = NULL ; expl_temp . mIntegerParameters . mN = 0 ;
expl_temp . mIntegerParameters . mX = NULL ; expl_temp . mIndexParameters .
mN = 0 ; expl_temp . mIndexParameters . mX = NULL ; nesl_simulator_set_rtps (
( NeslSimulator * ) rtDW . o1x35mltkr , expl_temp ) ; simulationData = (
NeslSimulationData * ) rtDW . cj1ktnc3lk ; time = ssGetT ( rtS ) ;
simulationData -> mData -> mTime . mN = 1 ; simulationData -> mData -> mTime
. mX = & time ; simulationData -> mData -> mContStates . mN = 46 ;
simulationData -> mData -> mContStates . mX = ( real_T * ) & rtX . jydnphmpzk
; simulationData -> mData -> mDiscStates . mN = 0 ; simulationData -> mData
-> mDiscStates . mX = NULL ; simulationData -> mData -> mModeVector . mN = 0
; simulationData -> mData -> mModeVector . mX = NULL ; tmp_p = (
ssIsMajorTimeStep ( rtS ) && ssGetRTWSolverInfo ( rtS ) -> foundContZcEvents
) ; simulationData -> mData -> mFoundZcEvents = tmp_p ; simulationData ->
mData -> mIsMajorTimeStep = ssIsMajorTimeStep ( rtS ) ; tmp_p = (
ssGetMdlInfoPtr ( rtS ) -> mdlFlags . solverAssertCheck == 1U ) ;
simulationData -> mData -> mIsSolverAssertCheck = tmp_p ; tmp_p =
ssIsSolverCheckingCIC ( rtS ) ; simulationData -> mData ->
mIsSolverCheckingCIC = tmp_p ; tmp_p = ssIsSolverComputingJacobian ( rtS ) ;
simulationData -> mData -> mIsComputingJacobian = tmp_p ; simulationData ->
mData -> mIsEvaluatingF0 = ( ssGetEvaluatingF0ForJacobian ( rtS ) != 0 ) ;
tmp_p = ssIsSolverRequestingReset ( rtS ) ; simulationData -> mData ->
mIsSolverRequestingReset = tmp_p ; diagnosticManager = ( NeuDiagnosticManager
* ) rtDW . cqqyhb1oov ; diagnosticTree =
neu_diagnostic_manager_get_initial_tree ( diagnosticManager ) ; tmp_i =
ne_simulator_method ( ( NeslSimulator * ) rtDW . o1x35mltkr ,
NESL_SIM_INITIALIZEONCE , simulationData , diagnosticManager ) ; if ( tmp_i
!= 0 ) { tmp_p = error_buffer_is_empty ( ssGetErrorStatus ( rtS ) ) ; if (
tmp_p ) { msg = rtw_diagnostics_msg ( diagnosticTree ) ; ssSetErrorStatus (
rtS , msg ) ; } } tmp = nesl_lease_simulator (
"Kinematics_Model/Solver Configuration_1" , 2 , 0 ) ; rtDW . kkuw4oox5d = (
void * ) tmp ; tmp_p = pointer_is_null ( rtDW . kkuw4oox5d ) ; if ( tmp_p ) {
Kinematics_Model_2b2b31c2_1_gateway ( ) ; tmp = nesl_lease_simulator (
"Kinematics_Model/Solver Configuration_1" , 2 , 0 ) ; rtDW . kkuw4oox5d = (
void * ) tmp ; } simulationData = nesl_create_simulation_data ( ) ; rtDW .
la5twx144j = ( void * ) simulationData ; diagnosticManager =
rtw_create_diagnostics ( ) ; rtDW . bedbs44pc1 = ( void * ) diagnosticManager
; modelParameters_p . mSolverType = NE_SOLVER_TYPE_DAE ; modelParameters_p .
mSolverTolerance = 0.001 ; modelParameters_p . mVariableStepSolver = true ;
modelParameters_p . mFixedStepSize = 0.001 ; modelParameters_p . mStartTime =
0.0 ; modelParameters_p . mLoadInitialState = false ; modelParameters_p .
mUseSimState = false ; modelParameters_p . mLinTrimCompile = false ;
modelParameters_p . mLoggingMode = SSC_LOGGING_NONE ; modelParameters_p .
mRTWModifiedTimeStamp = 4.64905652E+8 ; tmp_e = 0.001 ; modelParameters_p .
mSolverTolerance = tmp_e ; tmp_e = 0.0 ; modelParameters_p . mFixedStepSize =
tmp_e ; tmp_p = true ; modelParameters_p . mVariableStepSolver = tmp_p ;
diagnosticManager = ( NeuDiagnosticManager * ) rtDW . bedbs44pc1 ;
diagnosticTree = neu_diagnostic_manager_get_initial_tree ( diagnosticManager
) ; tmp_i = nesl_initialize_simulator ( ( NeslSimulator * ) rtDW . kkuw4oox5d
, & modelParameters_p , diagnosticManager ) ; if ( tmp_i != 0 ) { tmp_p =
error_buffer_is_empty ( ssGetErrorStatus ( rtS ) ) ; if ( tmp_p ) { msg =
rtw_diagnostics_msg ( diagnosticTree ) ; ssSetErrorStatus ( rtS , msg ) ; } }
simulationData = ( NeslSimulationData * ) rtDW . la5twx144j ; time_p = ssGetT
( rtS ) ; simulationData -> mData -> mTime . mN = 1 ; simulationData -> mData
-> mTime . mX = & time_p ; simulationData -> mData -> mContStates . mN = 0 ;
simulationData -> mData -> mContStates . mX = NULL ; simulationData -> mData
-> mDiscStates . mN = 0 ; simulationData -> mData -> mDiscStates . mX = NULL
; simulationData -> mData -> mModeVector . mN = 0 ; simulationData -> mData
-> mModeVector . mX = NULL ; tmp_p = ( ssIsMajorTimeStep ( rtS ) &&
ssGetRTWSolverInfo ( rtS ) -> foundContZcEvents ) ; simulationData -> mData
-> mFoundZcEvents = tmp_p ; simulationData -> mData -> mIsMajorTimeStep =
ssIsMajorTimeStep ( rtS ) ; tmp_p = ( ssGetMdlInfoPtr ( rtS ) -> mdlFlags .
solverAssertCheck == 1U ) ; simulationData -> mData -> mIsSolverAssertCheck =
tmp_p ; tmp_p = ssIsSolverCheckingCIC ( rtS ) ; simulationData -> mData ->
mIsSolverCheckingCIC = tmp_p ; simulationData -> mData ->
mIsComputingJacobian = false ; simulationData -> mData -> mIsEvaluatingF0 =
false ; tmp_p = ssIsSolverRequestingReset ( rtS ) ; simulationData -> mData
-> mIsSolverRequestingReset = tmp_p ; diagnosticManager = (
NeuDiagnosticManager * ) rtDW . bedbs44pc1 ; diagnosticTree =
neu_diagnostic_manager_get_initial_tree ( diagnosticManager ) ; tmp_i =
ne_simulator_method ( ( NeslSimulator * ) rtDW . kkuw4oox5d ,
NESL_SIM_INITIALIZEONCE , simulationData , diagnosticManager ) ; if ( tmp_i
!= 0 ) { tmp_p = error_buffer_is_empty ( ssGetErrorStatus ( rtS ) ) ; if (
tmp_p ) { msg = rtw_diagnostics_msg ( diagnosticTree ) ; ssSetErrorStatus (
rtS , msg ) ; } } rtDW . kkswumubfz = 0 ; MdlInitialize ( ) ; } void
MdlOutputs ( int_T tid ) { NeslSimulationData * simulationData ; real_T time
; boolean_T tmp ; real_T tmp_p [ 4 ] ; int_T tmp_e [ 2 ] ;
NeuDiagnosticManager * diagnosticManager ; NeuDiagnosticTree * diagnosticTree
; char * msg ; real_T time_p ; real_T tmp_i [ 50 ] ; int_T tmp_m [ 3 ] ;
int32_T k ; real_T aqkso4nuiw ; real_T lbbful01r2 ; real_T axwruof4sl ;
real_T l5jf0rvjhj ; real_T offset_idx_1 ; if ( ssIsSampleHit ( rtS , 1 , 0 )
) { rtDW . kppix1b1tk = ( ssGetTaskTime ( rtS , 1 ) >= rtP . Ramp_start ) ;
if ( rtDW . kppix1b1tk == 1 ) { rtB . gv3giy2db5 = rtP . Ramp_slope ; } else
{ rtB . gv3giy2db5 = rtP . Step_Y0 ; } } rtB . obltvipdot = ssGetT ( rtS ) -
rtP . Ramp_start ; rtB . j4ni2uuhra = rtB . gv3giy2db5 * rtB . obltvipdot ;
rtB . eiuokjsxp3 = rtB . j4ni2uuhra + rtP . Ramp_InitialOutput ; rtB .
iddoisgbzq [ 0 ] = 0.001 * rtB . eiuokjsxp3 ; rtB . iddoisgbzq [ 1 ] = 0.0 ;
rtB . iddoisgbzq [ 2 ] = 0.0 ; if ( ssIsMajorTimeStep ( rtS ) ) { rtDW .
leypwq55mm [ 0 ] = ! ( rtB . iddoisgbzq [ 2 ] == rtDW . leypwq55mm [ 1 ] ) ;
rtDW . leypwq55mm [ 1 ] = rtB . iddoisgbzq [ 2 ] ; } rtB . iddoisgbzq [ 2 ] =
rtDW . leypwq55mm [ 1 ] ; rtB . iddoisgbzq [ 3 ] = rtDW . leypwq55mm [ 0 ] ;
simulationData = ( NeslSimulationData * ) rtDW . cj1ktnc3lk ; time = ssGetT (
rtS ) ; simulationData -> mData -> mTime . mN = 1 ; simulationData -> mData
-> mTime . mX = & time ; simulationData -> mData -> mContStates . mN = 46 ;
simulationData -> mData -> mContStates . mX = ( real_T * ) & rtX . jydnphmpzk
; simulationData -> mData -> mDiscStates . mN = 0 ; simulationData -> mData
-> mDiscStates . mX = NULL ; simulationData -> mData -> mModeVector . mN = 0
; simulationData -> mData -> mModeVector . mX = NULL ; tmp = (
ssIsMajorTimeStep ( rtS ) && ssGetRTWSolverInfo ( rtS ) -> foundContZcEvents
) ; simulationData -> mData -> mFoundZcEvents = tmp ; simulationData -> mData
-> mIsMajorTimeStep = ssIsMajorTimeStep ( rtS ) ; tmp = ( ssGetMdlInfoPtr (
rtS ) -> mdlFlags . solverAssertCheck == 1U ) ; simulationData -> mData ->
mIsSolverAssertCheck = tmp ; tmp = ssIsSolverCheckingCIC ( rtS ) ;
simulationData -> mData -> mIsSolverCheckingCIC = tmp ; tmp =
ssIsSolverComputingJacobian ( rtS ) ; simulationData -> mData ->
mIsComputingJacobian = tmp ; simulationData -> mData -> mIsEvaluatingF0 = (
ssGetEvaluatingF0ForJacobian ( rtS ) != 0 ) ; tmp = ssIsSolverRequestingReset
( rtS ) ; simulationData -> mData -> mIsSolverRequestingReset = tmp ; tmp_e [
0 ] = 0 ; tmp_p [ 0 ] = rtB . iddoisgbzq [ 0 ] ; tmp_p [ 1 ] = rtB .
iddoisgbzq [ 1 ] ; tmp_p [ 2 ] = rtB . iddoisgbzq [ 2 ] ; tmp_p [ 3 ] = rtB .
iddoisgbzq [ 3 ] ; tmp_e [ 1 ] = 4 ; simulationData -> mData -> mInputValues
. mN = 4 ; simulationData -> mData -> mInputValues . mX = & tmp_p [ 0 ] ;
simulationData -> mData -> mInputOffsets . mN = 2 ; simulationData -> mData
-> mInputOffsets . mX = & tmp_e [ 0 ] ; simulationData -> mData -> mOutputs .
mN = 46 ; simulationData -> mData -> mOutputs . mX = & rtB . i2vms01m1k [ 0 ]
; simulationData -> mData -> mSampleHits . mN = 0 ; simulationData -> mData
-> mSampleHits . mX = NULL ; simulationData -> mData ->
mIsFundamentalSampleHit = false ; simulationData -> mData -> mTolerances . mN
= 0 ; simulationData -> mData -> mTolerances . mX = NULL ; simulationData ->
mData -> mCstateHasChanged = false ; diagnosticManager = (
NeuDiagnosticManager * ) rtDW . cqqyhb1oov ; diagnosticTree =
neu_diagnostic_manager_get_initial_tree ( diagnosticManager ) ; k =
ne_simulator_method ( ( NeslSimulator * ) rtDW . o1x35mltkr ,
NESL_SIM_OUTPUTS , simulationData , diagnosticManager ) ; if ( k != 0 ) { tmp
= error_buffer_is_empty ( ssGetErrorStatus ( rtS ) ) ; if ( tmp ) { msg =
rtw_diagnostics_msg ( diagnosticTree ) ; ssSetErrorStatus ( rtS , msg ) ; } }
if ( ssIsMajorTimeStep ( rtS ) && simulationData -> mData ->
mCstateHasChanged ) { ssSetBlockStateForSolverChangedAtMajorStep ( rtS ) ; }
simulationData = ( NeslSimulationData * ) rtDW . la5twx144j ; time_p = ssGetT
( rtS ) ; simulationData -> mData -> mTime . mN = 1 ; simulationData -> mData
-> mTime . mX = & time_p ; simulationData -> mData -> mContStates . mN = 0 ;
simulationData -> mData -> mContStates . mX = NULL ; simulationData -> mData
-> mDiscStates . mN = 0 ; simulationData -> mData -> mDiscStates . mX = NULL
; simulationData -> mData -> mModeVector . mN = 0 ; simulationData -> mData
-> mModeVector . mX = NULL ; tmp = ( ssIsMajorTimeStep ( rtS ) &&
ssGetRTWSolverInfo ( rtS ) -> foundContZcEvents ) ; simulationData -> mData
-> mFoundZcEvents = tmp ; simulationData -> mData -> mIsMajorTimeStep =
ssIsMajorTimeStep ( rtS ) ; tmp = ( ssGetMdlInfoPtr ( rtS ) -> mdlFlags .
solverAssertCheck == 1U ) ; simulationData -> mData -> mIsSolverAssertCheck =
tmp ; tmp = ssIsSolverCheckingCIC ( rtS ) ; simulationData -> mData ->
mIsSolverCheckingCIC = tmp ; simulationData -> mData -> mIsComputingJacobian
= false ; simulationData -> mData -> mIsEvaluatingF0 = false ; tmp =
ssIsSolverRequestingReset ( rtS ) ; simulationData -> mData ->
mIsSolverRequestingReset = tmp ; tmp_m [ 0 ] = 0 ; tmp_i [ 0 ] = rtB .
iddoisgbzq [ 0 ] ; tmp_i [ 1 ] = rtB . iddoisgbzq [ 1 ] ; tmp_i [ 2 ] = rtB .
iddoisgbzq [ 2 ] ; tmp_i [ 3 ] = rtB . iddoisgbzq [ 3 ] ; tmp_m [ 1 ] = 4 ;
memcpy ( & tmp_i [ 4 ] , & rtB . i2vms01m1k [ 0 ] , 46U * sizeof ( real_T ) )
; tmp_m [ 2 ] = 50 ; simulationData -> mData -> mInputValues . mN = 50 ;
simulationData -> mData -> mInputValues . mX = & tmp_i [ 0 ] ; simulationData
-> mData -> mInputOffsets . mN = 3 ; simulationData -> mData -> mInputOffsets
. mX = & tmp_m [ 0 ] ; simulationData -> mData -> mOutputs . mN = 19 ;
simulationData -> mData -> mOutputs . mX = & rtB . fu5va5q0fk [ 0 ] ;
simulationData -> mData -> mSampleHits . mN = 0 ; simulationData -> mData ->
mSampleHits . mX = NULL ; simulationData -> mData -> mIsFundamentalSampleHit
= false ; simulationData -> mData -> mTolerances . mN = 0 ; simulationData ->
mData -> mTolerances . mX = NULL ; simulationData -> mData ->
mCstateHasChanged = false ; diagnosticManager = ( NeuDiagnosticManager * )
rtDW . bedbs44pc1 ; diagnosticTree = neu_diagnostic_manager_get_initial_tree
( diagnosticManager ) ; k = ne_simulator_method ( ( NeslSimulator * ) rtDW .
kkuw4oox5d , NESL_SIM_OUTPUTS , simulationData , diagnosticManager ) ; if ( k
!= 0 ) { tmp = error_buffer_is_empty ( ssGetErrorStatus ( rtS ) ) ; if ( tmp
) { msg = rtw_diagnostics_msg ( diagnosticTree ) ; ssSetErrorStatus ( rtS ,
msg ) ; } } if ( ssIsMajorTimeStep ( rtS ) && simulationData -> mData ->
mCstateHasChanged ) { ssSetBlockStateForSolverChangedAtMajorStep ( rtS ) ; }
l5jf0rvjhj = rtB . fu5va5q0fk [ 0 ] * rtB . fu5va5q0fk [ 0 ] ; axwruof4sl =
rtB . fu5va5q0fk [ 1 ] * rtB . fu5va5q0fk [ 1 ] ; lbbful01r2 = rtB .
fu5va5q0fk [ 2 ] * rtB . fu5va5q0fk [ 2 ] ; aqkso4nuiw = rtB . fu5va5q0fk [ 3
] * rtB . fu5va5q0fk [ 3 ] ; axwruof4sl = ( ( l5jf0rvjhj + axwruof4sl ) +
lbbful01r2 ) + aqkso4nuiw ; if ( ssIsMajorTimeStep ( rtS ) ) { if ( rtDW .
kkswumubfz != 0 ) { ssSetBlockStateForSolverChangedAtMajorStep ( rtS ) ; rtDW
. kkswumubfz = 0 ; } l5jf0rvjhj = muDoubleScalarSqrt ( axwruof4sl ) ; } else
if ( axwruof4sl < 0.0 ) { l5jf0rvjhj = - muDoubleScalarSqrt (
muDoubleScalarAbs ( axwruof4sl ) ) ; rtDW . kkswumubfz = 1 ; } else {
l5jf0rvjhj = muDoubleScalarSqrt ( axwruof4sl ) ; } axwruof4sl = rtB .
fu5va5q0fk [ 0 ] / l5jf0rvjhj ; lbbful01r2 = rtB . fu5va5q0fk [ 1 ] /
l5jf0rvjhj ; aqkso4nuiw = rtB . fu5va5q0fk [ 2 ] / l5jf0rvjhj ; l5jf0rvjhj =
rtB . fu5va5q0fk [ 3 ] / l5jf0rvjhj ; offset_idx_1 = ( lbbful01r2 *
aqkso4nuiw - axwruof4sl * l5jf0rvjhj ) * - 2.0 ; rtB . lm30xe5jws [ 0 ] =
muDoubleScalarAtan2 ( ( aqkso4nuiw * l5jf0rvjhj + axwruof4sl * lbbful01r2 ) *
2.0 , ( ( axwruof4sl * axwruof4sl - lbbful01r2 * lbbful01r2 ) + aqkso4nuiw *
aqkso4nuiw ) - l5jf0rvjhj * l5jf0rvjhj ) * rtP . RadtoDeg1_Gain ; if (
offset_idx_1 > 1.0 ) { offset_idx_1 = 1.0 ; } else { if ( offset_idx_1 < -
1.0 ) { offset_idx_1 = - 1.0 ; } } rtB . lm30xe5jws [ 1 ] = rtP .
RadtoDeg1_Gain * muDoubleScalarAsin ( offset_idx_1 ) ; rtB . lm30xe5jws [ 2 ]
= muDoubleScalarAtan2 ( ( lbbful01r2 * l5jf0rvjhj + axwruof4sl * aqkso4nuiw )
* 2.0 , ( ( axwruof4sl * axwruof4sl + lbbful01r2 * lbbful01r2 ) - aqkso4nuiw
* aqkso4nuiw ) - l5jf0rvjhj * l5jf0rvjhj ) * rtP . RadtoDeg1_Gain ; rtB .
dhnxzb0mjy = rtP . GAIN_Gain * rtB . fu5va5q0fk [ 7 ] ; rtB . hfor1olrf3 =
rtP . GAIN_Gain_pbdfkn5gz3 * rtB . fu5va5q0fk [ 8 ] ; rtB . mx4i5itgxl = rtP
. GAIN_Gain_lywuarbb30 * rtB . fu5va5q0fk [ 9 ] ; rtB . lwjktixzcr = rtP .
GAIN_Gain_gxcz5voktz * rtB . fu5va5q0fk [ 16 ] ; rtB . dhtriljxim = rtP .
GAIN_Gain_jvq3gsrwwi * rtB . fu5va5q0fk [ 17 ] ; rtB . fwm0oglrrd = rtP .
GAIN_Gain_ctvvappo4m * rtB . fu5va5q0fk [ 18 ] ; rtB . b5eq3qyadt = rtP .
GAIN_Gain_bsdtfq1oje * rtB . fu5va5q0fk [ 10 ] ; rtB . a3n000o3dc = rtP .
GAIN_Gain_m2vt0o0ref * rtB . fu5va5q0fk [ 11 ] ; rtB . nemcj5dj2s = rtP .
GAIN_Gain_oyqy0mqpvg * rtB . fu5va5q0fk [ 12 ] ; rtB . mlyhvtju52 = - (
muDoubleScalarAtan ( ( rtB . lwjktixzcr - rtB . b5eq3qyadt ) / ( rtB .
fwm0oglrrd - rtB . nemcj5dj2s ) ) * 57.295779513082323 ) ; rtB . l1y0dfbwhu =
- ( muDoubleScalarAtan ( ( rtB . dhtriljxim - rtB . a3n000o3dc ) / ( rtB .
fwm0oglrrd - rtB . nemcj5dj2s ) ) * 57.295779513082323 ) ; axwruof4sl = 0.0 ;
lbbful01r2 = rtB . b5eq3qyadt - rtB . lwjktixzcr ; l5jf0rvjhj = 0.0 *
lbbful01r2 ; aqkso4nuiw = lbbful01r2 ; offset_idx_1 = 0.0 ; lbbful01r2 = rtB
. a3n000o3dc - rtB . dhtriljxim ; l5jf0rvjhj += 0.0 * lbbful01r2 ; l5jf0rvjhj
+= rtB . nemcj5dj2s - rtB . fwm0oglrrd ; if ( ! ( muDoubleScalarAbs (
l5jf0rvjhj ) < 1.0E-7 ) ) { l5jf0rvjhj = - ( ( ( rtB . lwjktixzcr - rtB .
dhnxzb0mjy ) * 0.0 + ( rtB . dhtriljxim - rtB . hfor1olrf3 ) * 0.0 ) + ( rtB
. fwm0oglrrd - rtB . mx4i5itgxl ) ) / l5jf0rvjhj ; axwruof4sl = l5jf0rvjhj *
aqkso4nuiw + rtB . lwjktixzcr ; offset_idx_1 = l5jf0rvjhj * lbbful01r2 + rtB
. dhtriljxim ; } rtB . nbxx2m2i4y = axwruof4sl - rtB . dhnxzb0mjy ; rtB .
jhd0dnnqdb = - ( offset_idx_1 - rtB . hfor1olrf3 ) ; rtB . esthmbhcld = rtP .
GAIN_Gain_ej1b40oukw * rtB . fu5va5q0fk [ 13 ] ; rtB . n3xnawh3kp = rtP .
GAIN_Gain_dntmztrkvr * rtB . fu5va5q0fk [ 14 ] ; rtB . gbcq0debgs = rtP .
GAIN_Gain_lfuqkyc0tg * rtB . fu5va5q0fk [ 15 ] ; UNUSED_PARAMETER ( tid ) ; }
void MdlUpdate ( int_T tid ) { NeslSimulationData * simulationData ; real_T
time ; boolean_T tmp ; real_T tmp_p [ 4 ] ; int_T tmp_e [ 2 ] ;
NeuDiagnosticManager * diagnosticManager ; NeuDiagnosticTree * diagnosticTree
; int32_T tmp_i ; char * msg ; simulationData = ( NeslSimulationData * ) rtDW
. cj1ktnc3lk ; time = ssGetT ( rtS ) ; simulationData -> mData -> mTime . mN
= 1 ; simulationData -> mData -> mTime . mX = & time ; simulationData ->
mData -> mContStates . mN = 46 ; simulationData -> mData -> mContStates . mX
= ( real_T * ) & rtX . jydnphmpzk ; simulationData -> mData -> mDiscStates .
mN = 0 ; simulationData -> mData -> mDiscStates . mX = NULL ; simulationData
-> mData -> mModeVector . mN = 0 ; simulationData -> mData -> mModeVector .
mX = NULL ; tmp = ( ssIsMajorTimeStep ( rtS ) && ssGetRTWSolverInfo ( rtS )
-> foundContZcEvents ) ; simulationData -> mData -> mFoundZcEvents = tmp ;
simulationData -> mData -> mIsMajorTimeStep = ssIsMajorTimeStep ( rtS ) ; tmp
= ( ssGetMdlInfoPtr ( rtS ) -> mdlFlags . solverAssertCheck == 1U ) ;
simulationData -> mData -> mIsSolverAssertCheck = tmp ; tmp =
ssIsSolverCheckingCIC ( rtS ) ; simulationData -> mData ->
mIsSolverCheckingCIC = tmp ; tmp = ssIsSolverComputingJacobian ( rtS ) ;
simulationData -> mData -> mIsComputingJacobian = tmp ; simulationData ->
mData -> mIsEvaluatingF0 = ( ssGetEvaluatingF0ForJacobian ( rtS ) != 0 ) ;
tmp = ssIsSolverRequestingReset ( rtS ) ; simulationData -> mData ->
mIsSolverRequestingReset = tmp ; tmp_e [ 0 ] = 0 ; tmp_p [ 0 ] = rtB .
iddoisgbzq [ 0 ] ; tmp_p [ 1 ] = rtB . iddoisgbzq [ 1 ] ; tmp_p [ 2 ] = rtB .
iddoisgbzq [ 2 ] ; tmp_p [ 3 ] = rtB . iddoisgbzq [ 3 ] ; tmp_e [ 1 ] = 4 ;
simulationData -> mData -> mInputValues . mN = 4 ; simulationData -> mData ->
mInputValues . mX = & tmp_p [ 0 ] ; simulationData -> mData -> mInputOffsets
. mN = 2 ; simulationData -> mData -> mInputOffsets . mX = & tmp_e [ 0 ] ;
diagnosticManager = ( NeuDiagnosticManager * ) rtDW . cqqyhb1oov ;
diagnosticTree = neu_diagnostic_manager_get_initial_tree ( diagnosticManager
) ; tmp_i = ne_simulator_method ( ( NeslSimulator * ) rtDW . o1x35mltkr ,
NESL_SIM_UPDATE , simulationData , diagnosticManager ) ; if ( tmp_i != 0 ) {
tmp = error_buffer_is_empty ( ssGetErrorStatus ( rtS ) ) ; if ( tmp ) { msg =
rtw_diagnostics_msg ( diagnosticTree ) ; ssSetErrorStatus ( rtS , msg ) ; } }
UNUSED_PARAMETER ( tid ) ; } void MdlUpdateTID2 ( int_T tid ) {
UNUSED_PARAMETER ( tid ) ; } void MdlDerivatives ( void ) {
NeslSimulationData * simulationData ; real_T time ; boolean_T tmp ; real_T
tmp_p [ 4 ] ; int_T tmp_e [ 2 ] ; NeuDiagnosticManager * diagnosticManager ;
NeuDiagnosticTree * diagnosticTree ; int32_T tmp_i ; char * msg ; XDot *
_rtXdot ; _rtXdot = ( ( XDot * ) ssGetdX ( rtS ) ) ; simulationData = (
NeslSimulationData * ) rtDW . cj1ktnc3lk ; time = ssGetT ( rtS ) ;
simulationData -> mData -> mTime . mN = 1 ; simulationData -> mData -> mTime
. mX = & time ; simulationData -> mData -> mContStates . mN = 46 ;
simulationData -> mData -> mContStates . mX = ( real_T * ) & rtX . jydnphmpzk
; simulationData -> mData -> mDiscStates . mN = 0 ; simulationData -> mData
-> mDiscStates . mX = NULL ; simulationData -> mData -> mModeVector . mN = 0
; simulationData -> mData -> mModeVector . mX = NULL ; tmp = (
ssIsMajorTimeStep ( rtS ) && ssGetRTWSolverInfo ( rtS ) -> foundContZcEvents
) ; simulationData -> mData -> mFoundZcEvents = tmp ; simulationData -> mData
-> mIsMajorTimeStep = ssIsMajorTimeStep ( rtS ) ; tmp = ( ssGetMdlInfoPtr (
rtS ) -> mdlFlags . solverAssertCheck == 1U ) ; simulationData -> mData ->
mIsSolverAssertCheck = tmp ; tmp = ssIsSolverCheckingCIC ( rtS ) ;
simulationData -> mData -> mIsSolverCheckingCIC = tmp ; tmp =
ssIsSolverComputingJacobian ( rtS ) ; simulationData -> mData ->
mIsComputingJacobian = tmp ; simulationData -> mData -> mIsEvaluatingF0 = (
ssGetEvaluatingF0ForJacobian ( rtS ) != 0 ) ; tmp = ssIsSolverRequestingReset
( rtS ) ; simulationData -> mData -> mIsSolverRequestingReset = tmp ; tmp_e [
0 ] = 0 ; tmp_p [ 0 ] = rtB . iddoisgbzq [ 0 ] ; tmp_p [ 1 ] = rtB .
iddoisgbzq [ 1 ] ; tmp_p [ 2 ] = rtB . iddoisgbzq [ 2 ] ; tmp_p [ 3 ] = rtB .
iddoisgbzq [ 3 ] ; tmp_e [ 1 ] = 4 ; simulationData -> mData -> mInputValues
. mN = 4 ; simulationData -> mData -> mInputValues . mX = & tmp_p [ 0 ] ;
simulationData -> mData -> mInputOffsets . mN = 2 ; simulationData -> mData
-> mInputOffsets . mX = & tmp_e [ 0 ] ; simulationData -> mData -> mDx . mN =
46 ; simulationData -> mData -> mDx . mX = ( real_T * ) & _rtXdot ->
jydnphmpzk ; diagnosticManager = ( NeuDiagnosticManager * ) rtDW . cqqyhb1oov
; diagnosticTree = neu_diagnostic_manager_get_initial_tree (
diagnosticManager ) ; tmp_i = ne_simulator_method ( ( NeslSimulator * ) rtDW
. o1x35mltkr , NESL_SIM_DERIVATIVES , simulationData , diagnosticManager ) ;
if ( tmp_i != 0 ) { tmp = error_buffer_is_empty ( ssGetErrorStatus ( rtS ) )
; if ( tmp ) { msg = rtw_diagnostics_msg ( diagnosticTree ) ;
ssSetErrorStatus ( rtS , msg ) ; } } } void MdlProjection ( void ) {
NeslSimulationData * simulationData ; real_T time ; boolean_T tmp ; real_T
tmp_p [ 4 ] ; int_T tmp_e [ 2 ] ; NeuDiagnosticManager * diagnosticManager ;
NeuDiagnosticTree * diagnosticTree ; int32_T tmp_i ; char * msg ;
simulationData = ( NeslSimulationData * ) rtDW . cj1ktnc3lk ; time = ssGetT (
rtS ) ; simulationData -> mData -> mTime . mN = 1 ; simulationData -> mData
-> mTime . mX = & time ; simulationData -> mData -> mContStates . mN = 46 ;
simulationData -> mData -> mContStates . mX = ( real_T * ) & rtX . jydnphmpzk
; simulationData -> mData -> mDiscStates . mN = 0 ; simulationData -> mData
-> mDiscStates . mX = NULL ; simulationData -> mData -> mModeVector . mN = 0
; simulationData -> mData -> mModeVector . mX = NULL ; tmp = (
ssIsMajorTimeStep ( rtS ) && ssGetRTWSolverInfo ( rtS ) -> foundContZcEvents
) ; simulationData -> mData -> mFoundZcEvents = tmp ; simulationData -> mData
-> mIsMajorTimeStep = ssIsMajorTimeStep ( rtS ) ; tmp = ( ssGetMdlInfoPtr (
rtS ) -> mdlFlags . solverAssertCheck == 1U ) ; simulationData -> mData ->
mIsSolverAssertCheck = tmp ; tmp = ssIsSolverCheckingCIC ( rtS ) ;
simulationData -> mData -> mIsSolverCheckingCIC = tmp ; tmp =
ssIsSolverComputingJacobian ( rtS ) ; simulationData -> mData ->
mIsComputingJacobian = tmp ; simulationData -> mData -> mIsEvaluatingF0 = (
ssGetEvaluatingF0ForJacobian ( rtS ) != 0 ) ; tmp = ssIsSolverRequestingReset
( rtS ) ; simulationData -> mData -> mIsSolverRequestingReset = tmp ; tmp_e [
0 ] = 0 ; tmp_p [ 0 ] = rtB . iddoisgbzq [ 0 ] ; tmp_p [ 1 ] = rtB .
iddoisgbzq [ 1 ] ; tmp_p [ 2 ] = rtB . iddoisgbzq [ 2 ] ; tmp_p [ 3 ] = rtB .
iddoisgbzq [ 3 ] ; tmp_e [ 1 ] = 4 ; simulationData -> mData -> mInputValues
. mN = 4 ; simulationData -> mData -> mInputValues . mX = & tmp_p [ 0 ] ;
simulationData -> mData -> mInputOffsets . mN = 2 ; simulationData -> mData
-> mInputOffsets . mX = & tmp_e [ 0 ] ; diagnosticManager = (
NeuDiagnosticManager * ) rtDW . cqqyhb1oov ; diagnosticTree =
neu_diagnostic_manager_get_initial_tree ( diagnosticManager ) ; tmp_i =
ne_simulator_method ( ( NeslSimulator * ) rtDW . o1x35mltkr ,
NESL_SIM_PROJECTION , simulationData , diagnosticManager ) ; if ( tmp_i != 0
) { tmp = error_buffer_is_empty ( ssGetErrorStatus ( rtS ) ) ; if ( tmp ) {
msg = rtw_diagnostics_msg ( diagnosticTree ) ; ssSetErrorStatus ( rtS , msg )
; } } } void MdlZeroCrossings ( void ) { ZCV * _rtZCSV ; _rtZCSV = ( ( ZCV *
) ssGetSolverZcSignalVector ( rtS ) ) ; _rtZCSV -> ms1pj0u25v = ssGetT ( rtS
) - rtP . Ramp_start ; } void MdlTerminate ( void ) {
neu_destroy_diagnostic_manager ( ( NeuDiagnosticManager * ) rtDW . cqqyhb1oov
) ; nesl_destroy_simulation_data ( ( NeslSimulationData * ) rtDW . cj1ktnc3lk
) ; nesl_erase_simulator ( "Kinematics_Model/Solver Configuration_1" ) ;
neu_destroy_diagnostic_manager ( ( NeuDiagnosticManager * ) rtDW . bedbs44pc1
) ; nesl_destroy_simulation_data ( ( NeslSimulationData * ) rtDW . la5twx144j
) ; nesl_erase_simulator ( "Kinematics_Model/Solver Configuration_1" ) ; if (
rt_slioCatalogue ( ) != ( NULL ) ) { void * * slioCatalogueAddr =
rt_slioCatalogueAddr ( ) ; rtwSaveDatasetsToMatFile (
rtwGetPointerFromUniquePtr ( rt_slioCatalogue ( ) ) ,
rt_GetMatSigstreamLoggingFileName ( ) ) ; rtwTerminateSlioCatalogue (
slioCatalogueAddr ) ; * slioCatalogueAddr = NULL ; } } void
MdlInitializeSizes ( void ) { ssSetNumContStates ( rtS , 46 ) ;
ssSetNumPeriodicContStates ( rtS , 0 ) ; ssSetNumY ( rtS , 0 ) ; ssSetNumU (
rtS , 0 ) ; ssSetDirectFeedThrough ( rtS , 0 ) ; ssSetNumSampleTimes ( rtS ,
2 ) ; ssSetNumBlocks ( rtS , 138 ) ; ssSetNumBlockIO ( rtS , 24 ) ;
ssSetNumBlockParams ( rtS , 17 ) ; } void MdlInitializeSampleTimes ( void ) {
ssSetSampleTime ( rtS , 0 , 0.0 ) ; ssSetSampleTime ( rtS , 1 , 0.0 ) ;
ssSetOffsetTime ( rtS , 0 , 0.0 ) ; ssSetOffsetTime ( rtS , 1 , 1.0 ) ; }
void raccel_set_checksum ( ) { ssSetChecksumVal ( rtS , 0 , 3167744575U ) ;
ssSetChecksumVal ( rtS , 1 , 4044152898U ) ; ssSetChecksumVal ( rtS , 2 ,
1789352682U ) ; ssSetChecksumVal ( rtS , 3 , 1305306456U ) ; }
#if defined(_MSC_VER)
#pragma optimize( "", off )
#endif
SimStruct * raccel_register_model ( void ) { static struct _ssMdlInfo mdlInfo
; ( void ) memset ( ( char * ) rtS , 0 , sizeof ( SimStruct ) ) ; ( void )
memset ( ( char * ) & mdlInfo , 0 , sizeof ( struct _ssMdlInfo ) ) ;
ssSetMdlInfoPtr ( rtS , & mdlInfo ) ; { static time_T mdlPeriod [
NSAMPLE_TIMES ] ; static time_T mdlOffset [ NSAMPLE_TIMES ] ; static time_T
mdlTaskTimes [ NSAMPLE_TIMES ] ; static int_T mdlTsMap [ NSAMPLE_TIMES ] ;
static int_T mdlSampleHits [ NSAMPLE_TIMES ] ; static boolean_T
mdlTNextWasAdjustedPtr [ NSAMPLE_TIMES ] ; static int_T mdlPerTaskSampleHits
[ NSAMPLE_TIMES * NSAMPLE_TIMES ] ; static time_T mdlTimeOfNextSampleHit [
NSAMPLE_TIMES ] ; { int_T i ; for ( i = 0 ; i < NSAMPLE_TIMES ; i ++ ) {
mdlPeriod [ i ] = 0.0 ; mdlOffset [ i ] = 0.0 ; mdlTaskTimes [ i ] = 0.0 ;
mdlTsMap [ i ] = i ; mdlSampleHits [ i ] = 1 ; } } ssSetSampleTimePtr ( rtS ,
& mdlPeriod [ 0 ] ) ; ssSetOffsetTimePtr ( rtS , & mdlOffset [ 0 ] ) ;
ssSetSampleTimeTaskIDPtr ( rtS , & mdlTsMap [ 0 ] ) ; ssSetTPtr ( rtS , &
mdlTaskTimes [ 0 ] ) ; ssSetSampleHitPtr ( rtS , & mdlSampleHits [ 0 ] ) ;
ssSetTNextWasAdjustedPtr ( rtS , & mdlTNextWasAdjustedPtr [ 0 ] ) ;
ssSetPerTaskSampleHitsPtr ( rtS , & mdlPerTaskSampleHits [ 0 ] ) ;
ssSetTimeOfNextSampleHitPtr ( rtS , & mdlTimeOfNextSampleHit [ 0 ] ) ; }
ssSetSolverMode ( rtS , SOLVER_MODE_SINGLETASKING ) ; { ssSetBlockIO ( rtS ,
( ( void * ) & rtB ) ) ; ( void ) memset ( ( ( void * ) & rtB ) , 0 , sizeof
( B ) ) ; } ssSetDefaultParam ( rtS , ( real_T * ) & rtP ) ; { real_T * x = (
real_T * ) & rtX ; ssSetContStates ( rtS , x ) ; ( void ) memset ( ( void * )
x , 0 , sizeof ( X ) ) ; } { void * dwork = ( void * ) & rtDW ;
ssSetRootDWork ( rtS , dwork ) ; ( void ) memset ( dwork , 0 , sizeof ( DW )
) ; } { static DataTypeTransInfo dtInfo ; ( void ) memset ( ( char_T * ) &
dtInfo , 0 , sizeof ( dtInfo ) ) ; ssSetModelMappingInfo ( rtS , & dtInfo ) ;
dtInfo . numDataTypes = 23 ; dtInfo . dataTypeSizes = & rtDataTypeSizes [ 0 ]
; dtInfo . dataTypeNames = & rtDataTypeNames [ 0 ] ; dtInfo . BTransTable = &
rtBTransTable ; dtInfo . PTransTable = & rtPTransTable ; }
Kinematics_Model_InitializeDataMapInfo ( ) ; ssSetIsRapidAcceleratorActive (
rtS , true ) ; ssSetRootSS ( rtS , rtS ) ; ssSetVersion ( rtS ,
SIMSTRUCT_VERSION_LEVEL2 ) ; ssSetModelName ( rtS , "Kinematics_Model" ) ;
ssSetPath ( rtS , "Kinematics_Model" ) ; ssSetTStart ( rtS , 0.0 ) ;
ssSetTFinal ( rtS , 2.0 ) ; { static RTWLogInfo rt_DataLoggingInfo ;
rt_DataLoggingInfo . loggingInterval = NULL ; ssSetRTWLogInfo ( rtS , &
rt_DataLoggingInfo ) ; } { rtliSetLogXSignalInfo ( ssGetRTWLogInfo ( rtS ) ,
( NULL ) ) ; rtliSetLogXSignalPtrs ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ;
rtliSetLogT ( ssGetRTWLogInfo ( rtS ) , "tout" ) ; rtliSetLogX (
ssGetRTWLogInfo ( rtS ) , "" ) ; rtliSetLogXFinal ( ssGetRTWLogInfo ( rtS ) ,
"" ) ; rtliSetLogVarNameModifier ( ssGetRTWLogInfo ( rtS ) , "none" ) ;
rtliSetLogFormat ( ssGetRTWLogInfo ( rtS ) , 4 ) ; rtliSetLogMaxRows (
ssGetRTWLogInfo ( rtS ) , 0 ) ; rtliSetLogDecimation ( ssGetRTWLogInfo ( rtS
) , 1 ) ; rtliSetLogY ( ssGetRTWLogInfo ( rtS ) , "" ) ;
rtliSetLogYSignalInfo ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ;
rtliSetLogYSignalPtrs ( ssGetRTWLogInfo ( rtS ) , ( NULL ) ) ; } { static
struct _ssStatesInfo2 statesInfo2 ; ssSetStatesInfo2 ( rtS , & statesInfo2 )
; } { static ssPeriodicStatesInfo periodicStatesInfo ;
ssSetPeriodicStatesInfo ( rtS , & periodicStatesInfo ) ; } { static
ssSolverInfo slvrInfo ; static struct _ssSFcnModelMethods3 mdlMethods3 ;
static struct _ssSFcnModelMethods2 mdlMethods2 ; static boolean_T
contStatesDisabled [ 46 ] ; static real_T absTol [ 46 ] = { 1.0E-6 , 1.0E-6 ,
1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 ,
1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 ,
1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 ,
1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 ,
1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 ,
1.0E-6 , 1.0E-6 , 1.0E-6 , 1.0E-6 } ; static uint8_T absTolControl [ 46 ] = {
0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U
, 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U ,
0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U , 0U } ;
static uint8_T zcAttributes [ 1 ] = { ( ZC_EVENT_ALL_UP ) } ; static
ssNonContDerivSigInfo nonContDerivSigInfo [ 1 ] = { { 1 * sizeof ( real_T ) ,
( char * ) ( & rtB . gv3giy2db5 ) , ( NULL ) } } ; ssSetSolverRelTol ( rtS ,
0.001 ) ; ssSetStepSize ( rtS , 0.0 ) ; ssSetMinStepSize ( rtS , 0.0 ) ;
ssSetMaxNumMinSteps ( rtS , - 1 ) ; ssSetMinStepViolatedError ( rtS , 0 ) ;
ssSetMaxStepSize ( rtS , 0.04 ) ; ssSetSolverMaxOrder ( rtS , - 1 ) ;
ssSetSolverRefineFactor ( rtS , 1 ) ; ssSetOutputTimes ( rtS , ( NULL ) ) ;
ssSetNumOutputTimes ( rtS , 0 ) ; ssSetOutputTimesOnly ( rtS , 0 ) ;
ssSetOutputTimesIndex ( rtS , 0 ) ; ssSetZCCacheNeedsReset ( rtS , 0 ) ;
ssSetDerivCacheNeedsReset ( rtS , 0 ) ; ssSetNumNonContDerivSigInfos ( rtS ,
1 ) ; ssSetNonContDerivSigInfos ( rtS , nonContDerivSigInfo ) ;
ssSetSolverInfo ( rtS , & slvrInfo ) ; ssSetSolverName ( rtS , "ode23t" ) ;
ssSetVariableStepSolver ( rtS , 1 ) ; ssSetSolverConsistencyChecking ( rtS ,
0 ) ; ssSetSolverAdaptiveZcDetection ( rtS , 0 ) ;
ssSetSolverRobustResetMethod ( rtS , 0 ) ; _ssSetSolverUpdateJacobianAtReset
( rtS , true ) ; ssSetAbsTolVector ( rtS , absTol ) ;
ssSetAbsTolControlVector ( rtS , absTolControl ) ; ssSetSolverAbsTol_Obsolete
( rtS , absTol ) ; ssSetSolverAbsTolControl_Obsolete ( rtS , absTolControl )
; ssSetSolverStateProjection ( rtS , 1 ) ; ( void ) memset ( ( void * ) &
mdlMethods2 , 0 , sizeof ( mdlMethods2 ) ) ; ssSetModelMethods2 ( rtS , &
mdlMethods2 ) ; ( void ) memset ( ( void * ) & mdlMethods3 , 0 , sizeof (
mdlMethods3 ) ) ; ssSetModelMethods3 ( rtS , & mdlMethods3 ) ;
ssSetModelProjection ( rtS , MdlProjection ) ; ssSetSolverMassMatrixType (
rtS , ( ssMatrixType ) 0 ) ; ssSetSolverMassMatrixNzMax ( rtS , 0 ) ;
ssSetModelOutputs ( rtS , MdlOutputs ) ; ssSetModelLogData ( rtS ,
rt_UpdateTXYLogVars ) ; ssSetModelLogDataIfInInterval ( rtS ,
rt_UpdateTXXFYLogVars ) ; ssSetModelUpdate ( rtS , MdlUpdate ) ;
ssSetModelDerivatives ( rtS , MdlDerivatives ) ; ssSetSolverZcSignalAttrib (
rtS , zcAttributes ) ; ssSetSolverNumZcSignals ( rtS , 1 ) ;
ssSetModelZeroCrossings ( rtS , MdlZeroCrossings ) ;
ssSetSolverConsecutiveZCsStepRelTol ( rtS , 2.8421709430404007E-13 ) ;
ssSetSolverMaxConsecutiveZCs ( rtS , 1000 ) ; ssSetSolverConsecutiveZCsError
( rtS , 2 ) ; ssSetSolverMaskedZcDiagnostic ( rtS , 1 ) ;
ssSetSolverIgnoredZcDiagnostic ( rtS , 1 ) ; ssSetSolverMaxConsecutiveMinStep
( rtS , 1 ) ; ssSetSolverShapePreserveControl ( rtS , 2 ) ; ssSetTNextTid (
rtS , INT_MIN ) ; ssSetTNext ( rtS , rtMinusInf ) ; ssSetSolverNeedsReset (
rtS ) ; ssSetNumNonsampledZCs ( rtS , 1 ) ; ssSetContStateDisabled ( rtS ,
contStatesDisabled ) ; ssSetSolverMaxConsecutiveMinStep ( rtS , 1 ) ; }
ssSetChecksumVal ( rtS , 0 , 3167744575U ) ; ssSetChecksumVal ( rtS , 1 ,
4044152898U ) ; ssSetChecksumVal ( rtS , 2 , 1789352682U ) ; ssSetChecksumVal
( rtS , 3 , 1305306456U ) ; { static const sysRanDType rtAlwaysEnabled =
SUBSYS_RAN_BC_ENABLE ; static RTWExtModeInfo rt_ExtModeInfo ; static const
sysRanDType * systemRan [ 2 ] ; gblRTWExtModeInfo = & rt_ExtModeInfo ;
ssSetRTWExtModeInfo ( rtS , & rt_ExtModeInfo ) ;
rteiSetSubSystemActiveVectorAddresses ( & rt_ExtModeInfo , systemRan ) ;
systemRan [ 0 ] = & rtAlwaysEnabled ; systemRan [ 1 ] = & rtAlwaysEnabled ;
rteiSetModelMappingInfoPtr ( ssGetRTWExtModeInfo ( rtS ) , &
ssGetModelMappingInfo ( rtS ) ) ; rteiSetChecksumsPtr ( ssGetRTWExtModeInfo (
rtS ) , ssGetChecksums ( rtS ) ) ; rteiSetTPtr ( ssGetRTWExtModeInfo ( rtS )
, ssGetTPtr ( rtS ) ) ; } return rtS ; }
#if defined(_MSC_VER)
#pragma optimize( "", on )
#endif
const int_T gblParameterTuningTid = 2 ; void MdlOutputsParameterSampleTime (
int_T tid ) { UNUSED_PARAMETER ( tid ) ; }
