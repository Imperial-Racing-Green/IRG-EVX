#include "__cf_Kinematics_Model.h"
#include "pm_std.h"
#include "ne_std.h"
#include "ne_dae.h"
#include "pm_default_allocator.h"
#include "sm_ssci_NeDaePrivateData.h"
#include "sm_CTarget.h"
PmfMessageId sm_ssci_recordRunTimeError ( const char * errorId , const char *
errorMsg , NeuDiagnosticManager * mgr ) ;
#define pm_allocator_alloc(_allocator, _m, _n) ((_allocator)->mCallocFcn((_allocator), (_m), (_n)))
#define PM_ALLOCATE_ARRAY(_name, _type, _size, _allocator)\
 _name = (_type *) pm_allocator_alloc(_allocator, sizeof(_type), _size)
#define pm_size_to_int(_size)          ((int32_T) (_size))
PmIntVector * pm_create_int_vector ( size_t , PmAllocator * ) ; int_T
pm_create_int_vector_fields ( PmIntVector * , size_t , PmAllocator * ) ;
int_T pm_create_real_vector_fields ( PmRealVector * , size_t , PmAllocator *
) ; int_T pm_create_char_vector_fields ( PmCharVector * , size_t ,
PmAllocator * ) ; int_T pm_create_bool_vector_fields ( PmBoolVector * ,
size_t , PmAllocator * ) ; void pm_rv_equals_rv ( const PmRealVector * ,
const PmRealVector * ) ; void sm_ssci_setupLoggerFcn_codeGen ( const NeDae *
dae , NeLoggerBuilder * neLoggerBuilder ) ; int32_T sm_ssci_logFcn_codeGen (
const NeDae * dae , const NeSystemInput * systemInput , PmRealVector * output
) ; extern const NeAssertData Kinematics_Model_2b2b31c2_1_assertData [ ] ;
void Kinematics_Model_2b2b31c2_1_computeRuntimeParameters ( const double *
runtimeRootVariables , double * runtimeParameters ) ; void
Kinematics_Model_2b2b31c2_1_validateRuntimeParameters ( const double *
runtimeParameters , int32_T * assertSatisfactionFlags ) ; void
Kinematics_Model_2b2b31c2_1_computeAsmRuntimeDerivedValues ( const double *
runtimeParameters , double * runtimeDerivedValues ) ; void
Kinematics_Model_2b2b31c2_1_computeSimRuntimeDerivedValues ( const double *
runtimeParameters , double * runtimeDerivedValues ) ; PmfMessageId
Kinematics_Model_2b2b31c2_1_deriv ( const double * , const int * , const
double * , const double * , const double * , const double * , const double *
, double * , double * , NeuDiagnosticManager * neDiagMgr ) ; PmfMessageId
Kinematics_Model_2b2b31c2_1_checkDynamics ( const double * , const double * ,
const double * , const double * , const double * , const double * , double *
, NeuDiagnosticManager * neDiagMgr ) ; PmfMessageId
Kinematics_Model_2b2b31c2_1_outputDyn ( const double * , const int * , const
double * , const double * , const double * , const double * , const double *
, double * , double * , int * , double * , NeuDiagnosticManager * neDiagMgr )
; PmfMessageId Kinematics_Model_2b2b31c2_1_outputKin ( const double * , const
double * , const double * , const double * , const double * , const double *
, double * , NeuDiagnosticManager * neDiagMgr ) ; PmfMessageId
Kinematics_Model_2b2b31c2_1_output ( const double * , const double * , const
double * , const double * , const double * , const double * , double * ,
NeuDiagnosticManager * neDiagMgr ) ; void
Kinematics_Model_2b2b31c2_1_checkTargets ( const double *
runtimeDerivedValues , const double * stateVector ) ; void
Kinematics_Model_2b2b31c2_1_setTargets ( const double * runtimeDerivedValues
, CTarget * targets ) ; void Kinematics_Model_2b2b31c2_1_resetStateVector (
const void * mech , double * stateVector ) ; void
Kinematics_Model_2b2b31c2_1_initializeTrackedAngleState ( const void * mech ,
const double * runtimeDerivedValues , const double * motionData , double *
stateVector , void * neDiagMgr ) ; void
Kinematics_Model_2b2b31c2_1_computeDiscreteState ( const void * mech , const
double * runtimeDerivedValues , double * stateVector ) ; void
Kinematics_Model_2b2b31c2_1_adjustPosition ( const void * mech , const double
* dofDeltas , double * stateVector ) ; void
Kinematics_Model_2b2b31c2_1_perturbJointPrimitiveState ( const void * mech ,
size_t stageIdx , size_t primitiveIdx , double magnitude , boolean_T
doPerturbVelocity , double * stateVector ) ; void
Kinematics_Model_2b2b31c2_1_perturbFlexibleBodyState ( const void * mech ,
size_t stageIdx , double magnitude , boolean_T doPerturbVelocity , double *
stateVector ) ; void Kinematics_Model_2b2b31c2_1_computeDofBlendMatrix (
const void * mech , size_t stageIdx , size_t primitiveIdx , const double *
stateVector , int partialType , double * matrix ) ; void
Kinematics_Model_2b2b31c2_1_projectPartiallyTargetedPos ( const void * mech ,
size_t stageIdx , size_t primitiveIdx , const double * origStateVector , int
partialType , double * stateVector ) ; void
Kinematics_Model_2b2b31c2_1_propagateMotion ( const void * mech , const
double * runtimeDerivedValues , const double * stateVector , double *
motionData ) ; size_t Kinematics_Model_2b2b31c2_1_computeAssemblyError (
const void * mech , const double * runtimeDerivedValues , size_t
constraintIdx , const double * stateVector , const double * motionData ,
double * error ) ; size_t Kinematics_Model_2b2b31c2_1_computeAssemblyJacobian
( const void * mech , const double * runtimeDerivedValues , size_t
constraintIdx , boolean_T forVelocitySatisfaction , const double *
stateVector , const double * motionData , double * J ) ; size_t
Kinematics_Model_2b2b31c2_1_computeFullAssemblyJacobian ( const void * mech ,
const double * runtimeDerivedValues , const double * stateVector , const
double * motionData , double * J ) ; int
Kinematics_Model_2b2b31c2_1_isInKinematicSingularity ( const void * mech ,
const double * runtimeDerivedValues , size_t constraintIdx , const double *
motionData ) ; PmfMessageId Kinematics_Model_2b2b31c2_1_convertStateVector (
const void * asmMech , const double * asmRuntimeDerivedValues , const void *
simMech , const double * asmStateVector , double * simStateVector , void *
neDiagMgr ) ; void Kinematics_Model_2b2b31c2_1_constructStateVector ( const
void * mech , const double * solverStateVector , const double * u , const
double * uDot , const double * discreteStateVector , double * fullStateVector
) ; void Kinematics_Model_2b2b31c2_1_extractSolverStateVector ( const void *
mech , const double * fullStateVector , double * solverStateVector ) ; int
Kinematics_Model_2b2b31c2_1_isPositionViolation ( const void * mech , const
double * runtimeDerivedValues , const int * constraintEqnEnableFlags , const
double * stateVector ) ; int Kinematics_Model_2b2b31c2_1_isVelocityViolation
( const void * mech , const double * runtimeDerivedValues , const int *
constraintEqnEnableFlags , const double * stateVector ) ; PmfMessageId
Kinematics_Model_2b2b31c2_1_projectStateSim ( const void * mech , const
double * runtimeDerivedValues , const int * constraintEqnEnableFlags , const
double * inputVector , double * stateVector , void * neDiagMgr ) ; void
Kinematics_Model_2b2b31c2_1_computeConstraintError ( const void * mech ,
const double * runtimeDerivedValues , const double * stateVector , double *
error ) ; PmfMessageId Kinematics_Model_2b2b31c2_1_assemble ( const double *
u , double * udot , double * x , NeuDiagnosticManager * neDiagMgr ) { ( void
) x ; ( void ) u ; ( void ) udot ; ( void ) neDiagMgr ; return NULL ; }
static void dae_cg_setParameters_function ( const NeDae * dae , const
NeParameterBundle * paramBundle ) { const NeDaePrivateData * smData = dae ->
mPrivateData ; const double * runtimeRootVariables = paramBundle ->
mRealParameters . mX ; if ( smData -> mRuntimeParameterScalars . mN == 0 )
return ; Kinematics_Model_2b2b31c2_1_computeRuntimeParameters (
runtimeRootVariables , smData -> mRuntimeParameterScalars . mX ) ;
Kinematics_Model_2b2b31c2_1_computeAsmRuntimeDerivedValues ( smData ->
mRuntimeParameterScalars . mX , smData -> mAsmRuntimeDerivedValueScalars . mX
) ; Kinematics_Model_2b2b31c2_1_computeSimRuntimeDerivedValues ( smData ->
mRuntimeParameterScalars . mX , smData -> mSimRuntimeDerivedValueScalars . mX
) ; sm_core_computeRedundantConstraintEquations ( & dae -> mPrivateData ->
mSimulationDelegate , smData -> mSimRuntimeDerivedValueScalars . mX ) ;
#if 0
{ size_t i ; const size_t n = smData -> mSimulationDelegate .
mRunTimeEnabledEquations . mSize ; pmf_printf (
"\nRuntime Enabled Equations (%lu)\n" , n ) ; for ( i = 0 ; i < n ; ++ i )
pmf_printf ( "  %2lu:  %d\n" , i , smData -> mSimulationDelegate .
mRunTimeEnabledEquations . mValues [ i ] ) ; }
#endif
} static PmfMessageId dae_cg_pAssert_method ( const NeDae * dae , const
NeSystemInput * systemInput , NeDaeMethodOutput * daeMethodOutput ,
NeuDiagnosticManager * neDiagMgr ) { const NeDaePrivateData * smData = dae ->
mPrivateData ; const double * runtimeParams = smData ->
mRuntimeParameterScalars . mX ; int32_T * assertSatisfactionFlags =
daeMethodOutput -> mPASSERT . mX ; ( void ) systemInput ; ( void ) neDiagMgr
; Kinematics_Model_2b2b31c2_1_validateRuntimeParameters ( runtimeParams ,
assertSatisfactionFlags ) ; return NULL ; } static PmfMessageId
dae_cg_deriv_method ( const NeDae * dae , const NeSystemInput * systemInput ,
NeDaeMethodOutput * daeMethodOutput , NeuDiagnosticManager * neDiagMgr ) {
const NeDaePrivateData * smData = dae -> mPrivateData ; PmfMessageId errorId
= NULL ; double errorResult = 0.0 ; if ( smData ->
mCachedDerivativesAvailable ) memcpy ( daeMethodOutput -> mXP0 . mX , smData
-> mCachedDerivatives . mX , 46 * sizeof ( real_T ) ) ; else errorId =
Kinematics_Model_2b2b31c2_1_deriv ( smData -> mSimRuntimeDerivedValueScalars
. mX , smData -> mSimulationDelegate . mRunTimeEnabledEquations . mValues ,
systemInput -> mX . mX , systemInput -> mU . mX , systemInput -> mU . mX + 1
, systemInput -> mV . mX + 1 , systemInput -> mD . mX , daeMethodOutput ->
mXP0 . mX , & errorResult , neDiagMgr ) ; return errorId ; } static
PmfMessageId dae_cg_output_method ( const NeDae * dae , const NeSystemInput *
systemInput , NeDaeMethodOutput * daeMethodOutput , NeuDiagnosticManager *
neDiagMgr ) { PmfMessageId errorId = NULL ; NeDaePrivateData * smData = dae
-> mPrivateData ; errorId = Kinematics_Model_2b2b31c2_1_output ( smData ->
mSimRuntimeDerivedValueScalars . mX , systemInput -> mX . mX , systemInput ->
mU . mX , systemInput -> mU . mX + 1 , systemInput -> mV . mX + 1 ,
systemInput -> mD . mX , daeMethodOutput -> mY . mX , neDiagMgr ) ; return
errorId ; } static PmfMessageId dae_cg_project_solve ( const NeDae * dae ,
const NeSystemInput * systemInput , NeuDiagnosticManager * neDiagMgr ) {
NeDaePrivateData * smData = dae -> mPrivateData ; return sm_core_projectState
( false , & smData -> mSimulationDelegate , smData ->
mSimRuntimeDerivedValueScalars . mX , systemInput -> mU . mX , systemInput ->
mU . mX + 1 , systemInput -> mD . mX , systemInput -> mX . mX , neDiagMgr ) ;
} static PmfMessageId dae_cg_check_solve ( const NeDae * dae , const
NeSystemInput * systemInput , NeuDiagnosticManager * neDiagMgr ) {
NeDaePrivateData * smData = dae -> mPrivateData ; PmfMessageId errorId = NULL
; if ( smData -> mNumConstraintEqns > 0 ) errorId = sm_core_projectState (
false , & smData -> mSimulationDelegate , smData ->
mSimRuntimeDerivedValueScalars . mX , systemInput -> mU . mX , systemInput ->
mU . mX + 1 , systemInput -> mD . mX , systemInput -> mX . mX , neDiagMgr ) ;
if ( errorId == NULL && smData -> mDoCheckDynamics ) { double result = 0.0 ;
errorId = Kinematics_Model_2b2b31c2_1_checkDynamics ( smData ->
mSimRuntimeDerivedValueScalars . mX , systemInput -> mX . mX , systemInput ->
mU . mX , systemInput -> mU . mX + 1 , systemInput -> mV . mX + 1 ,
systemInput -> mD . mX , & result , neDiagMgr ) ; } return errorId ; } static
PmfMessageId dae_cg_projectMaybe_solve ( const NeDae * dae , const
NeSystemInput * systemInput , NeuDiagnosticManager * neDiagMgr ) {
NeDaePrivateData * smData = dae -> mPrivateData ; return sm_core_projectState
( true , & smData -> mSimulationDelegate , smData ->
mSimRuntimeDerivedValueScalars . mX , systemInput -> mU . mX , systemInput ->
mU . mX + 1 , systemInput -> mD . mX , systemInput -> mX . mX , neDiagMgr ) ;
} static PmfMessageId dae_cg_assemble_solve ( const NeDae * dae , const
NeSystemInput * systemInput , NeuDiagnosticManager * neDiagMgr ) {
NeDaePrivateData * smData = dae -> mPrivateData ; const SmMechanismDelegate *
delegate = & smData -> mAssemblyDelegate ; const double *
runtimeDerivedValues = smData -> mAsmRuntimeDerivedValueScalars . mX ;
PmfMessageId errorId = NULL ; size_t i ; const size_t numTargets = 30 ;
unsigned int asmStatus = 0 ; double * assemblyFullStateVector = smData ->
mAssemblyFullStateVector . mX ; double * simulationFullStateVector = smData
-> mSimulationFullStateVector . mX ; ( * delegate -> mSetTargets ) (
runtimeDerivedValues , smData -> mTargets ) ; { const double * u =
systemInput -> mU . mX ; const double * uDot = u + smData -> mInputVectorSize
; CTarget * target = smData -> mTargets + smData -> mNumInternalTargets ; for
( i = 0 ; i < smData -> mNumInputMotionPrimitives ; ++ i ) { const size_t
inputOffset = smData -> mMotionInputOffsets . mX [ i ] ; ( target ++ ) ->
mValue [ 0 ] = u [ inputOffset ] ; ( target ++ ) -> mValue [ 0 ] = uDot [
inputOffset ] ; } } errorId = sm_core_computeStateVector ( delegate ,
runtimeDerivedValues , numTargets , smData -> mTargets ,
assemblyFullStateVector , neDiagMgr ) ; if ( errorId != NULL ) return errorId
; asmStatus = sm_core_checkAssembly ( delegate , runtimeDerivedValues ,
numTargets , smData -> mTargets , assemblyFullStateVector , NULL , NULL ,
NULL ) ; if ( asmStatus != 1 ) { return sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:AssemblyFailure" , asmStatus == 2 ?
 "Model not assembled due to a position violation. The failure occurred during the attempt to assemble all joints in the system and satisfy any motion inputs. If an Update Diagram operation completes successfully, the failure is likely caused by motion inputs. Consider adjusting the motion inputs to specify a different starting configuration. Also consider adjusting or adding joint targets to better guide the assembly."
: ( asmStatus == 3 ?
 "Model not assembled due to a velocity violation. The failure occurred during the attempt to assemble all joints in the system and satisfy any motion inputs. If an Update Diagram operation completes successfully, the failure is likely caused by motion inputs. Consider adjusting the motion inputs to specify a different starting configuration. Also consider adjusting or adding joint targets to better guide the assembly."
:
 "Model not assembled due to a singularity violation. The failure occurred during the attempt to assemble all joints in the system and satisfy any motion inputs. If an Update Diagram operation completes successfully, the failure is likely caused by motion inputs. Consider adjusting the motion inputs to specify a different starting configuration. Also consider adjusting or adding joint targets to better guide the assembly."
) , neDiagMgr ) ; }
#if 0
Kinematics_Model_2b2b31c2_1_checkTargets ( smData ->
mSimRuntimeDerivedValueScalars . mX , assemblyFullStateVector ) ;
#endif
errorId = ( * delegate -> mConvertStateVector ) ( NULL , runtimeDerivedValues
, NULL , assemblyFullStateVector , simulationFullStateVector , neDiagMgr ) ;
for ( i = 0 ; i < smData -> mStateVectorSize ; ++ i ) systemInput -> mX . mX
[ i ] = simulationFullStateVector [ smData -> mStateVectorMap . mX [ i ] ] ;
memcpy ( systemInput -> mD . mX , simulationFullStateVector + smData ->
mFullStateVectorSize - smData -> mDiscreteStateSize , smData ->
mDiscreteStateSize * sizeof ( double ) ) ; return errorId ; } typedef struct
{ size_t first ; size_t second ; } SizePair ; static void checkMemAllocStatus
( int_T status ) { ( void ) status ; } static PmCharVector
cStringToCharVector ( const char * src ) { const size_t n = strlen ( src ) ;
PmCharVector charVect ; const int_T status = pm_create_char_vector_fields ( &
charVect , n + 1 , pm_default_allocator ( ) ) ; checkMemAllocStatus ( status
) ; strcpy ( charVect . mX , src ) ; return charVect ; } static void
initBasicAttributes ( NeDaePrivateData * smData ) { size_t i ; smData ->
mStateVectorSize = 46 ; smData -> mFullStateVectorSize = 48 ; smData ->
mDiscreteStateSize = 0 ; smData -> mInputVectorSize = 1 ; smData ->
mOutputVectorSize = 19 ; smData -> mNumConstraintEqns = 15 ; smData ->
mDoCheckDynamics = false ; for ( i = 0 ; i < 4 ; ++ i ) smData -> mChecksum [
i ] = 0 ; } static void initStateVector ( NeDaePrivateData * smData ) {
PmAllocator * alloc = pm_default_allocator ( ) ; const int32_T stateVectorMap
[ 46 ] = { 0 , 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 11 , 12 , 13 , 14 ,
15 , 16 , 17 , 18 , 19 , 20 , 21 , 22 , 23 , 24 , 25 , 26 , 27 , 28 , 29 , 30
, 31 , 32 , 33 , 34 , 35 , 36 , 38 , 39 , 41 , 42 , 43 , 44 , 45 , 46 , 47 }
; const CTarget targets [ 30 ] = { { 1 , 35 , 0 , false , 0 , 0 , "1" , false
, false , + 1.000000000000000000e+00 , true , 4 , { +
1.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 2 , 35 , 0 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 3 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 0 , 37 , 0
, false , 0 , 0 , "1" , false , false , + 1.000000000000000000e+00 , true , 1
, { + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 0 , 37 , 0 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 1 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 0 , 37 , 1
, false , 0 , 0 , "1" , false , false , + 1.000000000000000000e+00 , true , 1
, { + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 0 , 37 , 1 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 1 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 0 , 37 , 2
, false , 0 , 0 , "1" , false , false , + 1.000000000000000000e+00 , true , 1
, { + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 0 , 37 , 2 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 1 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 1 , 72 , 0
, false , 0 , 0 , "1" , false , false , + 1.000000000000000000e+00 , true , 4
, { + 1.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 2 , 72 , 0 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 3 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 1 , 79 , 0
, false , 0 , 1 , "deg" , false , false , + 1.000000000000000000e+00 , true ,
4 , { + 1.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 2 , 79 , 0 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 3 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 1 , 80 , 0
, false , 0 , 2 , "deg" , false , false , + 1.000000000000000000e+00 , true ,
4 , { + 1.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 2 , 80 , 0 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 3 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 1 , 81 , 0
, false , 0 , 0 , "1" , false , false , + 1.000000000000000000e+00 , true , 4
, { + 1.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 2 , 81 , 0 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 3 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 1 , 109 , 0
, false , 0 , 2 , "deg" , false , false , + 1.000000000000000000e+00 , true ,
4 , { + 7.071067811865475727e-01 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 7.071067811865475727e-01 } , { +
0.000000000000000000e+00 } } , { 2 , 109 , 0 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 3 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 1 , 110 , 0
, false , 0 , 0 , "1" , false , false , + 1.000000000000000000e+00 , true , 4
, { + 1.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 2 , 110 , 0 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 3 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 1 , 121 , 0
, false , 0 , 0 , "1" , false , false , + 1.000000000000000000e+00 , true , 4
, { + 1.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 2 , 121 , 0 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 3 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 1 , 128 , 0
, false , 0 , 0 , "1" , false , false , + 1.000000000000000000e+00 , true , 4
, { + 1.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 2 , 128 , 0 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 3 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 1 , 129 , 0
, false , 0 , 0 , "1" , false , false , + 1.000000000000000000e+00 , true , 4
, { + 1.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 2 , 129 , 0 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 3 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 1 , 130 , 0
, false , 0 , 0 , "1" , false , false , + 1.000000000000000000e+00 , true , 4
, { + 1.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 2 , 130 , 0 , false , 0 , 0 , "1" , true ,
false , + 1.000000000000000000e+00 , true , 3 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } , { 0 , 37 , 2
, false , 0 , 3 , "" , false , false , + 1.000000000000000000e+00 , true , 1
, { + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 , + 0.000000000000000000e+00 } , { +
0.000000000000000000e+00 } } , { 0 , 37 , 2 , false , 0 , 3 , "" , true ,
false , + 1.000000000000000000e+00 , true , 1 , { + 0.000000000000000000e+00
, + 0.000000000000000000e+00 , + 0.000000000000000000e+00 , +
0.000000000000000000e+00 } , { + 0.000000000000000000e+00 } } } ; const
size_t numTargets = 30 ; int_T status ; size_t i ; status =
pm_create_real_vector_fields ( & smData -> mAssemblyFullStateVector , 48 ,
alloc ) ; checkMemAllocStatus ( status ) ; status =
pm_create_real_vector_fields ( & smData -> mSimulationFullStateVector , 48 ,
alloc ) ; checkMemAllocStatus ( status ) ; status =
pm_create_int_vector_fields ( & smData -> mStateVectorMap , smData ->
mStateVectorSize , alloc ) ; checkMemAllocStatus ( status ) ; memcpy ( smData
-> mStateVectorMap . mX , stateVectorMap , smData -> mStateVectorSize *
sizeof ( int32_T ) ) ; smData -> mNumInternalTargets = 28 ; smData ->
mNumInputMotionPrimitives = 1 ; PM_ALLOCATE_ARRAY ( smData -> mTargets ,
CTarget , numTargets , alloc ) ; for ( i = 0 ; i < numTargets ; ++ i )
sm_compiler_CTarget_copy ( targets + i , smData -> mTargets + i ) ; } static
void initAsserts ( NeDaePrivateData * smData ) { PmAllocator * alloc =
pm_default_allocator ( ) ; int_T status = 0 ; smData -> mNumParamAsserts = 0
; smData -> mParamAssertObjects = NULL ; smData -> mParamAssertPaths = NULL ;
smData -> mParamAssertDescriptors = NULL ; smData -> mParamAssertMessages =
NULL ; smData -> mParamAssertMessageIds = NULL ; status =
pm_create_bool_vector_fields ( & smData -> mParamAssertIsWarnings , smData ->
mNumParamAsserts , alloc ) ; checkMemAllocStatus ( status ) ; if ( smData ->
mNumParamAsserts > 0 ) { const NeAssertData * ad =
Kinematics_Model_2b2b31c2_1_assertData ; size_t i ; PM_ALLOCATE_ARRAY (
smData -> mParamAssertObjects , PmCharVector , 0 , alloc ) ;
PM_ALLOCATE_ARRAY ( smData -> mParamAssertPaths , PmCharVector , 0 , alloc )
; PM_ALLOCATE_ARRAY ( smData -> mParamAssertDescriptors , PmCharVector , 0 ,
alloc ) ; PM_ALLOCATE_ARRAY ( smData -> mParamAssertMessages , PmCharVector ,
0 , alloc ) ; PM_ALLOCATE_ARRAY ( smData -> mParamAssertMessageIds ,
PmCharVector , 0 , alloc ) ; for ( i = 0 ; i < smData -> mNumParamAsserts ;
++ i , ++ ad ) { smData -> mParamAssertObjects [ i ] = cStringToCharVector (
ad -> mObject ) ; smData -> mParamAssertPaths [ i ] = cStringToCharVector (
ad -> mPath ) ; smData -> mParamAssertDescriptors [ i ] = cStringToCharVector
( ad -> mDescriptor ) ; smData -> mParamAssertMessages [ i ] =
cStringToCharVector ( ad -> mMessage ) ; smData -> mParamAssertMessageIds [ i
] = cStringToCharVector ( ad -> mMessageID ) ; smData ->
mParamAssertIsWarnings . mX [ i ] = ad -> mIsWarn ; } } } static void
initVariables ( NeDaePrivateData * smData ) { const char * varFullPaths [ 46
] = { "LWB_Front_Joint.S.Q" , "LWB_Front_Joint.S.Q" , "LWB_Front_Joint.S.Q" ,
"LWB_Front_Joint.S.Q" , "LWB_Front_Joint.S.w" , "LWB_Front_Joint.S.w" ,
"LWB_Front_Joint.S.w" , "LWB_Rear_Joint.S.Q" , "LWB_Rear_Joint.S.Q" ,
"LWB_Rear_Joint.S.Q" , "LWB_Rear_Joint.S.Q" , "LWB_Rear_Joint.S.w" ,
"LWB_Rear_Joint.S.w" , "LWB_Rear_Joint.S.w" , "Trackrod_Inner_Joint.S.Q" ,
"Trackrod_Inner_Joint.S.Q" , "Trackrod_Inner_Joint.S.Q" ,
"Trackrod_Inner_Joint.S.Q" , "Trackrod_Inner_Joint.S.w" ,
"Trackrod_Inner_Joint.S.w" , "Trackrod_Inner_Joint.S.w" ,
"UWB_Front_Joint.S.Q" , "UWB_Front_Joint.S.Q" , "UWB_Front_Joint.S.Q" ,
"UWB_Front_Joint.S.Q" , "UWB_Front_Joint.S.w" , "UWB_Front_Joint.S.w" ,
"UWB_Front_Joint.S.w" , "UWB_Rear_Joint1.S.Q" , "UWB_Rear_Joint1.S.Q" ,
"UWB_Rear_Joint1.S.Q" , "UWB_Rear_Joint1.S.Q" , "UWB_Rear_Joint1.S.w" ,
"UWB_Rear_Joint1.S.w" , "UWB_Rear_Joint1.S.w" ,
"Actuation_and_Logging.Vertical_Actuation.Px.p" ,
"Actuation_and_Logging.Vertical_Actuation.Py.p" ,
"Actuation_and_Logging.Vertical_Actuation.Px.v" ,
"Actuation_and_Logging.Vertical_Actuation.Py.v" ,
"Actuation_and_Logging.Tyre_Rotation.S.Q" ,
"Actuation_and_Logging.Tyre_Rotation.S.Q" ,
"Actuation_and_Logging.Tyre_Rotation.S.Q" ,
"Actuation_and_Logging.Tyre_Rotation.S.Q" ,
"Actuation_and_Logging.Tyre_Rotation.S.w" ,
"Actuation_and_Logging.Tyre_Rotation.S.w" ,
"Actuation_and_Logging.Tyre_Rotation.S.w" } ; const char * varObjects [ 46 ]
= { "Kinematics_Model/LWB Front Joint" , "Kinematics_Model/LWB Front Joint" ,
"Kinematics_Model/LWB Front Joint" , "Kinematics_Model/LWB Front Joint" ,
"Kinematics_Model/LWB Front Joint" , "Kinematics_Model/LWB Front Joint" ,
"Kinematics_Model/LWB Front Joint" , "Kinematics_Model/LWB Rear Joint" ,
"Kinematics_Model/LWB Rear Joint" , "Kinematics_Model/LWB Rear Joint" ,
"Kinematics_Model/LWB Rear Joint" , "Kinematics_Model/LWB Rear Joint" ,
"Kinematics_Model/LWB Rear Joint" , "Kinematics_Model/LWB Rear Joint" ,
"Kinematics_Model/Trackrod  Inner Joint" ,
"Kinematics_Model/Trackrod  Inner Joint" ,
"Kinematics_Model/Trackrod  Inner Joint" ,
"Kinematics_Model/Trackrod  Inner Joint" ,
"Kinematics_Model/Trackrod  Inner Joint" ,
"Kinematics_Model/Trackrod  Inner Joint" ,
"Kinematics_Model/Trackrod  Inner Joint" , "Kinematics_Model/UWB Front Joint"
, "Kinematics_Model/UWB Front Joint" , "Kinematics_Model/UWB Front Joint" ,
"Kinematics_Model/UWB Front Joint" , "Kinematics_Model/UWB Front Joint" ,
"Kinematics_Model/UWB Front Joint" , "Kinematics_Model/UWB Front Joint" ,
"Kinematics_Model/UWB Rear Joint1" , "Kinematics_Model/UWB Rear Joint1" ,
"Kinematics_Model/UWB Rear Joint1" , "Kinematics_Model/UWB Rear Joint1" ,
"Kinematics_Model/UWB Rear Joint1" , "Kinematics_Model/UWB Rear Joint1" ,
"Kinematics_Model/UWB Rear Joint1" ,
"Kinematics_Model/Actuation and Logging/Vertical Actuation" ,
"Kinematics_Model/Actuation and Logging/Vertical Actuation" ,
"Kinematics_Model/Actuation and Logging/Vertical Actuation" ,
"Kinematics_Model/Actuation and Logging/Vertical Actuation" ,
"Kinematics_Model/Actuation and Logging/Tyre Rotation" ,
"Kinematics_Model/Actuation and Logging/Tyre Rotation" ,
"Kinematics_Model/Actuation and Logging/Tyre Rotation" ,
"Kinematics_Model/Actuation and Logging/Tyre Rotation" ,
"Kinematics_Model/Actuation and Logging/Tyre Rotation" ,
"Kinematics_Model/Actuation and Logging/Tyre Rotation" ,
"Kinematics_Model/Actuation and Logging/Tyre Rotation" } ; smData ->
mNumVarScalars = 46 ; smData -> mVarFullPaths = NULL ; smData -> mVarObjects
= NULL ; if ( smData -> mNumVarScalars > 0 ) { size_t s ; PmAllocator * alloc
= pm_default_allocator ( ) ; PM_ALLOCATE_ARRAY ( smData -> mVarFullPaths ,
PmCharVector , 46 , alloc ) ; PM_ALLOCATE_ARRAY ( smData -> mVarObjects ,
PmCharVector , 46 , alloc ) ; for ( s = 0 ; s < smData -> mNumVarScalars ; ++
s ) { smData -> mVarFullPaths [ s ] = cStringToCharVector ( varFullPaths [ s
] ) ; smData -> mVarObjects [ s ] = cStringToCharVector ( varObjects [ s ] )
; } } } static void initRuntimeParameters ( NeDaePrivateData * smData ) {
PmAllocator * alloc = pm_default_allocator ( ) ; int_T status = 0 ; size_t i
= 0 ; const int32_T * rtpRootVarRows = NULL ; const int32_T * rtpRootVarCols
= NULL ; const char * * rtpFullPaths = NULL ; smData -> mNumRtpRootVars = 0 ;
status = pm_create_int_vector_fields ( & smData -> mRtpRootVarRows , smData
-> mNumRtpRootVars , alloc ) ; checkMemAllocStatus ( status ) ; memcpy (
smData -> mRtpRootVarRows . mX , rtpRootVarRows , smData -> mNumRtpRootVars *
sizeof ( int32_T ) ) ; status = pm_create_int_vector_fields ( & smData ->
mRtpRootVarCols , smData -> mNumRtpRootVars , alloc ) ; checkMemAllocStatus (
status ) ; memcpy ( smData -> mRtpRootVarCols . mX , rtpRootVarCols , smData
-> mNumRtpRootVars * sizeof ( int32_T ) ) ; smData -> mRtpFullPaths = NULL ;
if ( smData -> mNumRtpRootVars > 0 ) { size_t v ; PM_ALLOCATE_ARRAY ( smData
-> mRtpFullPaths , PmCharVector , 0 , alloc ) ; for ( v = 0 ; v < smData ->
mNumRtpRootVars ; ++ v ) { smData -> mRtpFullPaths [ v ] =
cStringToCharVector ( rtpFullPaths [ v ] ) ; } } smData ->
mNumRuntimeRootVarScalars = 0 ; status = pm_create_real_vector_fields ( &
smData -> mRuntimeParameterScalars , 0 , alloc ) ; checkMemAllocStatus (
status ) ; for ( i = 0 ; i < smData -> mRuntimeParameterScalars . mN ; ++ i )
smData -> mRuntimeParameterScalars . mX [ i ] = 0.0 ; status =
pm_create_real_vector_fields ( & smData -> mAsmRuntimeDerivedValueScalars , 0
, alloc ) ; checkMemAllocStatus ( status ) ; for ( i = 0 ; i < smData ->
mAsmRuntimeDerivedValueScalars . mN ; ++ i ) smData ->
mAsmRuntimeDerivedValueScalars . mX [ i ] = 0.0 ; status =
pm_create_real_vector_fields ( & smData -> mSimRuntimeDerivedValueScalars , 0
, alloc ) ; checkMemAllocStatus ( status ) ; for ( i = 0 ; i < smData ->
mSimRuntimeDerivedValueScalars . mN ; ++ i ) smData ->
mSimRuntimeDerivedValueScalars . mX [ i ] = 0.0 ; } static void
initIoInfoHelper ( size_t n , const char * portPathsSource [ ] , const char *
unitsSource [ ] , const SizePair dimensions [ ] , boolean_T doInputs ,
NeDaePrivateData * smData ) { PmCharVector * portPaths = NULL ; PmCharVector
* units = NULL ; NeDsIoInfo * infos = NULL ; if ( n > 0 ) { size_t s ;
PmAllocator * alloc = pm_default_allocator ( ) ; PM_ALLOCATE_ARRAY (
portPaths , PmCharVector , n , alloc ) ; PM_ALLOCATE_ARRAY ( units ,
PmCharVector , n , alloc ) ; PM_ALLOCATE_ARRAY ( infos , NeDsIoInfo , n ,
alloc ) ; for ( s = 0 ; s < n ; ++ s ) { portPaths [ s ] =
cStringToCharVector ( portPathsSource [ s ] ) ; units [ s ] =
cStringToCharVector ( unitsSource [ s ] ) ; { NeDsIoInfo * info = infos + s ;
info -> mName = info -> mIdentifier = portPaths [ s ] . mX ; info -> mM =
dimensions [ s ] . first ; info -> mN = dimensions [ s ] . second ; info ->
mUnit = units [ s ] . mX ; } } } if ( doInputs ) { smData -> mNumInputs = n ;
smData -> mInputPortPaths = portPaths ; smData -> mInputUnits = units ;
smData -> mInputInfos = infos ; } else { smData -> mNumOutputs = n ; smData
-> mOutputPortPaths = portPaths ; smData -> mOutputUnits = units ; smData ->
mOutputInfos = infos ; } } static void initIoInfo ( NeDaePrivateData * smData
) { const char * inputPortPaths [ 1 ] = {
"Actuation_and_Logging.Vertical_Actuation.pzi" } ; const char * inputUnits [
1 ] = { "m" } ; const SizePair inputDimensions [ 1 ] = { { 1 , 1 } } ; const
char * outputPortPaths [ 14 ] = { "Actuation_and_Logging.Tyre_Rotation.Q" ,
"Actuation_and_Logging.Contact_Patch_Sensor.axs" ,
"Actuation_and_Logging.Contact_Patch_Sensor.x" ,
"Actuation_and_Logging.Contact_Patch_Sensor.y" ,
"Actuation_and_Logging.Contact_Patch_Sensor.z" ,
"Actuation_and_Logging.LWB_Sensor.x" , "Actuation_and_Logging.LWB_Sensor.y" ,
"Actuation_and_Logging.LWB_Sensor.z" ,
"Actuation_and_Logging.Trackrod_Sensor.x" ,
"Actuation_and_Logging.Trackrod_Sensor.y" ,
"Actuation_and_Logging.Trackrod_Sensor.z" ,
"Actuation_and_Logging.UWB_Sensor.x" , "Actuation_and_Logging.UWB_Sensor.y" ,
"Actuation_and_Logging.UWB_Sensor.z" } ; const char * outputUnits [ 14 ] = {
"1" , "1" , "m" , "m" , "m" , "m" , "m" , "m" , "m" , "m" , "m" , "m" , "m" ,
"m" } ; const SizePair outputDimensions [ 14 ] = { { 4 , 1 } , { 3 , 1 } , {
1 , 1 } , { 1 , 1 } , { 1 , 1 } , { 1 , 1 } , { 1 , 1 } , { 1 , 1 } , { 1 , 1
} , { 1 , 1 } , { 1 , 1 } , { 1 , 1 } , { 1 , 1 } , { 1 , 1 } } ;
initIoInfoHelper ( 1 , inputPortPaths , inputUnits , inputDimensions , true ,
smData ) ; initIoInfoHelper ( 14 , outputPortPaths , outputUnits ,
outputDimensions , false , smData ) ; } static void initInputDerivs (
NeDaePrivateData * smData ) { const int32_T numInputDerivs [ 1 ] = { 2 } ;
PmAllocator * alloc = pm_default_allocator ( ) ; const int_T status =
pm_create_int_vector_fields ( & smData -> mNumInputDerivs , smData ->
mInputVectorSize , alloc ) ; checkMemAllocStatus ( status ) ; memcpy ( smData
-> mNumInputDerivs . mX , numInputDerivs , 1 * sizeof ( int32_T ) ) ; smData
-> mInputOrder = 2 ; } static void initDirectFeedthrough ( NeDaePrivateData *
smData ) { const boolean_T directFeedthroughVector [ 1 ] = { true } ; const
boolean_T directFeedthroughMatrix [ 38 ] = { true , true , true , true , true
, true , true , true , true , true , true , true , true , true , true , true
, true , true , true , true , true , true , true , true , true , true , true
, true , true , true , true , true , true , true , true , true , true , true
} ; PmAllocator * alloc = pm_default_allocator ( ) ; { const int_T status =
pm_create_bool_vector_fields ( & smData -> mDirectFeedthroughVector , 1 ,
alloc ) ; checkMemAllocStatus ( status ) ; memcpy ( smData ->
mDirectFeedthroughVector . mX , directFeedthroughVector , 1 * sizeof (
boolean_T ) ) ; } { const int_T status = pm_create_bool_vector_fields ( &
smData -> mDirectFeedthroughMatrix , 38 , alloc ) ; checkMemAllocStatus (
status ) ; memcpy ( smData -> mDirectFeedthroughMatrix . mX ,
directFeedthroughMatrix , 38 * sizeof ( boolean_T ) ) ; } } static void
initOutputDerivProc ( NeDaePrivateData * smData ) { PmAllocator * alloc =
pm_default_allocator ( ) ; const int32_T outputFunctionMap [ 19 ] = { 0 , 0 ,
0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 } ; smData
-> mOutputFunctionMap = pm_create_int_vector ( 19 , alloc ) ; memcpy ( smData
-> mOutputFunctionMap -> mX , outputFunctionMap , 19 * sizeof ( int32_T ) ) ;
smData -> mNumOutputClasses = 1 ; smData -> mHasKinematicOutputs = true ;
smData -> mHasDynamicOutputs = false ; smData -> mIsOutputClass0Dynamic =
false ; smData -> mDoComputeDynamicOutputs = false ; smData ->
mCachedDerivativesAvailable = false ; { size_t i = 0 ; const int_T status =
pm_create_real_vector_fields ( & smData -> mCachedDerivatives , 0 ,
pm_default_allocator ( ) ) ; checkMemAllocStatus ( status ) ; for ( i = 0 ; i
< smData -> mCachedDerivatives . mN ; ++ i ) smData -> mCachedDerivatives .
mX [ i ] = 0.0 ; } }
#if 0
static void initializeSizePairVector ( const SmSizePair * data ,
SmSizePairVector * vector ) { const size_t n = sm_core_SmSizePairVector_size
( vector ) ; size_t i ; for ( i = 0 ; i < n ; ++ i , ++ data )
sm_core_SmSizePairVector_setValue ( vector , i , data ++ ) ; }
#endif
static void initAssemblyDelegate ( SmMechanismDelegate * delegate ) {
SmMechanismDelegateScratchpad * scratchpad = NULL ; const SmSizePair
jointToStageIdx [ 7 ] = { { 35 , 6 } , { 37 , 5 } , { 79 , 0 } , { 80 , 1 } ,
{ 109 , 2 } , { 128 , 3 } , { 129 , 4 } } ; const size_t primitiveIndices [ 7
+ 1 ] = { 0 , 1 , 2 , 3 , 4 , 5 , 8 , 9 } ; const SmSizePair stateOffsets [ 9
] = { { 0 , 4 } , { 7 , 11 } , { 14 , 18 } , { 21 , 25 } , { 28 , 32 } , { 35
, 38 } , { 36 , 39 } , { 37 , 40 } , { 41 , 45 } } ; const SmSizePair
dofOffsets [ 9 ] = { { 0 , 3 } , { 3 , 6 } , { 6 , 9 } , { 9 , 12 } , { 12 ,
15 } , { 15 , 16 } , { 16 , 17 } , { 17 , 18 } , { 18 , 21 } } ; const size_t
* flexibleStages = NULL ; const size_t * remodIndices = NULL ; const size_t
equationsPerConstraint [ 5 ] = { 3 , 3 , 3 , 3 , 3 } ; const size_t
dofToVelSlot [ 21 ] = { 4 , 5 , 6 , 11 , 12 , 13 , 18 , 19 , 20 , 25 , 26 ,
27 , 32 , 33 , 34 , 38 , 39 , 40 , 45 , 46 , 47 } ; const size_t
constraintDofs [ 39 ] = { 0 , 1 , 2 , 15 , 16 , 17 , 18 , 19 , 20 , 6 , 7 , 8
, 15 , 16 , 17 , 18 , 19 , 20 , 9 , 10 , 11 , 15 , 16 , 17 , 18 , 19 , 20 , 3
, 4 , 5 , 0 , 1 , 2 , 12 , 13 , 14 , 9 , 10 , 11 } ; const size_t
constraintDofOffsets [ 5 + 1 ] = { 0 , 9 , 18 , 27 , 33 , 39 } ; const size_t
Jm = 15 ; const size_t Jn = 21 ; SmSizePair zeroSizePair ; zeroSizePair .
mFirst = zeroSizePair . mSecond = 0 ;
sm_core_MechanismDelegate_allocScratchpad ( delegate ) ; scratchpad =
delegate -> mScratchpad ; delegate -> mTargetStrengthFree = 0 ; delegate ->
mTargetStrengthSuggested = 1 ; delegate -> mTargetStrengthDesired = 2 ;
delegate -> mTargetStrengthRequired = 3 ; delegate -> mConsistencyTol = +
9.999999999999999547e-07 ; delegate -> mTreeJointDof = 21 ; delegate -> mDof
= 21 ; delegate -> mStateSize = 48 ; delegate -> mContinuousStateSize = 48 ;
delegate -> mNumStages = 7 ; delegate -> mNumConstraints = 5 ; delegate ->
mNumAllConstraintEquations = 15 ; sm_core_SmSizePairVector_create ( &
delegate -> mJointToStageIdx , delegate -> mNumStages , & zeroSizePair ) ;
memcpy ( sm_core_SmSizePairVector_nonConstValues ( & delegate ->
mJointToStageIdx ) , jointToStageIdx , 7 * sizeof ( SmSizePair ) ) ;
sm_core_SmSizeTVector_create ( & delegate -> mPrimitiveIndices , delegate ->
mNumStages + 1 , 0 ) ; memcpy ( sm_core_SmSizeTVector_nonConstValues ( &
delegate -> mPrimitiveIndices ) , primitiveIndices , ( delegate -> mNumStages
+ 1 ) * sizeof ( size_t ) ) ; sm_core_SmSizePairVector_create ( & delegate ->
mStateOffsets , 9 , & zeroSizePair ) ; memcpy (
sm_core_SmSizePairVector_nonConstValues ( & delegate -> mStateOffsets ) ,
stateOffsets , 9 * sizeof ( SmSizePair ) ) ; sm_core_SmSizePairVector_create
( & delegate -> mDofOffsets , 9 , & zeroSizePair ) ; memcpy (
sm_core_SmSizePairVector_nonConstValues ( & delegate -> mDofOffsets ) ,
dofOffsets , 9 * sizeof ( SmSizePair ) ) ; sm_core_SmSizeTVector_create ( &
delegate -> mFlexibleStages , 0 , 0 ) ; memcpy (
sm_core_SmSizeTVector_nonConstValues ( & delegate -> mFlexibleStages ) ,
flexibleStages , 0 * sizeof ( size_t ) ) ; sm_core_SmSizeTVector_create ( &
delegate -> mRemodIndices , 0 , 0 ) ; memcpy (
sm_core_SmSizeTVector_nonConstValues ( & delegate -> mRemodIndices ) ,
remodIndices , 0 * sizeof ( size_t ) ) ; sm_core_SmSizeTVector_create ( &
delegate -> mEquationsPerConstraint , delegate -> mNumConstraints , 0 ) ;
memcpy ( sm_core_SmSizeTVector_nonConstValues ( & delegate ->
mEquationsPerConstraint ) , equationsPerConstraint , delegate ->
mNumConstraints * sizeof ( size_t ) ) ; sm_core_SmIntVector_create ( &
delegate -> mRunTimeEnabledEquations , delegate -> mNumAllConstraintEquations
, 1 ) ; sm_core_SmSizeTVector_create ( & delegate -> mDofToVelSlot , delegate
-> mDof , 0 ) ; memcpy ( sm_core_SmSizeTVector_nonConstValues ( & delegate ->
mDofToVelSlot ) , dofToVelSlot , delegate -> mDof * sizeof ( size_t ) ) ;
sm_core_SmSizeTVector_create ( & delegate -> mConstraintDofs , 39 , 0 ) ;
memcpy ( sm_core_SmSizeTVector_nonConstValues ( & delegate -> mConstraintDofs
) , constraintDofs , 39 * sizeof ( size_t ) ) ; sm_core_SmSizeTVector_create
( & delegate -> mConstraintDofOffsets , delegate -> mNumConstraints + 1 , 0 )
; memcpy ( sm_core_SmSizeTVector_nonConstValues ( & delegate ->
mConstraintDofOffsets ) , constraintDofOffsets , ( delegate ->
mNumConstraints + 1 ) * sizeof ( size_t ) ) ; sm_core_SmBoundedSet_create ( &
scratchpad -> mPosRequired , 21 ) ; sm_core_SmBoundedSet_create ( &
scratchpad -> mPosDesired , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad
-> mPosSuggested , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad ->
mPosFree , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad ->
mPosNonRequired , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad ->
mPosSuggAndFree , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad ->
mVelRequired , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad ->
mVelDesired , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad ->
mVelSuggested , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad -> mVelFree
, 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad -> mVelNonRequired , 21 )
; sm_core_SmBoundedSet_create ( & scratchpad -> mVelSuggAndFree , 21 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mConstraintFilter , 5 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mActiveConstraints , 5 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mActiveDofs , 21 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mActiveDofs0 , 21 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mNewConstraints , 5 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mNewDofs , 21 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mUnsatisfiedConstraints , 5 ) ;
sm_core_SmSizeTVector_create ( & scratchpad -> mActiveConstraintsVect , 5 , 0
) ; sm_core_SmSizeTVector_create ( & scratchpad -> mActiveDofsVect , 21 , 0 )
; sm_core_SmSizeTVector_create ( & scratchpad -> mFullDofToActiveDof , 21 , 0
) ; sm_core_SmSizePairVector_create ( & scratchpad ->
mPartiallyPosTargetedPrims , 9 , & zeroSizePair ) ;
sm_core_SmSizePairVector_create ( & scratchpad -> mPartiallyVelTargetedPrims
, 9 , & zeroSizePair ) ; sm_core_SmSizeTVector_create ( & scratchpad ->
mPosPartialTypes , 9 , 0 ) ; sm_core_SmSizeTVector_create ( & scratchpad ->
mVelPartialTypes , 9 , 0 ) ; sm_core_SmSizeTVector_create ( & scratchpad ->
mPartiallyActivePrims , 9 , 0 ) ; sm_core_SmSizePairVector_create ( &
scratchpad -> mBaseFrameVelOffsets , 6 , & zeroSizePair ) ;
sm_core_SmSizePairVector_create ( & scratchpad -> mCvVelOffsets , 9 , &
zeroSizePair ) ; sm_core_SmRealVector_create ( & scratchpad ->
mCvAzimuthValues , 9 , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mInitialState , 48 , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mStartState , 48 , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mTestState , 48 , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mFullStateVector , 48 , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mJacobianRowMaj , Jm * Jn , 0.0 ) ; sm_core_SmRealVector_create ( &
scratchpad -> mJacobian , Jm * Jn , 0.0 ) ; sm_core_SmRealVector_create ( &
scratchpad -> mJacobianPrimSubmatrix , Jm * 6 , 0.0 ) ;
sm_core_SmRealVector_create ( & scratchpad -> mConstraintNonhomoTerms , Jm ,
0.0 ) ; sm_core_SmRealVector_create ( & scratchpad -> mConstraintError , Jm ,
0.0 ) ; sm_core_SmRealVector_create ( & scratchpad -> mBestConstraintError ,
Jm , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad -> mDeltas , Jn * (
Jm <= Jn ? Jm : Jn ) , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mSvdWork , 1399 , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mLineSearchScaledDeltaVect , 21 , 0.0 ) ; sm_core_SmRealVector_create ( &
scratchpad -> mLineSearchTestStateVect , 48 , 0.0 ) ;
sm_core_SmRealVector_create ( & scratchpad -> mLineSearchErrorVect , Jm , 0.0
) ; sm_core_SmRealVector_create ( & scratchpad -> mActiveDofVelsVect , 21 ,
0.0 ) ; sm_core_SmRealVector_create ( & scratchpad -> mVelSystemRhs , Jm ,
0.0 ) ; sm_core_SmRealVector_create ( & scratchpad -> mMotionData , 98 , 0.0
) ; delegate -> mSetTargets = Kinematics_Model_2b2b31c2_1_setTargets ;
delegate -> mResetStateVector = Kinematics_Model_2b2b31c2_1_resetStateVector
; delegate -> mInitializeTrackedAngleState =
Kinematics_Model_2b2b31c2_1_initializeTrackedAngleState ; delegate ->
mComputeDiscreteState = Kinematics_Model_2b2b31c2_1_computeDiscreteState ;
delegate -> mAdjustPosition = Kinematics_Model_2b2b31c2_1_adjustPosition ;
delegate -> mPerturbJointPrimitiveState =
Kinematics_Model_2b2b31c2_1_perturbJointPrimitiveState ; delegate ->
mPerturbFlexibleBodyState =
Kinematics_Model_2b2b31c2_1_perturbFlexibleBodyState ; delegate ->
mComputeDofBlendMatrix = Kinematics_Model_2b2b31c2_1_computeDofBlendMatrix ;
delegate -> mProjectPartiallyTargetedPos =
Kinematics_Model_2b2b31c2_1_projectPartiallyTargetedPos ; delegate ->
mPropagateMotion = Kinematics_Model_2b2b31c2_1_propagateMotion ; delegate ->
mComputeAssemblyError = Kinematics_Model_2b2b31c2_1_computeAssemblyError ;
delegate -> mComputeAssemblyJacobian =
Kinematics_Model_2b2b31c2_1_computeAssemblyJacobian ; delegate ->
mComputeFullAssemblyJacobian =
Kinematics_Model_2b2b31c2_1_computeFullAssemblyJacobian ; delegate ->
mIsInKinematicSingularity =
Kinematics_Model_2b2b31c2_1_isInKinematicSingularity ; delegate ->
mConvertStateVector = Kinematics_Model_2b2b31c2_1_convertStateVector ;
delegate -> mConstructStateVector =
Kinematics_Model_2b2b31c2_1_constructStateVector ; delegate ->
mExtractSolverStateVector =
Kinematics_Model_2b2b31c2_1_extractSolverStateVector ; delegate ->
mIsPositionViolation = Kinematics_Model_2b2b31c2_1_isPositionViolation ;
delegate -> mIsVelocityViolation =
Kinematics_Model_2b2b31c2_1_isVelocityViolation ; delegate ->
mProjectStateSim = Kinematics_Model_2b2b31c2_1_projectStateSim ; delegate ->
mComputeConstraintError = Kinematics_Model_2b2b31c2_1_computeConstraintError
; delegate -> mMech = NULL ; } static void initSimulationDelegate (
SmMechanismDelegate * delegate ) { SmMechanismDelegateScratchpad * scratchpad
= NULL ; const SmSizePair jointToStageIdx [ 7 ] = { { 35 , 6 } , { 37 , 5 } ,
{ 79 , 0 } , { 80 , 1 } , { 109 , 2 } , { 128 , 3 } , { 129 , 4 } } ; const
size_t primitiveIndices [ 7 + 1 ] = { 0 , 1 , 2 , 3 , 4 , 5 , 8 , 9 } ; const
SmSizePair stateOffsets [ 9 ] = { { 0 , 4 } , { 7 , 11 } , { 14 , 18 } , { 21
, 25 } , { 28 , 32 } , { 35 , 38 } , { 36 , 39 } , { 37 , 40 } , { 41 , 45 }
} ; const SmSizePair dofOffsets [ 9 ] = { { 0 , 3 } , { 3 , 6 } , { 6 , 9 } ,
{ 9 , 12 } , { 12 , 15 } , { 15 , 16 } , { 16 , 17 } , { 17 , 18 } , { 18 ,
21 } } ; const size_t * flexibleStages = NULL ; const size_t * remodIndices =
NULL ; const size_t equationsPerConstraint [ 5 ] = { 3 , 3 , 3 , 3 , 3 } ;
const size_t dofToVelSlot [ 21 ] = { 4 , 5 , 6 , 11 , 12 , 13 , 18 , 19 , 20
, 25 , 26 , 27 , 32 , 33 , 34 , 38 , 39 , 40 , 45 , 46 , 47 } ; const size_t
constraintDofs [ 39 ] = { 0 , 1 , 2 , 15 , 16 , 17 , 18 , 19 , 20 , 6 , 7 , 8
, 15 , 16 , 17 , 18 , 19 , 20 , 9 , 10 , 11 , 15 , 16 , 17 , 18 , 19 , 20 , 3
, 4 , 5 , 0 , 1 , 2 , 12 , 13 , 14 , 9 , 10 , 11 } ; const size_t
constraintDofOffsets [ 5 + 1 ] = { 0 , 9 , 18 , 27 , 33 , 39 } ; const size_t
Jm = 15 ; const size_t Jn = 21 ; SmSizePair zeroSizePair ; zeroSizePair .
mFirst = zeroSizePair . mSecond = 0 ;
sm_core_MechanismDelegate_allocScratchpad ( delegate ) ; scratchpad =
delegate -> mScratchpad ; delegate -> mTargetStrengthFree = 0 ; delegate ->
mTargetStrengthSuggested = 1 ; delegate -> mTargetStrengthDesired = 2 ;
delegate -> mTargetStrengthRequired = 3 ; delegate -> mConsistencyTol = +
9.999999999999999547e-07 ; delegate -> mTreeJointDof = 21 ; delegate -> mDof
= 21 ; delegate -> mStateSize = 48 ; delegate -> mContinuousStateSize = 48 ;
delegate -> mNumStages = 7 ; delegate -> mNumConstraints = 5 ; delegate ->
mNumAllConstraintEquations = 15 ; sm_core_SmSizePairVector_create ( &
delegate -> mJointToStageIdx , delegate -> mNumStages , & zeroSizePair ) ;
memcpy ( sm_core_SmSizePairVector_nonConstValues ( & delegate ->
mJointToStageIdx ) , jointToStageIdx , 7 * sizeof ( SmSizePair ) ) ;
sm_core_SmSizeTVector_create ( & delegate -> mPrimitiveIndices , delegate ->
mNumStages + 1 , 0 ) ; memcpy ( sm_core_SmSizeTVector_nonConstValues ( &
delegate -> mPrimitiveIndices ) , primitiveIndices , ( delegate -> mNumStages
+ 1 ) * sizeof ( size_t ) ) ; sm_core_SmSizePairVector_create ( & delegate ->
mStateOffsets , 9 , & zeroSizePair ) ; memcpy (
sm_core_SmSizePairVector_nonConstValues ( & delegate -> mStateOffsets ) ,
stateOffsets , 9 * sizeof ( SmSizePair ) ) ; sm_core_SmSizePairVector_create
( & delegate -> mDofOffsets , 9 , & zeroSizePair ) ; memcpy (
sm_core_SmSizePairVector_nonConstValues ( & delegate -> mDofOffsets ) ,
dofOffsets , 9 * sizeof ( SmSizePair ) ) ; sm_core_SmSizeTVector_create ( &
delegate -> mFlexibleStages , 0 , 0 ) ; memcpy (
sm_core_SmSizeTVector_nonConstValues ( & delegate -> mFlexibleStages ) ,
flexibleStages , 0 * sizeof ( size_t ) ) ; sm_core_SmSizeTVector_create ( &
delegate -> mRemodIndices , 0 , 0 ) ; memcpy (
sm_core_SmSizeTVector_nonConstValues ( & delegate -> mRemodIndices ) ,
remodIndices , 0 * sizeof ( size_t ) ) ; sm_core_SmSizeTVector_create ( &
delegate -> mEquationsPerConstraint , delegate -> mNumConstraints , 0 ) ;
memcpy ( sm_core_SmSizeTVector_nonConstValues ( & delegate ->
mEquationsPerConstraint ) , equationsPerConstraint , delegate ->
mNumConstraints * sizeof ( size_t ) ) ; sm_core_SmIntVector_create ( &
delegate -> mRunTimeEnabledEquations , delegate -> mNumAllConstraintEquations
, 1 ) ; sm_core_SmSizeTVector_create ( & delegate -> mDofToVelSlot , delegate
-> mDof , 0 ) ; memcpy ( sm_core_SmSizeTVector_nonConstValues ( & delegate ->
mDofToVelSlot ) , dofToVelSlot , delegate -> mDof * sizeof ( size_t ) ) ;
sm_core_SmSizeTVector_create ( & delegate -> mConstraintDofs , 39 , 0 ) ;
memcpy ( sm_core_SmSizeTVector_nonConstValues ( & delegate -> mConstraintDofs
) , constraintDofs , 39 * sizeof ( size_t ) ) ; sm_core_SmSizeTVector_create
( & delegate -> mConstraintDofOffsets , delegate -> mNumConstraints + 1 , 0 )
; memcpy ( sm_core_SmSizeTVector_nonConstValues ( & delegate ->
mConstraintDofOffsets ) , constraintDofOffsets , ( delegate ->
mNumConstraints + 1 ) * sizeof ( size_t ) ) ; sm_core_SmBoundedSet_create ( &
scratchpad -> mPosRequired , 21 ) ; sm_core_SmBoundedSet_create ( &
scratchpad -> mPosDesired , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad
-> mPosSuggested , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad ->
mPosFree , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad ->
mPosNonRequired , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad ->
mPosSuggAndFree , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad ->
mVelRequired , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad ->
mVelDesired , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad ->
mVelSuggested , 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad -> mVelFree
, 21 ) ; sm_core_SmBoundedSet_create ( & scratchpad -> mVelNonRequired , 21 )
; sm_core_SmBoundedSet_create ( & scratchpad -> mVelSuggAndFree , 21 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mConstraintFilter , 5 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mActiveConstraints , 5 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mActiveDofs , 21 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mActiveDofs0 , 21 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mNewConstraints , 5 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mNewDofs , 21 ) ;
sm_core_SmBoundedSet_create ( & scratchpad -> mUnsatisfiedConstraints , 5 ) ;
sm_core_SmSizeTVector_create ( & scratchpad -> mActiveConstraintsVect , 5 , 0
) ; sm_core_SmSizeTVector_create ( & scratchpad -> mActiveDofsVect , 21 , 0 )
; sm_core_SmSizeTVector_create ( & scratchpad -> mFullDofToActiveDof , 21 , 0
) ; sm_core_SmSizePairVector_create ( & scratchpad ->
mPartiallyPosTargetedPrims , 9 , & zeroSizePair ) ;
sm_core_SmSizePairVector_create ( & scratchpad -> mPartiallyVelTargetedPrims
, 9 , & zeroSizePair ) ; sm_core_SmSizeTVector_create ( & scratchpad ->
mPosPartialTypes , 9 , 0 ) ; sm_core_SmSizeTVector_create ( & scratchpad ->
mVelPartialTypes , 9 , 0 ) ; sm_core_SmSizeTVector_create ( & scratchpad ->
mPartiallyActivePrims , 9 , 0 ) ; sm_core_SmSizePairVector_create ( &
scratchpad -> mBaseFrameVelOffsets , 6 , & zeroSizePair ) ;
sm_core_SmSizePairVector_create ( & scratchpad -> mCvVelOffsets , 9 , &
zeroSizePair ) ; sm_core_SmRealVector_create ( & scratchpad ->
mCvAzimuthValues , 9 , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mInitialState , 48 , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mStartState , 48 , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mTestState , 48 , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mFullStateVector , 48 , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mJacobianRowMaj , Jm * Jn , 0.0 ) ; sm_core_SmRealVector_create ( &
scratchpad -> mJacobian , Jm * Jn , 0.0 ) ; sm_core_SmRealVector_create ( &
scratchpad -> mJacobianPrimSubmatrix , Jm * 6 , 0.0 ) ;
sm_core_SmRealVector_create ( & scratchpad -> mConstraintNonhomoTerms , Jm ,
0.0 ) ; sm_core_SmRealVector_create ( & scratchpad -> mConstraintError , Jm ,
0.0 ) ; sm_core_SmRealVector_create ( & scratchpad -> mBestConstraintError ,
Jm , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad -> mDeltas , Jn * (
Jm <= Jn ? Jm : Jn ) , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mSvdWork , 1399 , 0.0 ) ; sm_core_SmRealVector_create ( & scratchpad ->
mLineSearchScaledDeltaVect , 21 , 0.0 ) ; sm_core_SmRealVector_create ( &
scratchpad -> mLineSearchTestStateVect , 48 , 0.0 ) ;
sm_core_SmRealVector_create ( & scratchpad -> mLineSearchErrorVect , Jm , 0.0
) ; sm_core_SmRealVector_create ( & scratchpad -> mActiveDofVelsVect , 21 ,
0.0 ) ; sm_core_SmRealVector_create ( & scratchpad -> mVelSystemRhs , Jm ,
0.0 ) ; sm_core_SmRealVector_create ( & scratchpad -> mMotionData , 98 , 0.0
) ; delegate -> mSetTargets = NULL ; delegate -> mResetStateVector =
Kinematics_Model_2b2b31c2_1_resetStateVector ; delegate ->
mInitializeTrackedAngleState =
Kinematics_Model_2b2b31c2_1_initializeTrackedAngleState ; delegate ->
mComputeDiscreteState = Kinematics_Model_2b2b31c2_1_computeDiscreteState ;
delegate -> mAdjustPosition = Kinematics_Model_2b2b31c2_1_adjustPosition ;
delegate -> mPerturbJointPrimitiveState =
Kinematics_Model_2b2b31c2_1_perturbJointPrimitiveState ; delegate ->
mPerturbFlexibleBodyState =
Kinematics_Model_2b2b31c2_1_perturbFlexibleBodyState ; delegate ->
mComputeDofBlendMatrix = NULL ; delegate -> mProjectPartiallyTargetedPos =
NULL ; delegate -> mPropagateMotion =
Kinematics_Model_2b2b31c2_1_propagateMotion ; delegate ->
mComputeAssemblyError = Kinematics_Model_2b2b31c2_1_computeAssemblyError ;
delegate -> mComputeAssemblyJacobian =
Kinematics_Model_2b2b31c2_1_computeAssemblyJacobian ; delegate ->
mComputeFullAssemblyJacobian =
Kinematics_Model_2b2b31c2_1_computeFullAssemblyJacobian ; delegate ->
mIsInKinematicSingularity =
Kinematics_Model_2b2b31c2_1_isInKinematicSingularity ; delegate ->
mConvertStateVector = Kinematics_Model_2b2b31c2_1_convertStateVector ;
delegate -> mConstructStateVector =
Kinematics_Model_2b2b31c2_1_constructStateVector ; delegate ->
mExtractSolverStateVector =
Kinematics_Model_2b2b31c2_1_extractSolverStateVector ; delegate ->
mIsPositionViolation = Kinematics_Model_2b2b31c2_1_isPositionViolation ;
delegate -> mIsVelocityViolation =
Kinematics_Model_2b2b31c2_1_isVelocityViolation ; delegate ->
mProjectStateSim = Kinematics_Model_2b2b31c2_1_projectStateSim ; delegate ->
mComputeConstraintError = Kinematics_Model_2b2b31c2_1_computeConstraintError
; delegate -> mMech = NULL ; } static void initMechanismDelegates (
NeDaePrivateData * smData ) { PmAllocator * alloc = pm_default_allocator ( )
; const int32_T motionInputOffsets [ 1 ] = { 0 } ; int_T status = 0 ;
initAssemblyDelegate ( & smData -> mAssemblyDelegate ) ;
initSimulationDelegate ( & smData -> mSimulationDelegate ) ; status =
pm_create_int_vector_fields ( & smData -> mMotionInputOffsets , smData ->
mNumInputMotionPrimitives , alloc ) ; checkMemAllocStatus ( status ) ; memcpy
( smData -> mMotionInputOffsets . mX , motionInputOffsets , 1 * sizeof (
int32_T ) ) ; } static void initComputationFcnPtrs ( NeDaePrivateData *
smData ) { smData -> mSetParametersFcn = dae_cg_setParameters_function ;
smData -> mPAssertFcn = dae_cg_pAssert_method ; smData -> mDerivativeFcn =
dae_cg_deriv_method ; smData -> mOutputFcn = dae_cg_output_method ; smData ->
mProjectionFcn = dae_cg_project_solve ; smData -> mProjectionMaybeFcn =
dae_cg_projectMaybe_solve ; smData -> mCheckFcn = ( smData ->
mStateVectorSize == 0 ) ? dae_cg_check_solve : NULL ; smData -> mAssemblyFcn
= dae_cg_assemble_solve ; smData -> mSetupLoggerFcn =
sm_ssci_setupLoggerFcn_codeGen ; smData -> mLogFcn = sm_ssci_logFcn_codeGen ;
smData -> mResidualsFcn = NULL ; smData -> mLinearizeFcn = NULL ; smData ->
mGenerateFcn = NULL ; } static void initLiveLinkToSm ( NeDaePrivateData *
smData ) { smData -> mLiveSmLink = NULL ; smData -> mLiveSmLink_destroy =
NULL ; smData -> mLiveSmLink_copy = NULL ; } void
Kinematics_Model_2b2b31c2_1_NeDaePrivateData_create ( NeDaePrivateData *
smData ) { initBasicAttributes ( smData ) ; initStateVector ( smData ) ;
initAsserts ( smData ) ; initVariables ( smData ) ; initRuntimeParameters (
smData ) ; initIoInfo ( smData ) ; initInputDerivs ( smData ) ;
initDirectFeedthrough ( smData ) ; initOutputDerivProc ( smData ) ;
initMechanismDelegates ( smData ) ; initComputationFcnPtrs ( smData ) ;
initLiveLinkToSm ( smData ) ; }
