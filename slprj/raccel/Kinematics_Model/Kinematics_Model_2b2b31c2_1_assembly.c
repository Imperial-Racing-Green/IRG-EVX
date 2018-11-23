#include "__cf_Kinematics_Model.h"
#include <math.h>
#include <string.h>
#include "pm_std.h"
#include "sm_std.h"
#include "ne_std.h"
#include "ne_dae.h"
#include "sm_ssci_run_time_errors.h"
#include "sm_CTarget.h"
static boolean_T checkTargets_12 ( const double * rtdv , const double * state
) { double xx [ 1 ] ; ( void ) rtdv ; xx [ 0 ] = 1.0e-6 ; return fabs ( state
[ 7 ] - 1.0 ) < xx [ 0 ] && fabs ( state [ 8 ] ) < xx [ 0 ] && fabs ( state [
9 ] ) < xx [ 0 ] && fabs ( state [ 10 ] ) < xx [ 0 ] ; } static boolean_T
checkTargets_16 ( const double * rtdv , const double * state ) { double xx [
2 ] ; ( void ) rtdv ; xx [ 0 ] = 0.7071067811865476 ; xx [ 1 ] = 1.0e-6 ;
return fabs ( state [ 14 ] - xx [ 0 ] ) < xx [ 1 ] && fabs ( state [ 15 ] ) <
xx [ 1 ] && fabs ( state [ 16 ] ) < xx [ 1 ] && fabs ( state [ 17 ] - xx [ 0
] ) < xx [ 1 ] ; } void Kinematics_Model_2b2b31c2_1_checkTargets ( const
double * rtdv , const double * state ) { const char * msgId =
"sm:compiler:state:UnsatisfiedDesiredTarget" ; if ( ! checkTargets_12 ( rtdv
, state ) ) { pmf_preformatted_warning ( msgId ,
"Kinematics_Model/LWB Rear Joint S high priority position target not achieved"
) ; pmf_printf (
 "[manual]Kinematics_Model/LWB Rear Joint S high priority position target not achieved\n"
) ; } if ( ! checkTargets_16 ( rtdv , state ) ) { pmf_preformatted_warning (
msgId ,
 "Kinematics_Model/Trackrod  Inner Joint S high priority position target not achieved"
) ; pmf_printf (
 "[manual]Kinematics_Model/Trackrod  Inner Joint S high priority position target not achieved\n"
) ; } } void Kinematics_Model_2b2b31c2_1_setTargets ( const double * rtdv ,
CTarget * targets ) { ( void ) rtdv ; ( void ) targets ; } void
Kinematics_Model_2b2b31c2_1_resetStateVector ( const void * mech , double *
state ) { double xx [ 2 ] ; ( void ) mech ; xx [ 0 ] = 1.0 ; xx [ 1 ] = 0.0 ;
state [ 0 ] = xx [ 0 ] ; state [ 1 ] = xx [ 1 ] ; state [ 2 ] = xx [ 1 ] ;
state [ 3 ] = xx [ 1 ] ; state [ 4 ] = xx [ 1 ] ; state [ 5 ] = xx [ 1 ] ;
state [ 6 ] = xx [ 1 ] ; state [ 7 ] = xx [ 0 ] ; state [ 8 ] = xx [ 1 ] ;
state [ 9 ] = xx [ 1 ] ; state [ 10 ] = xx [ 1 ] ; state [ 11 ] = xx [ 1 ] ;
state [ 12 ] = xx [ 1 ] ; state [ 13 ] = xx [ 1 ] ; state [ 14 ] = xx [ 0 ] ;
state [ 15 ] = xx [ 1 ] ; state [ 16 ] = xx [ 1 ] ; state [ 17 ] = xx [ 1 ] ;
state [ 18 ] = xx [ 1 ] ; state [ 19 ] = xx [ 1 ] ; state [ 20 ] = xx [ 1 ] ;
state [ 21 ] = xx [ 0 ] ; state [ 22 ] = xx [ 1 ] ; state [ 23 ] = xx [ 1 ] ;
state [ 24 ] = xx [ 1 ] ; state [ 25 ] = xx [ 1 ] ; state [ 26 ] = xx [ 1 ] ;
state [ 27 ] = xx [ 1 ] ; state [ 28 ] = xx [ 0 ] ; state [ 29 ] = xx [ 1 ] ;
state [ 30 ] = xx [ 1 ] ; state [ 31 ] = xx [ 1 ] ; state [ 32 ] = xx [ 1 ] ;
state [ 33 ] = xx [ 1 ] ; state [ 34 ] = xx [ 1 ] ; state [ 35 ] = xx [ 1 ] ;
state [ 36 ] = xx [ 1 ] ; state [ 37 ] = xx [ 1 ] ; state [ 38 ] = xx [ 1 ] ;
state [ 39 ] = xx [ 1 ] ; state [ 40 ] = xx [ 1 ] ; state [ 41 ] = xx [ 0 ] ;
state [ 42 ] = xx [ 1 ] ; state [ 43 ] = xx [ 1 ] ; state [ 44 ] = xx [ 1 ] ;
state [ 45 ] = xx [ 1 ] ; state [ 46 ] = xx [ 1 ] ; state [ 47 ] = xx [ 1 ] ;
} void Kinematics_Model_2b2b31c2_1_initializeTrackedAngleState ( const void *
mech , const double * rtdv , const double * motionData , double * state ,
void * neDiagMgr0 ) { NeuDiagnosticManager * neDiagMgr = (
NeuDiagnosticManager * ) neDiagMgr0 ; ( void ) mech ; ( void ) rtdv ; ( void
) motionData ; ( void ) state ; ( void ) neDiagMgr ; } void
Kinematics_Model_2b2b31c2_1_computeDiscreteState ( const void * mech , const
double * rtdv , double * state ) { ( void ) mech ; ( void ) rtdv ; ( void )
state ; } void Kinematics_Model_2b2b31c2_1_adjustPosition ( const void * mech
, const double * dofDeltas , double * state ) { double xx [ 37 ] ; ( void )
mech ; xx [ 0 ] = state [ 0 ] ; xx [ 1 ] = state [ 1 ] ; xx [ 2 ] = state [ 2
] ; xx [ 3 ] = state [ 3 ] ; xx [ 4 ] = dofDeltas [ 0 ] ; xx [ 5 ] =
dofDeltas [ 1 ] ; xx [ 6 ] = dofDeltas [ 2 ] ; pm_math_quatDeriv ( xx + 0 ,
xx + 4 , xx + 7 ) ; xx [ 0 ] = state [ 0 ] + xx [ 7 ] ; xx [ 1 ] = state [ 1
] + xx [ 8 ] ; xx [ 2 ] = state [ 2 ] + xx [ 9 ] ; xx [ 3 ] = state [ 3 ] +
xx [ 10 ] ; xx [ 4 ] = 1.0e-64 ; xx [ 5 ] = sqrt ( xx [ 0 ] * xx [ 0 ] + xx [
1 ] * xx [ 1 ] + xx [ 2 ] * xx [ 2 ] + xx [ 3 ] * xx [ 3 ] ) ; if ( xx [ 4 ]
> xx [ 5 ] ) xx [ 5 ] = xx [ 4 ] ; xx [ 6 ] = state [ 7 ] ; xx [ 7 ] = state
[ 8 ] ; xx [ 8 ] = state [ 9 ] ; xx [ 9 ] = state [ 10 ] ; xx [ 10 ] =
dofDeltas [ 3 ] ; xx [ 11 ] = dofDeltas [ 4 ] ; xx [ 12 ] = dofDeltas [ 5 ] ;
pm_math_quatDeriv ( xx + 6 , xx + 10 , xx + 13 ) ; xx [ 6 ] = state [ 7 ] +
xx [ 13 ] ; xx [ 7 ] = state [ 8 ] + xx [ 14 ] ; xx [ 8 ] = state [ 9 ] + xx
[ 15 ] ; xx [ 9 ] = state [ 10 ] + xx [ 16 ] ; xx [ 10 ] = sqrt ( xx [ 6 ] *
xx [ 6 ] + xx [ 7 ] * xx [ 7 ] + xx [ 8 ] * xx [ 8 ] + xx [ 9 ] * xx [ 9 ] )
; if ( xx [ 4 ] > xx [ 10 ] ) xx [ 10 ] = xx [ 4 ] ; xx [ 11 ] = state [ 14 ]
; xx [ 12 ] = state [ 15 ] ; xx [ 13 ] = state [ 16 ] ; xx [ 14 ] = state [
17 ] ; xx [ 15 ] = dofDeltas [ 6 ] ; xx [ 16 ] = dofDeltas [ 7 ] ; xx [ 17 ]
= dofDeltas [ 8 ] ; pm_math_quatDeriv ( xx + 11 , xx + 15 , xx + 18 ) ; xx [
11 ] = state [ 14 ] + xx [ 18 ] ; xx [ 12 ] = state [ 15 ] + xx [ 19 ] ; xx [
13 ] = state [ 16 ] + xx [ 20 ] ; xx [ 14 ] = state [ 17 ] + xx [ 21 ] ; xx [
15 ] = sqrt ( xx [ 11 ] * xx [ 11 ] + xx [ 12 ] * xx [ 12 ] + xx [ 13 ] * xx
[ 13 ] + xx [ 14 ] * xx [ 14 ] ) ; if ( xx [ 4 ] > xx [ 15 ] ) xx [ 15 ] = xx
[ 4 ] ; xx [ 16 ] = state [ 21 ] ; xx [ 17 ] = state [ 22 ] ; xx [ 18 ] =
state [ 23 ] ; xx [ 19 ] = state [ 24 ] ; xx [ 20 ] = dofDeltas [ 9 ] ; xx [
21 ] = dofDeltas [ 10 ] ; xx [ 22 ] = dofDeltas [ 11 ] ; pm_math_quatDeriv (
xx + 16 , xx + 20 , xx + 23 ) ; xx [ 16 ] = state [ 21 ] + xx [ 23 ] ; xx [
17 ] = state [ 22 ] + xx [ 24 ] ; xx [ 18 ] = state [ 23 ] + xx [ 25 ] ; xx [
19 ] = state [ 24 ] + xx [ 26 ] ; xx [ 20 ] = sqrt ( xx [ 16 ] * xx [ 16 ] +
xx [ 17 ] * xx [ 17 ] + xx [ 18 ] * xx [ 18 ] + xx [ 19 ] * xx [ 19 ] ) ; if
( xx [ 4 ] > xx [ 20 ] ) xx [ 20 ] = xx [ 4 ] ; xx [ 21 ] = state [ 28 ] ; xx
[ 22 ] = state [ 29 ] ; xx [ 23 ] = state [ 30 ] ; xx [ 24 ] = state [ 31 ] ;
xx [ 25 ] = dofDeltas [ 12 ] ; xx [ 26 ] = dofDeltas [ 13 ] ; xx [ 27 ] =
dofDeltas [ 14 ] ; pm_math_quatDeriv ( xx + 21 , xx + 25 , xx + 28 ) ; xx [
21 ] = state [ 28 ] + xx [ 28 ] ; xx [ 22 ] = state [ 29 ] + xx [ 29 ] ; xx [
23 ] = state [ 30 ] + xx [ 30 ] ; xx [ 24 ] = state [ 31 ] + xx [ 31 ] ; xx [
25 ] = sqrt ( xx [ 21 ] * xx [ 21 ] + xx [ 22 ] * xx [ 22 ] + xx [ 23 ] * xx
[ 23 ] + xx [ 24 ] * xx [ 24 ] ) ; if ( xx [ 4 ] > xx [ 25 ] ) xx [ 25 ] = xx
[ 4 ] ; xx [ 26 ] = state [ 41 ] ; xx [ 27 ] = state [ 42 ] ; xx [ 28 ] =
state [ 43 ] ; xx [ 29 ] = state [ 44 ] ; xx [ 30 ] = dofDeltas [ 18 ] ; xx [
31 ] = dofDeltas [ 19 ] ; xx [ 32 ] = dofDeltas [ 20 ] ; pm_math_quatDeriv (
xx + 26 , xx + 30 , xx + 33 ) ; xx [ 26 ] = state [ 41 ] + xx [ 33 ] ; xx [
27 ] = state [ 42 ] + xx [ 34 ] ; xx [ 28 ] = state [ 43 ] + xx [ 35 ] ; xx [
29 ] = state [ 44 ] + xx [ 36 ] ; xx [ 30 ] = sqrt ( xx [ 26 ] * xx [ 26 ] +
xx [ 27 ] * xx [ 27 ] + xx [ 28 ] * xx [ 28 ] + xx [ 29 ] * xx [ 29 ] ) ; if
( xx [ 4 ] > xx [ 30 ] ) xx [ 30 ] = xx [ 4 ] ; state [ 0 ] = xx [ 0 ] / xx [
5 ] ; state [ 1 ] = xx [ 1 ] / xx [ 5 ] ; state [ 2 ] = xx [ 2 ] / xx [ 5 ] ;
state [ 3 ] = xx [ 3 ] / xx [ 5 ] ; state [ 7 ] = xx [ 6 ] / xx [ 10 ] ;
state [ 8 ] = xx [ 7 ] / xx [ 10 ] ; state [ 9 ] = xx [ 8 ] / xx [ 10 ] ;
state [ 10 ] = xx [ 9 ] / xx [ 10 ] ; state [ 14 ] = xx [ 11 ] / xx [ 15 ] ;
state [ 15 ] = xx [ 12 ] / xx [ 15 ] ; state [ 16 ] = xx [ 13 ] / xx [ 15 ] ;
state [ 17 ] = xx [ 14 ] / xx [ 15 ] ; state [ 21 ] = xx [ 16 ] / xx [ 20 ] ;
state [ 22 ] = xx [ 17 ] / xx [ 20 ] ; state [ 23 ] = xx [ 18 ] / xx [ 20 ] ;
state [ 24 ] = xx [ 19 ] / xx [ 20 ] ; state [ 28 ] = xx [ 21 ] / xx [ 25 ] ;
state [ 29 ] = xx [ 22 ] / xx [ 25 ] ; state [ 30 ] = xx [ 23 ] / xx [ 25 ] ;
state [ 31 ] = xx [ 24 ] / xx [ 25 ] ; state [ 35 ] = state [ 35 ] +
dofDeltas [ 15 ] ; state [ 36 ] = state [ 36 ] + dofDeltas [ 16 ] ; state [
37 ] = state [ 37 ] + dofDeltas [ 17 ] ; state [ 41 ] = xx [ 26 ] / xx [ 30 ]
; state [ 42 ] = xx [ 27 ] / xx [ 30 ] ; state [ 43 ] = xx [ 28 ] / xx [ 30 ]
; state [ 44 ] = xx [ 29 ] / xx [ 30 ] ; } static void
perturbJointPrimitiveState_0_0 ( double mag , double * state ) { double xx [
14 ] ; xx [ 0 ] = 0.5 * mag ; xx [ 1 ] = fabs ( mag ) ; xx [ 2 ] = 1.0 / ( xx
[ 1 ] - floor ( xx [ 1 ] ) + 1.0e-9 ) ; xx [ 1 ] = sin ( xx [ 2 ] ) ; xx [ 3
] = cos ( xx [ 2 ] ) ; xx [ 4 ] = sin ( 2.0 * xx [ 2 ] ) ; xx [ 2 ] = sqrt (
xx [ 1 ] * xx [ 1 ] + xx [ 3 ] * xx [ 3 ] + xx [ 4 ] * xx [ 4 ] ) ; xx [ 5 ]
= sin ( xx [ 0 ] ) ; xx [ 6 ] = cos ( xx [ 0 ] ) ; xx [ 7 ] = xx [ 1 ] / xx [
2 ] * xx [ 5 ] ; xx [ 8 ] = xx [ 3 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 9 ] = xx [
4 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 0 ] = state [ 0 ] ; xx [ 1 ] = state [ 1 ] ;
xx [ 2 ] = state [ 2 ] ; xx [ 3 ] = state [ 3 ] ; pm_math_quatCompose ( xx +
6 , xx + 0 , xx + 10 ) ; state [ 0 ] = xx [ 10 ] ; state [ 1 ] = xx [ 11 ] ;
state [ 2 ] = xx [ 12 ] ; state [ 3 ] = xx [ 13 ] ; } static void
perturbJointPrimitiveState_0_0v ( double mag , double * state ) { double xx [
14 ] ; xx [ 0 ] = 0.5 * mag ; xx [ 1 ] = fabs ( mag ) ; xx [ 2 ] = 1.0 / ( xx
[ 1 ] - floor ( xx [ 1 ] ) + 1.0e-9 ) ; xx [ 1 ] = sin ( xx [ 2 ] ) ; xx [ 3
] = cos ( xx [ 2 ] ) ; xx [ 4 ] = sin ( 2.0 * xx [ 2 ] ) ; xx [ 2 ] = sqrt (
xx [ 1 ] * xx [ 1 ] + xx [ 3 ] * xx [ 3 ] + xx [ 4 ] * xx [ 4 ] ) ; xx [ 5 ]
= sin ( xx [ 0 ] ) ; xx [ 6 ] = cos ( xx [ 0 ] ) ; xx [ 7 ] = xx [ 1 ] / xx [
2 ] * xx [ 5 ] ; xx [ 8 ] = xx [ 3 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 9 ] = xx [
4 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 1 ] = state [ 0 ] ; xx [ 2 ] = state [ 1 ] ;
xx [ 3 ] = state [ 2 ] ; xx [ 4 ] = state [ 3 ] ; pm_math_quatCompose ( xx +
6 , xx + 1 , xx + 10 ) ; state [ 0 ] = xx [ 10 ] ; state [ 1 ] = xx [ 11 ] ;
state [ 2 ] = xx [ 12 ] ; state [ 3 ] = xx [ 13 ] ; state [ 4 ] = state [ 4 ]
+ 1.2 * mag ; state [ 5 ] = state [ 5 ] - xx [ 0 ] ; state [ 6 ] = state [ 6
] + 0.9 * mag ; } static void perturbJointPrimitiveState_1_0 ( double mag ,
double * state ) { double xx [ 14 ] ; xx [ 0 ] = 0.5 * mag ; xx [ 1 ] = fabs
( mag ) ; xx [ 2 ] = 1.0 / ( xx [ 1 ] - floor ( xx [ 1 ] ) + 1.0e-9 ) ; xx [
1 ] = sin ( xx [ 2 ] ) ; xx [ 3 ] = cos ( xx [ 2 ] ) ; xx [ 4 ] = sin ( 2.0 *
xx [ 2 ] ) ; xx [ 2 ] = sqrt ( xx [ 1 ] * xx [ 1 ] + xx [ 3 ] * xx [ 3 ] + xx
[ 4 ] * xx [ 4 ] ) ; xx [ 5 ] = sin ( xx [ 0 ] ) ; xx [ 6 ] = cos ( xx [ 0 ]
) ; xx [ 7 ] = xx [ 1 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 8 ] = xx [ 3 ] / xx [ 2
] * xx [ 5 ] ; xx [ 9 ] = xx [ 4 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 0 ] = state [
7 ] ; xx [ 1 ] = state [ 8 ] ; xx [ 2 ] = state [ 9 ] ; xx [ 3 ] = state [ 10
] ; pm_math_quatCompose ( xx + 6 , xx + 0 , xx + 10 ) ; state [ 7 ] = xx [ 10
] ; state [ 8 ] = xx [ 11 ] ; state [ 9 ] = xx [ 12 ] ; state [ 10 ] = xx [
13 ] ; } static void perturbJointPrimitiveState_1_0v ( double mag , double *
state ) { double xx [ 14 ] ; xx [ 0 ] = 0.5 * mag ; xx [ 1 ] = fabs ( mag ) ;
xx [ 2 ] = 1.0 / ( xx [ 1 ] - floor ( xx [ 1 ] ) + 1.0e-9 ) ; xx [ 1 ] = sin
( xx [ 2 ] ) ; xx [ 3 ] = cos ( xx [ 2 ] ) ; xx [ 4 ] = sin ( 2.0 * xx [ 2 ]
) ; xx [ 2 ] = sqrt ( xx [ 1 ] * xx [ 1 ] + xx [ 3 ] * xx [ 3 ] + xx [ 4 ] *
xx [ 4 ] ) ; xx [ 5 ] = sin ( xx [ 0 ] ) ; xx [ 6 ] = cos ( xx [ 0 ] ) ; xx [
7 ] = xx [ 1 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 8 ] = xx [ 3 ] / xx [ 2 ] * xx [
5 ] ; xx [ 9 ] = xx [ 4 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 1 ] = state [ 7 ] ; xx
[ 2 ] = state [ 8 ] ; xx [ 3 ] = state [ 9 ] ; xx [ 4 ] = state [ 10 ] ;
pm_math_quatCompose ( xx + 6 , xx + 1 , xx + 10 ) ; state [ 7 ] = xx [ 10 ] ;
state [ 8 ] = xx [ 11 ] ; state [ 9 ] = xx [ 12 ] ; state [ 10 ] = xx [ 13 ]
; state [ 11 ] = state [ 11 ] + 1.2 * mag ; state [ 12 ] = state [ 12 ] - xx
[ 0 ] ; state [ 13 ] = state [ 13 ] + 0.9 * mag ; } static void
perturbJointPrimitiveState_2_0 ( double mag , double * state ) { double xx [
14 ] ; xx [ 0 ] = 0.5 * mag ; xx [ 1 ] = fabs ( mag ) ; xx [ 2 ] = 1.0 / ( xx
[ 1 ] - floor ( xx [ 1 ] ) + 1.0e-9 ) ; xx [ 1 ] = sin ( xx [ 2 ] ) ; xx [ 3
] = cos ( xx [ 2 ] ) ; xx [ 4 ] = sin ( 2.0 * xx [ 2 ] ) ; xx [ 2 ] = sqrt (
xx [ 1 ] * xx [ 1 ] + xx [ 3 ] * xx [ 3 ] + xx [ 4 ] * xx [ 4 ] ) ; xx [ 5 ]
= sin ( xx [ 0 ] ) ; xx [ 6 ] = cos ( xx [ 0 ] ) ; xx [ 7 ] = xx [ 1 ] / xx [
2 ] * xx [ 5 ] ; xx [ 8 ] = xx [ 3 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 9 ] = xx [
4 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 0 ] = state [ 14 ] ; xx [ 1 ] = state [ 15 ]
; xx [ 2 ] = state [ 16 ] ; xx [ 3 ] = state [ 17 ] ; pm_math_quatCompose (
xx + 6 , xx + 0 , xx + 10 ) ; state [ 14 ] = xx [ 10 ] ; state [ 15 ] = xx [
11 ] ; state [ 16 ] = xx [ 12 ] ; state [ 17 ] = xx [ 13 ] ; } static void
perturbJointPrimitiveState_2_0v ( double mag , double * state ) { double xx [
14 ] ; xx [ 0 ] = 0.5 * mag ; xx [ 1 ] = fabs ( mag ) ; xx [ 2 ] = 1.0 / ( xx
[ 1 ] - floor ( xx [ 1 ] ) + 1.0e-9 ) ; xx [ 1 ] = sin ( xx [ 2 ] ) ; xx [ 3
] = cos ( xx [ 2 ] ) ; xx [ 4 ] = sin ( 2.0 * xx [ 2 ] ) ; xx [ 2 ] = sqrt (
xx [ 1 ] * xx [ 1 ] + xx [ 3 ] * xx [ 3 ] + xx [ 4 ] * xx [ 4 ] ) ; xx [ 5 ]
= sin ( xx [ 0 ] ) ; xx [ 6 ] = cos ( xx [ 0 ] ) ; xx [ 7 ] = xx [ 1 ] / xx [
2 ] * xx [ 5 ] ; xx [ 8 ] = xx [ 3 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 9 ] = xx [
4 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 1 ] = state [ 14 ] ; xx [ 2 ] = state [ 15 ]
; xx [ 3 ] = state [ 16 ] ; xx [ 4 ] = state [ 17 ] ; pm_math_quatCompose (
xx + 6 , xx + 1 , xx + 10 ) ; state [ 14 ] = xx [ 10 ] ; state [ 15 ] = xx [
11 ] ; state [ 16 ] = xx [ 12 ] ; state [ 17 ] = xx [ 13 ] ; state [ 18 ] =
state [ 18 ] + 1.2 * mag ; state [ 19 ] = state [ 19 ] - xx [ 0 ] ; state [
20 ] = state [ 20 ] + 0.9 * mag ; } static void
perturbJointPrimitiveState_3_0 ( double mag , double * state ) { double xx [
14 ] ; xx [ 0 ] = 0.5 * mag ; xx [ 1 ] = fabs ( mag ) ; xx [ 2 ] = 1.0 / ( xx
[ 1 ] - floor ( xx [ 1 ] ) + 1.0e-9 ) ; xx [ 1 ] = sin ( xx [ 2 ] ) ; xx [ 3
] = cos ( xx [ 2 ] ) ; xx [ 4 ] = sin ( 2.0 * xx [ 2 ] ) ; xx [ 2 ] = sqrt (
xx [ 1 ] * xx [ 1 ] + xx [ 3 ] * xx [ 3 ] + xx [ 4 ] * xx [ 4 ] ) ; xx [ 5 ]
= sin ( xx [ 0 ] ) ; xx [ 6 ] = cos ( xx [ 0 ] ) ; xx [ 7 ] = xx [ 1 ] / xx [
2 ] * xx [ 5 ] ; xx [ 8 ] = xx [ 3 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 9 ] = xx [
4 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 0 ] = state [ 21 ] ; xx [ 1 ] = state [ 22 ]
; xx [ 2 ] = state [ 23 ] ; xx [ 3 ] = state [ 24 ] ; pm_math_quatCompose (
xx + 6 , xx + 0 , xx + 10 ) ; state [ 21 ] = xx [ 10 ] ; state [ 22 ] = xx [
11 ] ; state [ 23 ] = xx [ 12 ] ; state [ 24 ] = xx [ 13 ] ; } static void
perturbJointPrimitiveState_3_0v ( double mag , double * state ) { double xx [
14 ] ; xx [ 0 ] = 0.5 * mag ; xx [ 1 ] = fabs ( mag ) ; xx [ 2 ] = 1.0 / ( xx
[ 1 ] - floor ( xx [ 1 ] ) + 1.0e-9 ) ; xx [ 1 ] = sin ( xx [ 2 ] ) ; xx [ 3
] = cos ( xx [ 2 ] ) ; xx [ 4 ] = sin ( 2.0 * xx [ 2 ] ) ; xx [ 2 ] = sqrt (
xx [ 1 ] * xx [ 1 ] + xx [ 3 ] * xx [ 3 ] + xx [ 4 ] * xx [ 4 ] ) ; xx [ 5 ]
= sin ( xx [ 0 ] ) ; xx [ 6 ] = cos ( xx [ 0 ] ) ; xx [ 7 ] = xx [ 1 ] / xx [
2 ] * xx [ 5 ] ; xx [ 8 ] = xx [ 3 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 9 ] = xx [
4 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 1 ] = state [ 21 ] ; xx [ 2 ] = state [ 22 ]
; xx [ 3 ] = state [ 23 ] ; xx [ 4 ] = state [ 24 ] ; pm_math_quatCompose (
xx + 6 , xx + 1 , xx + 10 ) ; state [ 21 ] = xx [ 10 ] ; state [ 22 ] = xx [
11 ] ; state [ 23 ] = xx [ 12 ] ; state [ 24 ] = xx [ 13 ] ; state [ 25 ] =
state [ 25 ] + 1.2 * mag ; state [ 26 ] = state [ 26 ] - xx [ 0 ] ; state [
27 ] = state [ 27 ] + 0.9 * mag ; } static void
perturbJointPrimitiveState_4_0 ( double mag , double * state ) { double xx [
14 ] ; xx [ 0 ] = 0.5 * mag ; xx [ 1 ] = fabs ( mag ) ; xx [ 2 ] = 1.0 / ( xx
[ 1 ] - floor ( xx [ 1 ] ) + 1.0e-9 ) ; xx [ 1 ] = sin ( xx [ 2 ] ) ; xx [ 3
] = cos ( xx [ 2 ] ) ; xx [ 4 ] = sin ( 2.0 * xx [ 2 ] ) ; xx [ 2 ] = sqrt (
xx [ 1 ] * xx [ 1 ] + xx [ 3 ] * xx [ 3 ] + xx [ 4 ] * xx [ 4 ] ) ; xx [ 5 ]
= sin ( xx [ 0 ] ) ; xx [ 6 ] = cos ( xx [ 0 ] ) ; xx [ 7 ] = xx [ 1 ] / xx [
2 ] * xx [ 5 ] ; xx [ 8 ] = xx [ 3 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 9 ] = xx [
4 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 0 ] = state [ 28 ] ; xx [ 1 ] = state [ 29 ]
; xx [ 2 ] = state [ 30 ] ; xx [ 3 ] = state [ 31 ] ; pm_math_quatCompose (
xx + 6 , xx + 0 , xx + 10 ) ; state [ 28 ] = xx [ 10 ] ; state [ 29 ] = xx [
11 ] ; state [ 30 ] = xx [ 12 ] ; state [ 31 ] = xx [ 13 ] ; } static void
perturbJointPrimitiveState_4_0v ( double mag , double * state ) { double xx [
14 ] ; xx [ 0 ] = 0.5 * mag ; xx [ 1 ] = fabs ( mag ) ; xx [ 2 ] = 1.0 / ( xx
[ 1 ] - floor ( xx [ 1 ] ) + 1.0e-9 ) ; xx [ 1 ] = sin ( xx [ 2 ] ) ; xx [ 3
] = cos ( xx [ 2 ] ) ; xx [ 4 ] = sin ( 2.0 * xx [ 2 ] ) ; xx [ 2 ] = sqrt (
xx [ 1 ] * xx [ 1 ] + xx [ 3 ] * xx [ 3 ] + xx [ 4 ] * xx [ 4 ] ) ; xx [ 5 ]
= sin ( xx [ 0 ] ) ; xx [ 6 ] = cos ( xx [ 0 ] ) ; xx [ 7 ] = xx [ 1 ] / xx [
2 ] * xx [ 5 ] ; xx [ 8 ] = xx [ 3 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 9 ] = xx [
4 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 1 ] = state [ 28 ] ; xx [ 2 ] = state [ 29 ]
; xx [ 3 ] = state [ 30 ] ; xx [ 4 ] = state [ 31 ] ; pm_math_quatCompose (
xx + 6 , xx + 1 , xx + 10 ) ; state [ 28 ] = xx [ 10 ] ; state [ 29 ] = xx [
11 ] ; state [ 30 ] = xx [ 12 ] ; state [ 31 ] = xx [ 13 ] ; state [ 32 ] =
state [ 32 ] + 1.2 * mag ; state [ 33 ] = state [ 33 ] - xx [ 0 ] ; state [
34 ] = state [ 34 ] + 0.9 * mag ; } static void
perturbJointPrimitiveState_5_0 ( double mag , double * state ) { state [ 35 ]
= state [ 35 ] + mag ; } static void perturbJointPrimitiveState_5_0v ( double
mag , double * state ) { state [ 35 ] = state [ 35 ] + mag ; state [ 38 ] =
state [ 38 ] - 0.875 * mag ; } static void perturbJointPrimitiveState_5_1 (
double mag , double * state ) { state [ 36 ] = state [ 36 ] + mag ; } static
void perturbJointPrimitiveState_5_1v ( double mag , double * state ) { state
[ 36 ] = state [ 36 ] + mag ; state [ 39 ] = state [ 39 ] - 0.875 * mag ; }
static void perturbJointPrimitiveState_5_2 ( double mag , double * state ) {
state [ 37 ] = state [ 37 ] + mag ; } static void
perturbJointPrimitiveState_5_2v ( double mag , double * state ) { state [ 37
] = state [ 37 ] + mag ; state [ 40 ] = state [ 40 ] - 0.875 * mag ; } static
void perturbJointPrimitiveState_6_0 ( double mag , double * state ) { double
xx [ 14 ] ; xx [ 0 ] = 0.5 * mag ; xx [ 1 ] = fabs ( mag ) ; xx [ 2 ] = 1.0 /
( xx [ 1 ] - floor ( xx [ 1 ] ) + 1.0e-9 ) ; xx [ 1 ] = sin ( xx [ 2 ] ) ; xx
[ 3 ] = cos ( xx [ 2 ] ) ; xx [ 4 ] = sin ( 2.0 * xx [ 2 ] ) ; xx [ 2 ] =
sqrt ( xx [ 1 ] * xx [ 1 ] + xx [ 3 ] * xx [ 3 ] + xx [ 4 ] * xx [ 4 ] ) ; xx
[ 5 ] = sin ( xx [ 0 ] ) ; xx [ 6 ] = cos ( xx [ 0 ] ) ; xx [ 7 ] = xx [ 1 ]
/ xx [ 2 ] * xx [ 5 ] ; xx [ 8 ] = xx [ 3 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 9 ]
= xx [ 4 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 0 ] = state [ 41 ] ; xx [ 1 ] = state
[ 42 ] ; xx [ 2 ] = state [ 43 ] ; xx [ 3 ] = state [ 44 ] ;
pm_math_quatCompose ( xx + 6 , xx + 0 , xx + 10 ) ; state [ 41 ] = xx [ 10 ]
; state [ 42 ] = xx [ 11 ] ; state [ 43 ] = xx [ 12 ] ; state [ 44 ] = xx [
13 ] ; } static void perturbJointPrimitiveState_6_0v ( double mag , double *
state ) { double xx [ 14 ] ; xx [ 0 ] = 0.5 * mag ; xx [ 1 ] = fabs ( mag ) ;
xx [ 2 ] = 1.0 / ( xx [ 1 ] - floor ( xx [ 1 ] ) + 1.0e-9 ) ; xx [ 1 ] = sin
( xx [ 2 ] ) ; xx [ 3 ] = cos ( xx [ 2 ] ) ; xx [ 4 ] = sin ( 2.0 * xx [ 2 ]
) ; xx [ 2 ] = sqrt ( xx [ 1 ] * xx [ 1 ] + xx [ 3 ] * xx [ 3 ] + xx [ 4 ] *
xx [ 4 ] ) ; xx [ 5 ] = sin ( xx [ 0 ] ) ; xx [ 6 ] = cos ( xx [ 0 ] ) ; xx [
7 ] = xx [ 1 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 8 ] = xx [ 3 ] / xx [ 2 ] * xx [
5 ] ; xx [ 9 ] = xx [ 4 ] / xx [ 2 ] * xx [ 5 ] ; xx [ 1 ] = state [ 41 ] ;
xx [ 2 ] = state [ 42 ] ; xx [ 3 ] = state [ 43 ] ; xx [ 4 ] = state [ 44 ] ;
pm_math_quatCompose ( xx + 6 , xx + 1 , xx + 10 ) ; state [ 41 ] = xx [ 10 ]
; state [ 42 ] = xx [ 11 ] ; state [ 43 ] = xx [ 12 ] ; state [ 44 ] = xx [
13 ] ; state [ 45 ] = state [ 45 ] + 1.2 * mag ; state [ 46 ] = state [ 46 ]
- xx [ 0 ] ; state [ 47 ] = state [ 47 ] + 0.9 * mag ; } void
Kinematics_Model_2b2b31c2_1_perturbJointPrimitiveState ( const void * mech ,
size_t stageIdx , size_t primIdx , double mag , boolean_T doPerturbVelocity ,
double * state ) { ( void ) mech ; ( void ) stageIdx ; ( void ) primIdx ; (
void ) mag ; ( void ) doPerturbVelocity ; ( void ) state ; switch ( (
stageIdx * 6 + primIdx ) * 2 + ( doPerturbVelocity ? 1 : 0 ) ) { case 0 :
perturbJointPrimitiveState_0_0 ( mag , state ) ; break ; case 1 :
perturbJointPrimitiveState_0_0v ( mag , state ) ; break ; case 12 :
perturbJointPrimitiveState_1_0 ( mag , state ) ; break ; case 13 :
perturbJointPrimitiveState_1_0v ( mag , state ) ; break ; case 24 :
perturbJointPrimitiveState_2_0 ( mag , state ) ; break ; case 25 :
perturbJointPrimitiveState_2_0v ( mag , state ) ; break ; case 36 :
perturbJointPrimitiveState_3_0 ( mag , state ) ; break ; case 37 :
perturbJointPrimitiveState_3_0v ( mag , state ) ; break ; case 48 :
perturbJointPrimitiveState_4_0 ( mag , state ) ; break ; case 49 :
perturbJointPrimitiveState_4_0v ( mag , state ) ; break ; case 60 :
perturbJointPrimitiveState_5_0 ( mag , state ) ; break ; case 61 :
perturbJointPrimitiveState_5_0v ( mag , state ) ; break ; case 62 :
perturbJointPrimitiveState_5_1 ( mag , state ) ; break ; case 63 :
perturbJointPrimitiveState_5_1v ( mag , state ) ; break ; case 64 :
perturbJointPrimitiveState_5_2 ( mag , state ) ; break ; case 65 :
perturbJointPrimitiveState_5_2v ( mag , state ) ; break ; case 72 :
perturbJointPrimitiveState_6_0 ( mag , state ) ; break ; case 73 :
perturbJointPrimitiveState_6_0v ( mag , state ) ; break ; } } void
Kinematics_Model_2b2b31c2_1_perturbFlexibleBodyState ( const void * mech ,
size_t stageIdx , double mag , boolean_T doPerturbVelocity , double * state )
{ ( void ) mech ; ( void ) stageIdx ; ( void ) mag ; ( void )
doPerturbVelocity ; ( void ) state ; switch ( stageIdx * 2 + (
doPerturbVelocity ? 1 : 0 ) ) { } } void
Kinematics_Model_2b2b31c2_1_computeDofBlendMatrix ( const void * mech ,
size_t stageIdx , size_t primIdx , const double * state , int partialType ,
double * matrix ) { ( void ) mech ; ( void ) stageIdx ; ( void ) primIdx ; (
void ) state ; ( void ) partialType ; ( void ) matrix ; switch ( ( stageIdx *
6 + primIdx ) ) { } } void
Kinematics_Model_2b2b31c2_1_projectPartiallyTargetedPos ( const void * mech ,
size_t stageIdx , size_t primIdx , const double * origState , int partialType
, double * state ) { ( void ) mech ; ( void ) stageIdx ; ( void ) primIdx ; (
void ) origState ; ( void ) partialType ; ( void ) state ; switch ( (
stageIdx * 6 + primIdx ) ) { } } void
Kinematics_Model_2b2b31c2_1_propagateMotion ( const void * mech , const
double * rtdv , const double * state , double * motionData ) { double xx [ 33
] ; ( void ) mech ; ( void ) rtdv ; xx [ 0 ] = 0.1761018998335906 ; xx [ 1 ]
= xx [ 0 ] * state [ 2 ] ; xx [ 2 ] = xx [ 0 ] * state [ 3 ] ; xx [ 3 ] = 2.0
; xx [ 4 ] = 0.1675024183407511 ; xx [ 5 ] = xx [ 4 ] * state [ 9 ] ; xx [ 6
] = xx [ 4 ] * state [ 10 ] ; xx [ 7 ] = 0.1624769242846504 ; xx [ 8 ] = xx [
7 ] * state [ 16 ] ; xx [ 9 ] = xx [ 7 ] * state [ 17 ] ; xx [ 10 ] =
0.1774935228395673 ; xx [ 11 ] = xx [ 10 ] * state [ 23 ] ; xx [ 12 ] = xx [
10 ] * state [ 24 ] ; xx [ 13 ] = 0.1575773583037868 ; xx [ 14 ] = xx [ 13 ]
* state [ 30 ] ; xx [ 15 ] = xx [ 13 ] * state [ 31 ] ; xx [ 16 ] = 0.0 ; xx
[ 17 ] = 0.23241 ; xx [ 18 ] = xx [ 17 ] * state [ 43 ] ; xx [ 19 ] = xx [ 17
] * state [ 42 ] ; xx [ 20 ] = ( xx [ 18 ] * state [ 41 ] + xx [ 19 ] * state
[ 44 ] ) * xx [ 3 ] ; xx [ 21 ] = xx [ 3 ] * ( xx [ 18 ] * state [ 44 ] - xx
[ 19 ] * state [ 41 ] ) ; xx [ 22 ] = ( xx [ 19 ] * state [ 42 ] + xx [ 18 ]
* state [ 43 ] ) * xx [ 3 ] ; xx [ 23 ] = state [ 41 ] ; xx [ 24 ] = state [
42 ] ; xx [ 25 ] = state [ 43 ] ; xx [ 26 ] = state [ 44 ] ; xx [ 27 ] =
state [ 38 ] ; xx [ 28 ] = state [ 39 ] ; xx [ 29 ] = state [ 40 ] ;
pm_math_quatInverseXform ( xx + 23 , xx + 27 , xx + 30 ) ; motionData [ 0 ] =
- state [ 0 ] ; motionData [ 1 ] = - state [ 1 ] ; motionData [ 2 ] = - state
[ 2 ] ; motionData [ 3 ] = - state [ 3 ] ; motionData [ 4 ] =
0.3530818998335906 - ( xx [ 1 ] * state [ 2 ] + xx [ 2 ] * state [ 3 ] ) * xx
[ 3 ] ; motionData [ 5 ] = 0.2523 + ( xx [ 2 ] * state [ 0 ] + xx [ 1 ] *
state [ 1 ] ) * xx [ 3 ] ; motionData [ 6 ] = 0.12489 + xx [ 3 ] * ( xx [ 2 ]
* state [ 1 ] - xx [ 1 ] * state [ 0 ] ) ; motionData [ 7 ] = - state [ 7 ] ;
motionData [ 8 ] = - state [ 8 ] ; motionData [ 9 ] = - state [ 9 ] ;
motionData [ 10 ] = - state [ 10 ] ; motionData [ 11 ] = - (
7.617581659248862e-3 + ( xx [ 5 ] * state [ 9 ] + xx [ 6 ] * state [ 10 ] ) *
xx [ 3 ] ) ; motionData [ 12 ] = 0.28187 + ( xx [ 6 ] * state [ 7 ] + xx [ 5
] * state [ 8 ] ) * xx [ 3 ] ; motionData [ 13 ] = 0.12641 + xx [ 3 ] * ( xx
[ 6 ] * state [ 8 ] - xx [ 5 ] * state [ 7 ] ) ; motionData [ 14 ] = - state
[ 14 ] ; motionData [ 15 ] = - state [ 15 ] ; motionData [ 16 ] = - state [
16 ] ; motionData [ 17 ] = - state [ 17 ] ; motionData [ 18 ] =
0.2383669242846503 - ( xx [ 8 ] * state [ 16 ] + xx [ 9 ] * state [ 17 ] ) *
xx [ 3 ] ; motionData [ 19 ] = 0.23 + ( xx [ 9 ] * state [ 14 ] + xx [ 8 ] *
state [ 15 ] ) * xx [ 3 ] ; motionData [ 20 ] = 0.201 + xx [ 3 ] * ( xx [ 9 ]
* state [ 15 ] - xx [ 8 ] * state [ 14 ] ) ; motionData [ 21 ] = - state [ 21
] ; motionData [ 22 ] = - state [ 22 ] ; motionData [ 23 ] = - state [ 23 ] ;
motionData [ 24 ] = - state [ 24 ] ; motionData [ 25 ] = 0.3560035228395673 -
( xx [ 11 ] * state [ 23 ] + xx [ 12 ] * state [ 24 ] ) * xx [ 3 ] ;
motionData [ 26 ] = 0.25087 + ( xx [ 12 ] * state [ 21 ] + xx [ 11 ] * state
[ 22 ] ) * xx [ 3 ] ; motionData [ 27 ] = 0.28196 + xx [ 3 ] * ( xx [ 12 ] *
state [ 22 ] - xx [ 11 ] * state [ 21 ] ) ; motionData [ 28 ] = - state [ 28
] ; motionData [ 29 ] = - state [ 29 ] ; motionData [ 30 ] = - state [ 30 ] ;
motionData [ 31 ] = - state [ 31 ] ; motionData [ 32 ] = - (
0.02016264169621323 + ( xx [ 14 ] * state [ 30 ] + xx [ 15 ] * state [ 31 ] )
* xx [ 3 ] ) ; motionData [ 33 ] = 0.28138 + ( xx [ 15 ] * state [ 28 ] + xx
[ 14 ] * state [ 29 ] ) * xx [ 3 ] ; motionData [ 34 ] = 0.26458 + xx [ 3 ] *
( xx [ 15 ] * state [ 29 ] - xx [ 14 ] * state [ 28 ] ) ; motionData [ 35 ] =
- 1.0 ; motionData [ 36 ] = xx [ 16 ] ; motionData [ 37 ] = xx [ 16 ] ;
motionData [ 38 ] = xx [ 16 ] ; motionData [ 39 ] = state [ 35 ] ; motionData
[ 40 ] = state [ 36 ] ; motionData [ 41 ] = state [ 37 ] ; motionData [ 42 ]
= state [ 41 ] ; motionData [ 43 ] = state [ 42 ] ; motionData [ 44 ] = state
[ 43 ] ; motionData [ 45 ] = state [ 44 ] ; motionData [ 46 ] = xx [ 20 ] ;
motionData [ 47 ] = xx [ 21 ] ; motionData [ 48 ] = xx [ 17 ] - xx [ 22 ] ;
motionData [ 49 ] = - state [ 41 ] ; motionData [ 50 ] = - state [ 42 ] ;
motionData [ 51 ] = - state [ 43 ] ; motionData [ 52 ] = - state [ 44 ] ;
motionData [ 53 ] = xx [ 20 ] + state [ 35 ] ; motionData [ 54 ] = xx [ 21 ]
+ state [ 36 ] ; motionData [ 55 ] = state [ 37 ] - xx [ 22 ] + xx [ 17 ] ;
motionData [ 56 ] = state [ 4 ] ; motionData [ 57 ] = state [ 5 ] ;
motionData [ 58 ] = state [ 6 ] ; motionData [ 59 ] = xx [ 16 ] ; motionData
[ 60 ] = xx [ 0 ] * state [ 6 ] ; motionData [ 61 ] = - ( xx [ 0 ] * state [
5 ] ) ; motionData [ 62 ] = state [ 11 ] ; motionData [ 63 ] = state [ 12 ] ;
motionData [ 64 ] = state [ 13 ] ; motionData [ 65 ] = xx [ 16 ] ; motionData
[ 66 ] = xx [ 4 ] * state [ 13 ] ; motionData [ 67 ] = - ( xx [ 4 ] * state [
12 ] ) ; motionData [ 68 ] = state [ 18 ] ; motionData [ 69 ] = state [ 19 ]
; motionData [ 70 ] = state [ 20 ] ; motionData [ 71 ] = xx [ 16 ] ;
motionData [ 72 ] = xx [ 7 ] * state [ 20 ] ; motionData [ 73 ] = - ( xx [ 7
] * state [ 19 ] ) ; motionData [ 74 ] = state [ 25 ] ; motionData [ 75 ] =
state [ 26 ] ; motionData [ 76 ] = state [ 27 ] ; motionData [ 77 ] = xx [ 16
] ; motionData [ 78 ] = xx [ 10 ] * state [ 27 ] ; motionData [ 79 ] = - ( xx
[ 10 ] * state [ 26 ] ) ; motionData [ 80 ] = state [ 32 ] ; motionData [ 81
] = state [ 33 ] ; motionData [ 82 ] = state [ 34 ] ; motionData [ 83 ] = xx
[ 16 ] ; motionData [ 84 ] = xx [ 13 ] * state [ 34 ] ; motionData [ 85 ] = -
( xx [ 13 ] * state [ 33 ] ) ; motionData [ 86 ] = xx [ 16 ] ; motionData [
87 ] = xx [ 16 ] ; motionData [ 88 ] = xx [ 16 ] ; motionData [ 89 ] = state
[ 38 ] ; motionData [ 90 ] = state [ 39 ] ; motionData [ 91 ] = state [ 40 ]
; motionData [ 92 ] = state [ 45 ] ; motionData [ 93 ] = state [ 46 ] ;
motionData [ 94 ] = state [ 47 ] ; motionData [ 95 ] = xx [ 30 ] + xx [ 17 ]
* state [ 46 ] ; motionData [ 96 ] = xx [ 31 ] - xx [ 17 ] * state [ 45 ] ;
motionData [ 97 ] = xx [ 32 ] ; } static size_t computeAssemblyError_0 (
const double * rtdv , const double * state , const double * motionData ,
double * error ) { double xx [ 10 ] ; ( void ) rtdv ; ( void ) state ; xx [ 0
] = motionData [ 49 ] ; xx [ 1 ] = motionData [ 50 ] ; xx [ 2 ] = motionData
[ 51 ] ; xx [ 3 ] = motionData [ 52 ] ; xx [ 4 ] = 8.93e-3 ; xx [ 5 ] = -
0.03858000000000004 ; xx [ 6 ] = - 0.09166000000000001 ; pm_math_quatXform (
xx + 0 , xx + 4 , xx + 7 ) ; xx [ 0 ] = 0.1761018998335906 ; xx [ 1 ] = xx [
0 ] * motionData [ 2 ] ; xx [ 2 ] = xx [ 0 ] * motionData [ 3 ] ; xx [ 3 ] =
2.0 ; error [ 0 ] = xx [ 7 ] + motionData [ 53 ] - ( motionData [ 4 ] - ( xx
[ 1 ] * motionData [ 2 ] + xx [ 2 ] * motionData [ 3 ] ) * xx [ 3 ] ) - xx [
0 ] ; error [ 1 ] = xx [ 8 ] + motionData [ 54 ] - ( ( xx [ 2 ] * motionData
[ 0 ] + xx [ 1 ] * motionData [ 1 ] ) * xx [ 3 ] + motionData [ 5 ] ) ; error
[ 2 ] = xx [ 9 ] + motionData [ 55 ] - ( xx [ 3 ] * ( xx [ 2 ] * motionData [
1 ] - xx [ 1 ] * motionData [ 0 ] ) + motionData [ 6 ] ) ; return 3 ; }
static size_t computeAssemblyError_1 ( const double * rtdv , const double *
state , const double * motionData , double * error ) { double xx [ 10 ] ; (
void ) rtdv ; ( void ) state ; xx [ 0 ] = motionData [ 49 ] ; xx [ 1 ] =
motionData [ 50 ] ; xx [ 2 ] = motionData [ 51 ] ; xx [ 3 ] = motionData [ 52
] ; xx [ 4 ] = 0.07589 ; xx [ 5 ] = - 0.04750999999999999 ; xx [ 6 ] =
8.530000000000001e-3 ; pm_math_quatXform ( xx + 0 , xx + 4 , xx + 7 ) ; xx [
0 ] = 0.1624769242846504 ; xx [ 1 ] = xx [ 0 ] * motionData [ 16 ] ; xx [ 2 ]
= xx [ 0 ] * motionData [ 17 ] ; xx [ 3 ] = 2.0 ; error [ 0 ] = xx [ 7 ] +
motionData [ 53 ] - ( motionData [ 18 ] - ( xx [ 1 ] * motionData [ 16 ] + xx
[ 2 ] * motionData [ 17 ] ) * xx [ 3 ] ) - xx [ 0 ] ; error [ 1 ] = xx [ 8 ]
+ motionData [ 54 ] - ( ( xx [ 2 ] * motionData [ 14 ] + xx [ 1 ] *
motionData [ 15 ] ) * xx [ 3 ] + motionData [ 19 ] ) ; error [ 2 ] = xx [ 9 ]
+ motionData [ 55 ] - ( xx [ 3 ] * ( xx [ 2 ] * motionData [ 15 ] - xx [ 1 ]
* motionData [ 14 ] ) + motionData [ 20 ] ) ; return 3 ; } static size_t
computeAssemblyError_2 ( const double * rtdv , const double * state , const
double * motionData , double * error ) { double xx [ 10 ] ; ( void ) rtdv ; (
void ) state ; xx [ 0 ] = motionData [ 49 ] ; xx [ 1 ] = motionData [ 50 ] ;
xx [ 2 ] = motionData [ 51 ] ; xx [ 3 ] = motionData [ 52 ] ; xx [ 4 ] = -
0.01565 ; xx [ 5 ] = - 0.05489999999999998 ; xx [ 6 ] = 0.09134 ;
pm_math_quatXform ( xx + 0 , xx + 4 , xx + 7 ) ; xx [ 0 ] =
0.1774935228395673 ; xx [ 1 ] = xx [ 0 ] * motionData [ 23 ] ; xx [ 2 ] = xx
[ 0 ] * motionData [ 24 ] ; xx [ 3 ] = 2.0 ; error [ 0 ] = xx [ 7 ] +
motionData [ 53 ] - ( motionData [ 25 ] - ( xx [ 1 ] * motionData [ 23 ] + xx
[ 2 ] * motionData [ 24 ] ) * xx [ 3 ] ) - xx [ 0 ] ; error [ 1 ] = xx [ 8 ]
+ motionData [ 54 ] - ( ( xx [ 2 ] * motionData [ 21 ] + xx [ 1 ] *
motionData [ 22 ] ) * xx [ 3 ] + motionData [ 26 ] ) ; error [ 2 ] = xx [ 9 ]
+ motionData [ 55 ] - ( xx [ 3 ] * ( xx [ 2 ] * motionData [ 22 ] - xx [ 1 ]
* motionData [ 21 ] ) + motionData [ 27 ] ) ; return 3 ; } static size_t
computeAssemblyError_3 ( const double * rtdv , const double * state , const
double * motionData , double * error ) { double xx [ 6 ] ; ( void ) rtdv ; (
void ) state ; xx [ 0 ] = 0.1761018998335906 ; xx [ 1 ] = xx [ 0 ] *
motionData [ 2 ] ; xx [ 2 ] = xx [ 0 ] * motionData [ 3 ] ; xx [ 0 ] = 2.0 ;
xx [ 3 ] = 0.1675024183407511 ; xx [ 4 ] = xx [ 3 ] * motionData [ 9 ] ; xx [
5 ] = xx [ 3 ] * motionData [ 10 ] ; error [ 0 ] = motionData [ 4 ] - ( xx [
1 ] * motionData [ 2 ] + xx [ 2 ] * motionData [ 3 ] ) * xx [ 0 ] - (
motionData [ 11 ] - ( xx [ 4 ] * motionData [ 9 ] + xx [ 5 ] * motionData [
10 ] ) * xx [ 0 ] ) + 8.599481492839511e-3 ; error [ 1 ] = ( xx [ 2 ] *
motionData [ 0 ] + xx [ 1 ] * motionData [ 1 ] ) * xx [ 0 ] + motionData [ 5
] - ( ( xx [ 5 ] * motionData [ 7 ] + xx [ 4 ] * motionData [ 8 ] ) * xx [ 0
] + motionData [ 12 ] ) ; error [ 2 ] = xx [ 0 ] * ( xx [ 2 ] * motionData [
1 ] - xx [ 1 ] * motionData [ 0 ] ) + motionData [ 6 ] - ( xx [ 0 ] * ( xx [
5 ] * motionData [ 8 ] - xx [ 4 ] * motionData [ 7 ] ) + motionData [ 13 ] )
; return 3 ; } static size_t computeAssemblyError_4 ( const double * rtdv ,
const double * state , const double * motionData , double * error ) { double
xx [ 6 ] ; ( void ) rtdv ; ( void ) state ; xx [ 0 ] = 0.1774935228395673 ;
xx [ 1 ] = xx [ 0 ] * motionData [ 23 ] ; xx [ 2 ] = xx [ 0 ] * motionData [
24 ] ; xx [ 0 ] = 2.0 ; xx [ 3 ] = 0.1575773583037868 ; xx [ 4 ] = xx [ 3 ] *
motionData [ 30 ] ; xx [ 5 ] = xx [ 3 ] * motionData [ 31 ] ; error [ 0 ] =
motionData [ 25 ] - ( xx [ 1 ] * motionData [ 23 ] + xx [ 2 ] * motionData [
24 ] ) * xx [ 0 ] - ( motionData [ 32 ] - ( xx [ 4 ] * motionData [ 30 ] + xx
[ 5 ] * motionData [ 31 ] ) * xx [ 0 ] ) + 0.01991616453578055 ; error [ 1 ]
= ( xx [ 2 ] * motionData [ 21 ] + xx [ 1 ] * motionData [ 22 ] ) * xx [ 0 ]
+ motionData [ 26 ] - ( ( xx [ 5 ] * motionData [ 28 ] + xx [ 4 ] *
motionData [ 29 ] ) * xx [ 0 ] + motionData [ 33 ] ) ; error [ 2 ] = xx [ 0 ]
* ( xx [ 2 ] * motionData [ 22 ] - xx [ 1 ] * motionData [ 21 ] ) +
motionData [ 27 ] - ( xx [ 0 ] * ( xx [ 5 ] * motionData [ 29 ] - xx [ 4 ] *
motionData [ 28 ] ) + motionData [ 34 ] ) ; return 3 ; } size_t
Kinematics_Model_2b2b31c2_1_computeAssemblyError ( const void * mech , const
double * rtdv , size_t constraintIdx , const double * state , const double *
motionData , double * error ) { ( void ) mech ; ( void ) rtdv ; ( void )
state ; ( void ) motionData ; ( void ) error ; switch ( constraintIdx ) {
case 0 : return computeAssemblyError_0 ( rtdv , state , motionData , error )
; case 1 : return computeAssemblyError_1 ( rtdv , state , motionData , error
) ; case 2 : return computeAssemblyError_2 ( rtdv , state , motionData ,
error ) ; case 3 : return computeAssemblyError_3 ( rtdv , state , motionData
, error ) ; case 4 : return computeAssemblyError_4 ( rtdv , state ,
motionData , error ) ; } return 0 ; } static size_t computeAssemblyJacobian_0
( const double * rtdv , const double * state , const double * motionData ,
double * J ) { double xx [ 46 ] ; ( void ) rtdv ; xx [ 0 ] = 0.0 ; xx [ 1 ] =
0.1761018998335906 ; xx [ 2 ] = xx [ 1 ] * state [ 2 ] ; xx [ 3 ] = xx [ 1 ]
* state [ 1 ] ; xx [ 4 ] = 2.0 ; xx [ 5 ] = ( xx [ 2 ] * state [ 0 ] + xx [ 3
] * state [ 3 ] ) * xx [ 4 ] ; xx [ 6 ] = xx [ 1 ] * state [ 3 ] ; xx [ 1 ] =
xx [ 4 ] * ( xx [ 3 ] * state [ 2 ] - xx [ 6 ] * state [ 0 ] ) ; xx [ 7 ] =
0.0 ; xx [ 8 ] = 1.0 ; xx [ 9 ] = motionData [ 35 ] ; xx [ 10 ] = motionData
[ 36 ] ; xx [ 11 ] = motionData [ 37 ] ; xx [ 12 ] = motionData [ 38 ] ; xx [
13 ] = state [ 41 ] ; xx [ 14 ] = state [ 42 ] ; xx [ 15 ] = state [ 43 ] ;
xx [ 16 ] = state [ 44 ] ; pm_math_quatCompose ( xx + 9 , xx + 13 , xx + 17 )
; xx [ 13 ] = 0.03858000000000004 ; xx [ 14 ] = xx [ 13 ] * xx [ 19 ] ; xx [
15 ] = 0.09166000000000001 ; xx [ 16 ] = xx [ 15 ] * xx [ 20 ] ; xx [ 21 ] =
xx [ 14 ] + xx [ 16 ] ; xx [ 22 ] = xx [ 13 ] * xx [ 18 ] ; xx [ 23 ] = - xx
[ 21 ] ; xx [ 24 ] = xx [ 22 ] ; xx [ 25 ] = xx [ 15 ] * xx [ 18 ] ;
pm_math_cross3 ( xx + 18 , xx + 23 , xx + 26 ) ; xx [ 23 ] = 0.23241 ; xx [
24 ] = xx [ 23 ] * state [ 44 ] ; xx [ 25 ] = xx [ 24 ] * state [ 41 ] ; xx [
29 ] = xx [ 23 ] * state [ 42 ] ; xx [ 30 ] = xx [ 24 ] * state [ 44 ] ; xx [
31 ] = xx [ 4 ] * ( xx [ 25 ] - xx [ 29 ] * state [ 43 ] ) ; xx [ 32 ] = ( xx
[ 30 ] + xx [ 29 ] * state [ 42 ] ) * xx [ 4 ] - xx [ 23 ] ; xx [ 33 ] = - (
( xx [ 29 ] * state [ 41 ] + xx [ 24 ] * state [ 43 ] ) * xx [ 4 ] ) ;
pm_math_quatXform ( xx + 9 , xx + 31 , xx + 34 ) ; xx [ 29 ] = 8.93e-3 ; xx [
31 ] = xx [ 29 ] * xx [ 18 ] ; xx [ 32 ] = xx [ 31 ] - xx [ 16 ] ; xx [ 16 ]
= xx [ 15 ] * xx [ 19 ] ; xx [ 37 ] = - ( xx [ 29 ] * xx [ 19 ] ) ; xx [ 38 ]
= xx [ 32 ] ; xx [ 39 ] = xx [ 16 ] ; pm_math_cross3 ( xx + 18 , xx + 37 , xx
+ 40 ) ; xx [ 33 ] = xx [ 23 ] * state [ 43 ] ; xx [ 37 ] = xx [ 23 ] - ( xx
[ 33 ] * state [ 43 ] + xx [ 30 ] ) * xx [ 4 ] ; xx [ 38 ] = ( xx [ 25 ] + xx
[ 33 ] * state [ 42 ] ) * xx [ 4 ] ; xx [ 39 ] = xx [ 4 ] * ( xx [ 24 ] *
state [ 42 ] - xx [ 33 ] * state [ 41 ] ) ; pm_math_quatXform ( xx + 9 , xx +
37 , xx + 23 ) ; xx [ 9 ] = xx [ 29 ] * xx [ 20 ] ; xx [ 10 ] = xx [ 31 ] -
xx [ 14 ] ; xx [ 37 ] = - xx [ 9 ] ; xx [ 38 ] = xx [ 13 ] * xx [ 20 ] ; xx [
39 ] = xx [ 10 ] ; pm_math_cross3 ( xx + 18 , xx + 37 , xx + 43 ) ; xx [ 11 ]
= xx [ 3 ] * state [ 0 ] ; xx [ 12 ] = xx [ 4 ] * ( xx [ 11 ] - xx [ 2 ] *
state [ 3 ] ) ; xx [ 14 ] = xx [ 3 ] * state [ 1 ] ; xx [ 3 ] = ( xx [ 6 ] *
state [ 3 ] + xx [ 14 ] ) * xx [ 4 ] ; xx [ 30 ] = 0.3522037996671813 ; xx [
31 ] = ( xx [ 14 ] + xx [ 2 ] * state [ 2 ] ) * xx [ 4 ] ; xx [ 2 ] = ( xx [
11 ] + xx [ 6 ] * state [ 2 ] ) * xx [ 4 ] ; J [ 0 ] = xx [ 0 ] ; J [ 1 ] =
xx [ 5 ] + xx [ 5 ] ; J [ 2 ] = - ( xx [ 1 ] + xx [ 1 ] ) ; J [ 15 ] = xx [ 8
] ; J [ 16 ] = xx [ 0 ] ; J [ 17 ] = xx [ 0 ] ; J [ 18 ] = ( xx [ 26 ] - xx [
17 ] * xx [ 21 ] ) * xx [ 4 ] + xx [ 34 ] ; J [ 19 ] = ( xx [ 40 ] - xx [ 29
] * xx [ 17 ] * xx [ 19 ] ) * xx [ 4 ] + xx [ 23 ] - xx [ 15 ] ; J [ 20 ] =
xx [ 13 ] + xx [ 4 ] * ( xx [ 43 ] - xx [ 17 ] * xx [ 9 ] ) ; J [ 21 ] = xx [
0 ] ; J [ 22 ] = - ( xx [ 12 ] + xx [ 12 ] ) ; J [ 23 ] = xx [ 3 ] + xx [ 3 ]
- xx [ 30 ] ; J [ 36 ] = xx [ 0 ] ; J [ 37 ] = xx [ 8 ] ; J [ 38 ] = xx [ 0 ]
; J [ 39 ] = xx [ 4 ] * ( xx [ 27 ] + xx [ 17 ] * xx [ 22 ] ) + xx [ 35 ] +
xx [ 15 ] ; J [ 40 ] = ( xx [ 17 ] * xx [ 32 ] + xx [ 41 ] ) * xx [ 4 ] + xx
[ 24 ] ; J [ 41 ] = xx [ 29 ] + ( xx [ 13 ] * xx [ 17 ] * xx [ 20 ] + xx [ 44
] ) * xx [ 4 ] ; J [ 42 ] = xx [ 0 ] ; J [ 43 ] = xx [ 30 ] - ( xx [ 31 ] +
xx [ 31 ] ) ; J [ 44 ] = - ( xx [ 2 ] + xx [ 2 ] ) ; J [ 57 ] = xx [ 0 ] ; J
[ 58 ] = xx [ 0 ] ; J [ 59 ] = xx [ 8 ] ; J [ 60 ] = ( xx [ 15 ] * xx [ 17 ]
* xx [ 18 ] + xx [ 28 ] ) * xx [ 4 ] + xx [ 36 ] - xx [ 13 ] ; J [ 61 ] = xx
[ 4 ] * ( xx [ 42 ] + xx [ 17 ] * xx [ 16 ] ) + xx [ 25 ] - xx [ 29 ] ; J [
62 ] = ( xx [ 17 ] * xx [ 10 ] + xx [ 45 ] ) * xx [ 4 ] ; return 3 ; } static
size_t computeAssemblyJacobian_1 ( const double * rtdv , const double * state
, const double * motionData , double * J ) { double xx [ 46 ] ; ( void ) rtdv
; xx [ 0 ] = 0.0 ; xx [ 1 ] = 0.0 ; xx [ 2 ] = 0.1624769242846504 ; xx [ 3 ]
= xx [ 2 ] * state [ 16 ] ; xx [ 4 ] = xx [ 2 ] * state [ 15 ] ; xx [ 5 ] =
2.0 ; xx [ 6 ] = ( xx [ 3 ] * state [ 14 ] + xx [ 4 ] * state [ 17 ] ) * xx [
5 ] ; xx [ 7 ] = xx [ 2 ] * state [ 17 ] ; xx [ 2 ] = xx [ 5 ] * ( xx [ 4 ] *
state [ 16 ] - xx [ 7 ] * state [ 14 ] ) ; xx [ 8 ] = 1.0 ; xx [ 9 ] =
motionData [ 35 ] ; xx [ 10 ] = motionData [ 36 ] ; xx [ 11 ] = motionData [
37 ] ; xx [ 12 ] = motionData [ 38 ] ; xx [ 13 ] = state [ 41 ] ; xx [ 14 ] =
state [ 42 ] ; xx [ 15 ] = state [ 43 ] ; xx [ 16 ] = state [ 44 ] ;
pm_math_quatCompose ( xx + 9 , xx + 13 , xx + 17 ) ; xx [ 13 ] =
8.530000000000001e-3 ; xx [ 14 ] = xx [ 13 ] * xx [ 20 ] ; xx [ 15 ] =
0.04750999999999999 ; xx [ 16 ] = xx [ 15 ] * xx [ 19 ] ; xx [ 21 ] = xx [ 14
] - xx [ 16 ] ; xx [ 22 ] = xx [ 15 ] * xx [ 18 ] ; xx [ 23 ] = xx [ 21 ] ;
xx [ 24 ] = xx [ 22 ] ; xx [ 25 ] = - ( xx [ 13 ] * xx [ 18 ] ) ;
pm_math_cross3 ( xx + 18 , xx + 23 , xx + 26 ) ; xx [ 23 ] = 0.23241 ; xx [
24 ] = xx [ 23 ] * state [ 44 ] ; xx [ 25 ] = xx [ 24 ] * state [ 41 ] ; xx [
29 ] = xx [ 23 ] * state [ 42 ] ; xx [ 30 ] = xx [ 24 ] * state [ 44 ] ; xx [
31 ] = xx [ 5 ] * ( xx [ 25 ] - xx [ 29 ] * state [ 43 ] ) ; xx [ 32 ] = ( xx
[ 30 ] + xx [ 29 ] * state [ 42 ] ) * xx [ 5 ] - xx [ 23 ] ; xx [ 33 ] = - (
( xx [ 29 ] * state [ 41 ] + xx [ 24 ] * state [ 43 ] ) * xx [ 5 ] ) ;
pm_math_quatXform ( xx + 9 , xx + 31 , xx + 34 ) ; xx [ 29 ] = 0.07589 ; xx [
31 ] = xx [ 29 ] * xx [ 18 ] ; xx [ 32 ] = xx [ 14 ] + xx [ 31 ] ; xx [ 14 ]
= xx [ 13 ] * xx [ 19 ] ; xx [ 37 ] = - ( xx [ 29 ] * xx [ 19 ] ) ; xx [ 38 ]
= xx [ 32 ] ; xx [ 39 ] = - xx [ 14 ] ; pm_math_cross3 ( xx + 18 , xx + 37 ,
xx + 40 ) ; xx [ 33 ] = xx [ 23 ] * state [ 43 ] ; xx [ 37 ] = xx [ 23 ] - (
xx [ 33 ] * state [ 43 ] + xx [ 30 ] ) * xx [ 5 ] ; xx [ 38 ] = ( xx [ 25 ] +
xx [ 33 ] * state [ 42 ] ) * xx [ 5 ] ; xx [ 39 ] = xx [ 5 ] * ( xx [ 24 ] *
state [ 42 ] - xx [ 33 ] * state [ 41 ] ) ; pm_math_quatXform ( xx + 9 , xx +
37 , xx + 23 ) ; xx [ 9 ] = xx [ 29 ] * xx [ 20 ] ; xx [ 10 ] = xx [ 31 ] -
xx [ 16 ] ; xx [ 37 ] = - xx [ 9 ] ; xx [ 38 ] = xx [ 15 ] * xx [ 20 ] ; xx [
39 ] = xx [ 10 ] ; pm_math_cross3 ( xx + 18 , xx + 37 , xx + 43 ) ; xx [ 11 ]
= xx [ 4 ] * state [ 14 ] ; xx [ 12 ] = xx [ 5 ] * ( xx [ 11 ] - xx [ 3 ] *
state [ 17 ] ) ; xx [ 16 ] = xx [ 4 ] * state [ 15 ] ; xx [ 4 ] = ( xx [ 7 ]
* state [ 17 ] + xx [ 16 ] ) * xx [ 5 ] ; xx [ 30 ] = 0.3249538485693007 ; xx
[ 31 ] = ( xx [ 16 ] + xx [ 3 ] * state [ 16 ] ) * xx [ 5 ] ; xx [ 3 ] = ( xx
[ 11 ] + xx [ 7 ] * state [ 16 ] ) * xx [ 5 ] ; J [ 6 ] = xx [ 1 ] ; J [ 7 ]
= xx [ 6 ] + xx [ 6 ] ; J [ 8 ] = - ( xx [ 2 ] + xx [ 2 ] ) ; J [ 15 ] = xx [
8 ] ; J [ 16 ] = xx [ 1 ] ; J [ 17 ] = xx [ 1 ] ; J [ 18 ] = ( xx [ 17 ] * xx
[ 21 ] + xx [ 26 ] ) * xx [ 5 ] + xx [ 34 ] ; J [ 19 ] = ( xx [ 40 ] - xx [
29 ] * xx [ 17 ] * xx [ 19 ] ) * xx [ 5 ] + xx [ 23 ] + xx [ 13 ] ; J [ 20 ]
= xx [ 15 ] + xx [ 5 ] * ( xx [ 43 ] - xx [ 17 ] * xx [ 9 ] ) ; J [ 27 ] = xx
[ 1 ] ; J [ 28 ] = - ( xx [ 12 ] + xx [ 12 ] ) ; J [ 29 ] = xx [ 4 ] + xx [ 4
] - xx [ 30 ] ; J [ 36 ] = xx [ 1 ] ; J [ 37 ] = xx [ 8 ] ; J [ 38 ] = xx [ 1
] ; J [ 39 ] = xx [ 5 ] * ( xx [ 27 ] + xx [ 17 ] * xx [ 22 ] ) + xx [ 35 ] -
xx [ 13 ] ; J [ 40 ] = ( xx [ 17 ] * xx [ 32 ] + xx [ 41 ] ) * xx [ 5 ] + xx
[ 24 ] ; J [ 41 ] = xx [ 29 ] + ( xx [ 15 ] * xx [ 17 ] * xx [ 20 ] + xx [ 44
] ) * xx [ 5 ] ; J [ 48 ] = xx [ 1 ] ; J [ 49 ] = xx [ 30 ] - ( xx [ 31 ] +
xx [ 31 ] ) ; J [ 50 ] = - ( xx [ 3 ] + xx [ 3 ] ) ; J [ 57 ] = xx [ 1 ] ; J
[ 58 ] = xx [ 1 ] ; J [ 59 ] = xx [ 8 ] ; J [ 60 ] = ( xx [ 28 ] - xx [ 13 ]
* xx [ 17 ] * xx [ 18 ] ) * xx [ 5 ] + xx [ 36 ] - xx [ 15 ] ; J [ 61 ] = xx
[ 5 ] * ( xx [ 42 ] - xx [ 17 ] * xx [ 14 ] ) + xx [ 25 ] - xx [ 29 ] ; J [
62 ] = ( xx [ 17 ] * xx [ 10 ] + xx [ 45 ] ) * xx [ 5 ] ; return 3 ; } static
size_t computeAssemblyJacobian_2 ( const double * rtdv , const double * state
, const double * motionData , double * J ) { double xx [ 46 ] ; ( void ) rtdv
; xx [ 0 ] = 0.0 ; xx [ 1 ] = 0.0 ; xx [ 2 ] = 0.1774935228395673 ; xx [ 3 ]
= xx [ 2 ] * state [ 23 ] ; xx [ 4 ] = xx [ 2 ] * state [ 22 ] ; xx [ 5 ] =
2.0 ; xx [ 6 ] = ( xx [ 3 ] * state [ 21 ] + xx [ 4 ] * state [ 24 ] ) * xx [
5 ] ; xx [ 7 ] = xx [ 2 ] * state [ 24 ] ; xx [ 2 ] = xx [ 5 ] * ( xx [ 4 ] *
state [ 23 ] - xx [ 7 ] * state [ 21 ] ) ; xx [ 8 ] = 1.0 ; xx [ 9 ] =
motionData [ 35 ] ; xx [ 10 ] = motionData [ 36 ] ; xx [ 11 ] = motionData [
37 ] ; xx [ 12 ] = motionData [ 38 ] ; xx [ 13 ] = state [ 41 ] ; xx [ 14 ] =
state [ 42 ] ; xx [ 15 ] = state [ 43 ] ; xx [ 16 ] = state [ 44 ] ;
pm_math_quatCompose ( xx + 9 , xx + 13 , xx + 17 ) ; xx [ 13 ] = 0.09134 ; xx
[ 14 ] = xx [ 13 ] * xx [ 20 ] ; xx [ 15 ] = 0.05489999999999998 ; xx [ 16 ]
= xx [ 15 ] * xx [ 19 ] ; xx [ 21 ] = xx [ 14 ] - xx [ 16 ] ; xx [ 22 ] = xx
[ 15 ] * xx [ 18 ] ; xx [ 23 ] = xx [ 21 ] ; xx [ 24 ] = xx [ 22 ] ; xx [ 25
] = - ( xx [ 13 ] * xx [ 18 ] ) ; pm_math_cross3 ( xx + 18 , xx + 23 , xx +
26 ) ; xx [ 23 ] = 0.23241 ; xx [ 24 ] = xx [ 23 ] * state [ 44 ] ; xx [ 25 ]
= xx [ 24 ] * state [ 41 ] ; xx [ 29 ] = xx [ 23 ] * state [ 42 ] ; xx [ 30 ]
= xx [ 24 ] * state [ 44 ] ; xx [ 31 ] = xx [ 5 ] * ( xx [ 25 ] - xx [ 29 ] *
state [ 43 ] ) ; xx [ 32 ] = ( xx [ 30 ] + xx [ 29 ] * state [ 42 ] ) * xx [
5 ] - xx [ 23 ] ; xx [ 33 ] = - ( ( xx [ 29 ] * state [ 41 ] + xx [ 24 ] *
state [ 43 ] ) * xx [ 5 ] ) ; pm_math_quatXform ( xx + 9 , xx + 31 , xx + 34
) ; xx [ 29 ] = 0.01565 ; xx [ 31 ] = xx [ 29 ] * xx [ 18 ] ; xx [ 32 ] = xx
[ 14 ] - xx [ 31 ] ; xx [ 14 ] = xx [ 13 ] * xx [ 19 ] ; xx [ 37 ] = xx [ 29
] * xx [ 19 ] ; xx [ 38 ] = xx [ 32 ] ; xx [ 39 ] = - xx [ 14 ] ;
pm_math_cross3 ( xx + 18 , xx + 37 , xx + 40 ) ; xx [ 33 ] = xx [ 23 ] *
state [ 43 ] ; xx [ 37 ] = xx [ 23 ] - ( xx [ 33 ] * state [ 43 ] + xx [ 30 ]
) * xx [ 5 ] ; xx [ 38 ] = ( xx [ 25 ] + xx [ 33 ] * state [ 42 ] ) * xx [ 5
] ; xx [ 39 ] = xx [ 5 ] * ( xx [ 24 ] * state [ 42 ] - xx [ 33 ] * state [
41 ] ) ; pm_math_quatXform ( xx + 9 , xx + 37 , xx + 23 ) ; xx [ 9 ] = xx [
29 ] * xx [ 20 ] ; xx [ 10 ] = xx [ 31 ] + xx [ 16 ] ; xx [ 37 ] = xx [ 9 ] ;
xx [ 38 ] = xx [ 15 ] * xx [ 20 ] ; xx [ 39 ] = - xx [ 10 ] ; pm_math_cross3
( xx + 18 , xx + 37 , xx + 43 ) ; xx [ 11 ] = xx [ 4 ] * state [ 21 ] ; xx [
12 ] = xx [ 5 ] * ( xx [ 11 ] - xx [ 3 ] * state [ 24 ] ) ; xx [ 16 ] = xx [
4 ] * state [ 22 ] ; xx [ 4 ] = ( xx [ 7 ] * state [ 24 ] + xx [ 16 ] ) * xx
[ 5 ] ; xx [ 30 ] = 0.3549870456791346 ; xx [ 31 ] = ( xx [ 16 ] + xx [ 3 ] *
state [ 23 ] ) * xx [ 5 ] ; xx [ 3 ] = ( xx [ 11 ] + xx [ 7 ] * state [ 23 ]
) * xx [ 5 ] ; J [ 9 ] = xx [ 1 ] ; J [ 10 ] = xx [ 6 ] + xx [ 6 ] ; J [ 11 ]
= - ( xx [ 2 ] + xx [ 2 ] ) ; J [ 15 ] = xx [ 8 ] ; J [ 16 ] = xx [ 1 ] ; J [
17 ] = xx [ 1 ] ; J [ 18 ] = ( xx [ 17 ] * xx [ 21 ] + xx [ 26 ] ) * xx [ 5 ]
+ xx [ 34 ] ; J [ 19 ] = ( xx [ 29 ] * xx [ 17 ] * xx [ 19 ] + xx [ 40 ] ) *
xx [ 5 ] + xx [ 23 ] + xx [ 13 ] ; J [ 20 ] = xx [ 15 ] + xx [ 5 ] * ( xx [
43 ] + xx [ 17 ] * xx [ 9 ] ) ; J [ 30 ] = xx [ 1 ] ; J [ 31 ] = - ( xx [ 12
] + xx [ 12 ] ) ; J [ 32 ] = xx [ 4 ] + xx [ 4 ] - xx [ 30 ] ; J [ 36 ] = xx
[ 1 ] ; J [ 37 ] = xx [ 8 ] ; J [ 38 ] = xx [ 1 ] ; J [ 39 ] = xx [ 5 ] * (
xx [ 27 ] + xx [ 17 ] * xx [ 22 ] ) + xx [ 35 ] - xx [ 13 ] ; J [ 40 ] = ( xx
[ 17 ] * xx [ 32 ] + xx [ 41 ] ) * xx [ 5 ] + xx [ 24 ] ; J [ 41 ] = ( xx [
15 ] * xx [ 17 ] * xx [ 20 ] + xx [ 44 ] ) * xx [ 5 ] - xx [ 29 ] ; J [ 51 ]
= xx [ 1 ] ; J [ 52 ] = xx [ 30 ] - ( xx [ 31 ] + xx [ 31 ] ) ; J [ 53 ] = -
( xx [ 3 ] + xx [ 3 ] ) ; J [ 57 ] = xx [ 1 ] ; J [ 58 ] = xx [ 1 ] ; J [ 59
] = xx [ 8 ] ; J [ 60 ] = ( xx [ 28 ] - xx [ 13 ] * xx [ 17 ] * xx [ 18 ] ) *
xx [ 5 ] + xx [ 36 ] - xx [ 15 ] ; J [ 61 ] = xx [ 5 ] * ( xx [ 42 ] - xx [
17 ] * xx [ 14 ] ) + xx [ 25 ] + xx [ 29 ] ; J [ 62 ] = ( xx [ 45 ] - xx [ 17
] * xx [ 10 ] ) * xx [ 5 ] ; return 3 ; } static size_t
computeAssemblyJacobian_3 ( const double * rtdv , const double * state ,
const double * motionData , double * J ) { double xx [ 22 ] ; ( void ) rtdv ;
( void ) motionData ; xx [ 0 ] = 0.0 ; xx [ 1 ] = 0.1761018998335906 ; xx [ 2
] = xx [ 1 ] * state [ 2 ] ; xx [ 3 ] = xx [ 1 ] * state [ 1 ] ; xx [ 4 ] =
2.0 ; xx [ 5 ] = ( xx [ 2 ] * state [ 0 ] + xx [ 3 ] * state [ 3 ] ) * xx [ 4
] ; xx [ 6 ] = xx [ 1 ] * state [ 3 ] ; xx [ 1 ] = xx [ 4 ] * ( xx [ 3 ] *
state [ 2 ] - xx [ 6 ] * state [ 0 ] ) ; xx [ 7 ] = 0.1675024183407511 ; xx [
8 ] = xx [ 7 ] * state [ 9 ] ; xx [ 9 ] = xx [ 7 ] * state [ 8 ] ; xx [ 10 ]
= ( xx [ 8 ] * state [ 7 ] + xx [ 9 ] * state [ 10 ] ) * xx [ 4 ] ; xx [ 11 ]
= xx [ 7 ] * state [ 10 ] ; xx [ 7 ] = xx [ 4 ] * ( xx [ 9 ] * state [ 9 ] -
xx [ 11 ] * state [ 7 ] ) ; xx [ 12 ] = 0.0 ; xx [ 13 ] = xx [ 3 ] * state [
0 ] ; xx [ 14 ] = xx [ 4 ] * ( xx [ 13 ] - xx [ 2 ] * state [ 3 ] ) ; xx [ 15
] = 0.3522037996671813 ; xx [ 16 ] = xx [ 3 ] * state [ 1 ] ; xx [ 3 ] = ( xx
[ 6 ] * state [ 3 ] + xx [ 16 ] ) * xx [ 4 ] ; xx [ 17 ] = xx [ 9 ] * state [
7 ] ; xx [ 18 ] = xx [ 4 ] * ( xx [ 17 ] - xx [ 8 ] * state [ 10 ] ) ; xx [
19 ] = xx [ 9 ] * state [ 8 ] ; xx [ 9 ] = ( xx [ 11 ] * state [ 10 ] + xx [
19 ] ) * xx [ 4 ] ; xx [ 20 ] = 0.3350048366815023 ; xx [ 21 ] = ( xx [ 16 ]
+ xx [ 2 ] * state [ 2 ] ) * xx [ 4 ] ; xx [ 2 ] = ( xx [ 13 ] + xx [ 6 ] *
state [ 2 ] ) * xx [ 4 ] ; xx [ 6 ] = ( xx [ 19 ] + xx [ 8 ] * state [ 9 ] )
* xx [ 4 ] ; xx [ 8 ] = ( xx [ 17 ] + xx [ 11 ] * state [ 9 ] ) * xx [ 4 ] ;
J [ 0 ] = xx [ 0 ] ; J [ 1 ] = - ( xx [ 5 ] + xx [ 5 ] ) ; J [ 2 ] = xx [ 1 ]
+ xx [ 1 ] ; J [ 3 ] = xx [ 0 ] ; J [ 4 ] = xx [ 10 ] + xx [ 10 ] ; J [ 5 ] =
- ( xx [ 7 ] + xx [ 7 ] ) ; J [ 21 ] = xx [ 0 ] ; J [ 22 ] = xx [ 14 ] + xx [
14 ] ; J [ 23 ] = xx [ 15 ] - ( xx [ 3 ] + xx [ 3 ] ) ; J [ 24 ] = xx [ 0 ] ;
J [ 25 ] = - ( xx [ 18 ] + xx [ 18 ] ) ; J [ 26 ] = xx [ 9 ] + xx [ 9 ] - xx
[ 20 ] ; J [ 42 ] = xx [ 0 ] ; J [ 43 ] = xx [ 21 ] + xx [ 21 ] - xx [ 15 ] ;
J [ 44 ] = xx [ 2 ] + xx [ 2 ] ; J [ 45 ] = xx [ 0 ] ; J [ 46 ] = xx [ 20 ] -
( xx [ 6 ] + xx [ 6 ] ) ; J [ 47 ] = - ( xx [ 8 ] + xx [ 8 ] ) ; return 3 ; }
static size_t computeAssemblyJacobian_4 ( const double * rtdv , const double
* state , const double * motionData , double * J ) { double xx [ 22 ] ; (
void ) rtdv ; ( void ) motionData ; xx [ 0 ] = 0.0 ; xx [ 1 ] = 0.0 ; xx [ 2
] = 0.1774935228395673 ; xx [ 3 ] = xx [ 2 ] * state [ 23 ] ; xx [ 4 ] = xx [
2 ] * state [ 22 ] ; xx [ 5 ] = 2.0 ; xx [ 6 ] = ( xx [ 3 ] * state [ 21 ] +
xx [ 4 ] * state [ 24 ] ) * xx [ 5 ] ; xx [ 7 ] = xx [ 2 ] * state [ 24 ] ;
xx [ 2 ] = xx [ 5 ] * ( xx [ 4 ] * state [ 23 ] - xx [ 7 ] * state [ 21 ] ) ;
xx [ 8 ] = 0.1575773583037868 ; xx [ 9 ] = xx [ 8 ] * state [ 30 ] ; xx [ 10
] = xx [ 8 ] * state [ 29 ] ; xx [ 11 ] = ( xx [ 9 ] * state [ 28 ] + xx [ 10
] * state [ 31 ] ) * xx [ 5 ] ; xx [ 12 ] = xx [ 8 ] * state [ 31 ] ; xx [ 8
] = xx [ 5 ] * ( xx [ 10 ] * state [ 30 ] - xx [ 12 ] * state [ 28 ] ) ; xx [
13 ] = xx [ 4 ] * state [ 21 ] ; xx [ 14 ] = xx [ 5 ] * ( xx [ 13 ] - xx [ 3
] * state [ 24 ] ) ; xx [ 15 ] = 0.3549870456791346 ; xx [ 16 ] = xx [ 4 ] *
state [ 22 ] ; xx [ 4 ] = ( xx [ 7 ] * state [ 24 ] + xx [ 16 ] ) * xx [ 5 ]
; xx [ 17 ] = xx [ 10 ] * state [ 28 ] ; xx [ 18 ] = xx [ 5 ] * ( xx [ 17 ] -
xx [ 9 ] * state [ 31 ] ) ; xx [ 19 ] = xx [ 10 ] * state [ 29 ] ; xx [ 10 ]
= ( xx [ 12 ] * state [ 31 ] + xx [ 19 ] ) * xx [ 5 ] ; xx [ 20 ] =
0.3151547166075735 ; xx [ 21 ] = ( xx [ 16 ] + xx [ 3 ] * state [ 23 ] ) * xx
[ 5 ] ; xx [ 3 ] = ( xx [ 13 ] + xx [ 7 ] * state [ 23 ] ) * xx [ 5 ] ; xx [
7 ] = ( xx [ 19 ] + xx [ 9 ] * state [ 30 ] ) * xx [ 5 ] ; xx [ 9 ] = ( xx [
17 ] + xx [ 12 ] * state [ 30 ] ) * xx [ 5 ] ; J [ 9 ] = xx [ 1 ] ; J [ 10 ]
= - ( xx [ 6 ] + xx [ 6 ] ) ; J [ 11 ] = xx [ 2 ] + xx [ 2 ] ; J [ 12 ] = xx
[ 1 ] ; J [ 13 ] = xx [ 11 ] + xx [ 11 ] ; J [ 14 ] = - ( xx [ 8 ] + xx [ 8 ]
) ; J [ 30 ] = xx [ 1 ] ; J [ 31 ] = xx [ 14 ] + xx [ 14 ] ; J [ 32 ] = xx [
15 ] - ( xx [ 4 ] + xx [ 4 ] ) ; J [ 33 ] = xx [ 1 ] ; J [ 34 ] = - ( xx [ 18
] + xx [ 18 ] ) ; J [ 35 ] = xx [ 10 ] + xx [ 10 ] - xx [ 20 ] ; J [ 51 ] =
xx [ 1 ] ; J [ 52 ] = xx [ 21 ] + xx [ 21 ] - xx [ 15 ] ; J [ 53 ] = xx [ 3 ]
+ xx [ 3 ] ; J [ 54 ] = xx [ 1 ] ; J [ 55 ] = xx [ 20 ] - ( xx [ 7 ] + xx [ 7
] ) ; J [ 56 ] = - ( xx [ 9 ] + xx [ 9 ] ) ; return 3 ; } size_t
Kinematics_Model_2b2b31c2_1_computeAssemblyJacobian ( const void * mech ,
const double * rtdv , size_t constraintIdx , boolean_T
forVelocitySatisfaction , const double * state , const double * motionData ,
double * J ) { ( void ) mech ; ( void ) rtdv ; ( void ) state ; ( void )
forVelocitySatisfaction ; ( void ) motionData ; ( void ) J ; switch (
constraintIdx ) { case 0 : return computeAssemblyJacobian_0 ( rtdv , state ,
motionData , J ) ; case 1 : return computeAssemblyJacobian_1 ( rtdv , state ,
motionData , J ) ; case 2 : return computeAssemblyJacobian_2 ( rtdv , state ,
motionData , J ) ; case 3 : return computeAssemblyJacobian_3 ( rtdv , state ,
motionData , J ) ; case 4 : return computeAssemblyJacobian_4 ( rtdv , state ,
motionData , J ) ; } return 0 ; } size_t
Kinematics_Model_2b2b31c2_1_computeFullAssemblyJacobian ( const void * mech ,
const double * rtdv , const double * state , const double * motionData ,
double * J ) { double xx [ 106 ] ; ( void ) mech ; ( void ) rtdv ; xx [ 0 ] =
0.0 ; xx [ 1 ] = 0.1761018998335906 ; xx [ 2 ] = xx [ 1 ] * state [ 2 ] ; xx
[ 3 ] = xx [ 1 ] * state [ 1 ] ; xx [ 4 ] = 2.0 ; xx [ 5 ] = ( xx [ 2 ] *
state [ 0 ] + xx [ 3 ] * state [ 3 ] ) * xx [ 4 ] ; xx [ 6 ] = xx [ 5 ] + xx
[ 5 ] ; xx [ 5 ] = xx [ 1 ] * state [ 3 ] ; xx [ 1 ] = xx [ 4 ] * ( xx [ 3 ]
* state [ 2 ] - xx [ 5 ] * state [ 0 ] ) ; xx [ 7 ] = xx [ 1 ] + xx [ 1 ] ;
xx [ 1 ] = 0.0 ; xx [ 8 ] = 1.0 ; xx [ 9 ] = motionData [ 35 ] ; xx [ 10 ] =
motionData [ 36 ] ; xx [ 11 ] = motionData [ 37 ] ; xx [ 12 ] = motionData [
38 ] ; xx [ 13 ] = state [ 41 ] ; xx [ 14 ] = state [ 42 ] ; xx [ 15 ] =
state [ 43 ] ; xx [ 16 ] = state [ 44 ] ; pm_math_quatCompose ( xx + 9 , xx +
13 , xx + 17 ) ; xx [ 13 ] = 0.03858000000000004 ; xx [ 14 ] = xx [ 13 ] * xx
[ 19 ] ; xx [ 15 ] = 0.09166000000000001 ; xx [ 16 ] = xx [ 15 ] * xx [ 20 ]
; xx [ 21 ] = xx [ 14 ] + xx [ 16 ] ; xx [ 22 ] = xx [ 13 ] * xx [ 18 ] ; xx
[ 23 ] = - xx [ 21 ] ; xx [ 24 ] = xx [ 22 ] ; xx [ 25 ] = xx [ 15 ] * xx [
18 ] ; pm_math_cross3 ( xx + 18 , xx + 23 , xx + 26 ) ; xx [ 23 ] = 0.23241 ;
xx [ 24 ] = xx [ 23 ] * state [ 44 ] ; xx [ 25 ] = xx [ 24 ] * state [ 41 ] ;
xx [ 29 ] = xx [ 23 ] * state [ 42 ] ; xx [ 30 ] = xx [ 24 ] * state [ 44 ] ;
xx [ 31 ] = xx [ 4 ] * ( xx [ 25 ] - xx [ 29 ] * state [ 43 ] ) ; xx [ 32 ] =
( xx [ 30 ] + xx [ 29 ] * state [ 42 ] ) * xx [ 4 ] - xx [ 23 ] ; xx [ 33 ] =
- ( ( xx [ 29 ] * state [ 41 ] + xx [ 24 ] * state [ 43 ] ) * xx [ 4 ] ) ;
pm_math_quatXform ( xx + 9 , xx + 31 , xx + 34 ) ; xx [ 29 ] = 8.93e-3 ; xx [
31 ] = xx [ 29 ] * xx [ 18 ] ; xx [ 32 ] = xx [ 31 ] - xx [ 16 ] ; xx [ 16 ]
= xx [ 15 ] * xx [ 19 ] ; xx [ 37 ] = - ( xx [ 29 ] * xx [ 19 ] ) ; xx [ 38 ]
= xx [ 32 ] ; xx [ 39 ] = xx [ 16 ] ; pm_math_cross3 ( xx + 18 , xx + 37 , xx
+ 40 ) ; xx [ 33 ] = xx [ 17 ] * xx [ 19 ] ; xx [ 37 ] = xx [ 23 ] * state [
43 ] ; xx [ 43 ] = xx [ 23 ] - ( xx [ 37 ] * state [ 43 ] + xx [ 30 ] ) * xx
[ 4 ] ; xx [ 44 ] = ( xx [ 25 ] + xx [ 37 ] * state [ 42 ] ) * xx [ 4 ] ; xx
[ 45 ] = xx [ 4 ] * ( xx [ 24 ] * state [ 42 ] - xx [ 37 ] * state [ 41 ] ) ;
pm_math_quatXform ( xx + 9 , xx + 43 , xx + 23 ) ; xx [ 9 ] = xx [ 29 ] * xx
[ 20 ] ; xx [ 10 ] = xx [ 31 ] - xx [ 14 ] ; xx [ 37 ] = - xx [ 9 ] ; xx [ 38
] = xx [ 13 ] * xx [ 20 ] ; xx [ 39 ] = xx [ 10 ] ; pm_math_cross3 ( xx + 18
, xx + 37 , xx + 43 ) ; xx [ 11 ] = xx [ 3 ] * state [ 0 ] ; xx [ 12 ] = xx [
4 ] * ( xx [ 11 ] - xx [ 2 ] * state [ 3 ] ) ; xx [ 14 ] = xx [ 12 ] + xx [
12 ] ; xx [ 12 ] = xx [ 3 ] * state [ 1 ] ; xx [ 3 ] = ( xx [ 5 ] * state [ 3
] + xx [ 12 ] ) * xx [ 4 ] ; xx [ 30 ] = xx [ 3 ] + xx [ 3 ] ; xx [ 3 ] =
0.3522037996671813 ; xx [ 31 ] = xx [ 17 ] * xx [ 20 ] ; xx [ 37 ] = ( xx [
12 ] + xx [ 2 ] * state [ 2 ] ) * xx [ 4 ] ; xx [ 2 ] = xx [ 37 ] + xx [ 37 ]
; xx [ 12 ] = ( xx [ 11 ] + xx [ 5 ] * state [ 2 ] ) * xx [ 4 ] ; xx [ 5 ] =
xx [ 12 ] + xx [ 12 ] ; xx [ 11 ] = xx [ 17 ] * xx [ 18 ] ; xx [ 12 ] =
0.1624769242846504 ; xx [ 37 ] = xx [ 12 ] * state [ 16 ] ; xx [ 38 ] = xx [
12 ] * state [ 15 ] ; xx [ 39 ] = ( xx [ 37 ] * state [ 14 ] + xx [ 38 ] *
state [ 17 ] ) * xx [ 4 ] ; xx [ 46 ] = xx [ 12 ] * state [ 17 ] ; xx [ 12 ]
= xx [ 4 ] * ( xx [ 38 ] * state [ 16 ] - xx [ 46 ] * state [ 14 ] ) ; xx [
47 ] = 8.530000000000001e-3 ; xx [ 48 ] = xx [ 47 ] * xx [ 20 ] ; xx [ 49 ] =
0.04750999999999999 ; xx [ 50 ] = xx [ 49 ] * xx [ 19 ] ; xx [ 51 ] = xx [ 48
] - xx [ 50 ] ; xx [ 52 ] = xx [ 49 ] * xx [ 18 ] ; xx [ 53 ] = xx [ 51 ] ;
xx [ 54 ] = xx [ 52 ] ; xx [ 55 ] = - ( xx [ 47 ] * xx [ 18 ] ) ;
pm_math_cross3 ( xx + 18 , xx + 53 , xx + 56 ) ; xx [ 53 ] = 0.07589 ; xx [
54 ] = xx [ 53 ] * xx [ 18 ] ; xx [ 55 ] = xx [ 48 ] + xx [ 54 ] ; xx [ 48 ]
= xx [ 47 ] * xx [ 19 ] ; xx [ 59 ] = - ( xx [ 53 ] * xx [ 19 ] ) ; xx [ 60 ]
= xx [ 55 ] ; xx [ 61 ] = - xx [ 48 ] ; pm_math_cross3 ( xx + 18 , xx + 59 ,
xx + 62 ) ; xx [ 59 ] = xx [ 53 ] * xx [ 20 ] ; xx [ 60 ] = xx [ 54 ] - xx [
50 ] ; xx [ 65 ] = - xx [ 59 ] ; xx [ 66 ] = xx [ 49 ] * xx [ 20 ] ; xx [ 67
] = xx [ 60 ] ; pm_math_cross3 ( xx + 18 , xx + 65 , xx + 68 ) ; xx [ 50 ] =
xx [ 38 ] * state [ 14 ] ; xx [ 54 ] = xx [ 4 ] * ( xx [ 50 ] - xx [ 37 ] *
state [ 17 ] ) ; xx [ 61 ] = xx [ 38 ] * state [ 15 ] ; xx [ 38 ] = ( xx [ 46
] * state [ 17 ] + xx [ 61 ] ) * xx [ 4 ] ; xx [ 65 ] = 0.3249538485693007 ;
xx [ 66 ] = ( xx [ 61 ] + xx [ 37 ] * state [ 16 ] ) * xx [ 4 ] ; xx [ 37 ] =
( xx [ 50 ] + xx [ 46 ] * state [ 16 ] ) * xx [ 4 ] ; xx [ 46 ] =
0.1774935228395673 ; xx [ 50 ] = xx [ 46 ] * state [ 23 ] ; xx [ 61 ] = xx [
46 ] * state [ 22 ] ; xx [ 67 ] = ( xx [ 50 ] * state [ 21 ] + xx [ 61 ] *
state [ 24 ] ) * xx [ 4 ] ; xx [ 71 ] = xx [ 67 ] + xx [ 67 ] ; xx [ 67 ] =
xx [ 46 ] * state [ 24 ] ; xx [ 46 ] = xx [ 4 ] * ( xx [ 61 ] * state [ 23 ]
- xx [ 67 ] * state [ 21 ] ) ; xx [ 72 ] = xx [ 46 ] + xx [ 46 ] ; xx [ 46 ]
= 0.09134 ; xx [ 73 ] = xx [ 46 ] * xx [ 20 ] ; xx [ 74 ] =
0.05489999999999998 ; xx [ 75 ] = xx [ 74 ] * xx [ 19 ] ; xx [ 76 ] = xx [ 73
] - xx [ 75 ] ; xx [ 77 ] = xx [ 74 ] * xx [ 18 ] ; xx [ 78 ] = xx [ 76 ] ;
xx [ 79 ] = xx [ 77 ] ; xx [ 80 ] = - ( xx [ 46 ] * xx [ 18 ] ) ;
pm_math_cross3 ( xx + 18 , xx + 78 , xx + 81 ) ; xx [ 78 ] = 0.01565 ; xx [
79 ] = xx [ 78 ] * xx [ 18 ] ; xx [ 80 ] = xx [ 73 ] - xx [ 79 ] ; xx [ 73 ]
= xx [ 46 ] * xx [ 19 ] ; xx [ 84 ] = xx [ 78 ] * xx [ 19 ] ; xx [ 85 ] = xx
[ 80 ] ; xx [ 86 ] = - xx [ 73 ] ; pm_math_cross3 ( xx + 18 , xx + 84 , xx +
87 ) ; xx [ 84 ] = xx [ 78 ] * xx [ 20 ] ; xx [ 85 ] = xx [ 79 ] + xx [ 75 ]
; xx [ 90 ] = xx [ 84 ] ; xx [ 91 ] = xx [ 74 ] * xx [ 20 ] ; xx [ 92 ] = -
xx [ 85 ] ; pm_math_cross3 ( xx + 18 , xx + 90 , xx + 93 ) ; xx [ 18 ] = xx [
61 ] * state [ 21 ] ; xx [ 19 ] = xx [ 4 ] * ( xx [ 18 ] - xx [ 50 ] * state
[ 24 ] ) ; xx [ 20 ] = xx [ 19 ] + xx [ 19 ] ; xx [ 19 ] = xx [ 61 ] * state
[ 22 ] ; xx [ 61 ] = ( xx [ 67 ] * state [ 24 ] + xx [ 19 ] ) * xx [ 4 ] ; xx
[ 75 ] = xx [ 61 ] + xx [ 61 ] ; xx [ 61 ] = 0.3549870456791346 ; xx [ 79 ] =
( xx [ 19 ] + xx [ 50 ] * state [ 23 ] ) * xx [ 4 ] ; xx [ 19 ] = xx [ 79 ] +
xx [ 79 ] ; xx [ 50 ] = ( xx [ 18 ] + xx [ 67 ] * state [ 23 ] ) * xx [ 4 ] ;
xx [ 18 ] = xx [ 50 ] + xx [ 50 ] ; xx [ 50 ] = 0.1675024183407511 ; xx [ 67
] = xx [ 50 ] * state [ 9 ] ; xx [ 79 ] = xx [ 50 ] * state [ 8 ] ; xx [ 86 ]
= ( xx [ 67 ] * state [ 7 ] + xx [ 79 ] * state [ 10 ] ) * xx [ 4 ] ; xx [ 90
] = xx [ 50 ] * state [ 10 ] ; xx [ 50 ] = xx [ 4 ] * ( xx [ 79 ] * state [ 9
] - xx [ 90 ] * state [ 7 ] ) ; xx [ 91 ] = xx [ 79 ] * state [ 7 ] ; xx [ 92
] = xx [ 4 ] * ( xx [ 91 ] - xx [ 67 ] * state [ 10 ] ) ; xx [ 96 ] = xx [ 79
] * state [ 8 ] ; xx [ 79 ] = ( xx [ 90 ] * state [ 10 ] + xx [ 96 ] ) * xx [
4 ] ; xx [ 97 ] = 0.3350048366815023 ; xx [ 98 ] = ( xx [ 96 ] + xx [ 67 ] *
state [ 9 ] ) * xx [ 4 ] ; xx [ 67 ] = ( xx [ 91 ] + xx [ 90 ] * state [ 9 ]
) * xx [ 4 ] ; xx [ 90 ] = 0.1575773583037868 ; xx [ 91 ] = xx [ 90 ] * state
[ 30 ] ; xx [ 96 ] = xx [ 90 ] * state [ 29 ] ; xx [ 99 ] = ( xx [ 91 ] *
state [ 28 ] + xx [ 96 ] * state [ 31 ] ) * xx [ 4 ] ; xx [ 100 ] = xx [ 90 ]
* state [ 31 ] ; xx [ 90 ] = xx [ 4 ] * ( xx [ 96 ] * state [ 30 ] - xx [ 100
] * state [ 28 ] ) ; xx [ 101 ] = xx [ 96 ] * state [ 28 ] ; xx [ 102 ] = xx
[ 4 ] * ( xx [ 101 ] - xx [ 91 ] * state [ 31 ] ) ; xx [ 103 ] = xx [ 96 ] *
state [ 29 ] ; xx [ 96 ] = ( xx [ 100 ] * state [ 31 ] + xx [ 103 ] ) * xx [
4 ] ; xx [ 104 ] = 0.3151547166075735 ; xx [ 105 ] = ( xx [ 103 ] + xx [ 91 ]
* state [ 30 ] ) * xx [ 4 ] ; xx [ 91 ] = ( xx [ 101 ] + xx [ 100 ] * state [
30 ] ) * xx [ 4 ] ; J [ 0 ] = xx [ 0 ] ; J [ 1 ] = xx [ 6 ] ; J [ 2 ] = - xx
[ 7 ] ; J [ 15 ] = xx [ 8 ] ; J [ 16 ] = xx [ 0 ] ; J [ 17 ] = xx [ 0 ] ; J [
18 ] = ( xx [ 26 ] - xx [ 17 ] * xx [ 21 ] ) * xx [ 4 ] + xx [ 34 ] ; J [ 19
] = ( xx [ 40 ] - xx [ 29 ] * xx [ 33 ] ) * xx [ 4 ] + xx [ 23 ] - xx [ 15 ]
; J [ 20 ] = xx [ 13 ] + xx [ 4 ] * ( xx [ 43 ] - xx [ 17 ] * xx [ 9 ] ) ; J
[ 21 ] = xx [ 0 ] ; J [ 22 ] = - xx [ 14 ] ; J [ 23 ] = xx [ 30 ] - xx [ 3 ]
; J [ 36 ] = xx [ 0 ] ; J [ 37 ] = xx [ 8 ] ; J [ 38 ] = xx [ 0 ] ; J [ 39 ]
= xx [ 4 ] * ( xx [ 27 ] + xx [ 17 ] * xx [ 22 ] ) + xx [ 35 ] + xx [ 15 ] ;
J [ 40 ] = ( xx [ 17 ] * xx [ 32 ] + xx [ 41 ] ) * xx [ 4 ] + xx [ 24 ] ; J [
41 ] = xx [ 29 ] + ( xx [ 13 ] * xx [ 31 ] + xx [ 44 ] ) * xx [ 4 ] ; J [ 42
] = xx [ 0 ] ; J [ 43 ] = xx [ 3 ] - xx [ 2 ] ; J [ 44 ] = - xx [ 5 ] ; J [
57 ] = xx [ 0 ] ; J [ 58 ] = xx [ 0 ] ; J [ 59 ] = xx [ 8 ] ; J [ 60 ] = ( xx
[ 15 ] * xx [ 11 ] + xx [ 28 ] ) * xx [ 4 ] + xx [ 36 ] - xx [ 13 ] ; J [ 61
] = xx [ 4 ] * ( xx [ 42 ] + xx [ 17 ] * xx [ 16 ] ) + xx [ 25 ] - xx [ 29 ]
; J [ 62 ] = ( xx [ 17 ] * xx [ 10 ] + xx [ 45 ] ) * xx [ 4 ] ; J [ 69 ] = xx
[ 0 ] ; J [ 70 ] = xx [ 39 ] + xx [ 39 ] ; J [ 71 ] = - ( xx [ 12 ] + xx [ 12
] ) ; J [ 78 ] = xx [ 8 ] ; J [ 79 ] = xx [ 0 ] ; J [ 80 ] = xx [ 0 ] ; J [
81 ] = ( xx [ 17 ] * xx [ 51 ] + xx [ 56 ] ) * xx [ 4 ] + xx [ 34 ] ; J [ 82
] = ( xx [ 62 ] - xx [ 53 ] * xx [ 33 ] ) * xx [ 4 ] + xx [ 23 ] + xx [ 47 ]
; J [ 83 ] = xx [ 49 ] + xx [ 4 ] * ( xx [ 68 ] - xx [ 17 ] * xx [ 59 ] ) ; J
[ 90 ] = xx [ 0 ] ; J [ 91 ] = - ( xx [ 54 ] + xx [ 54 ] ) ; J [ 92 ] = xx [
38 ] + xx [ 38 ] - xx [ 65 ] ; J [ 99 ] = xx [ 0 ] ; J [ 100 ] = xx [ 8 ] ; J
[ 101 ] = xx [ 0 ] ; J [ 102 ] = xx [ 4 ] * ( xx [ 57 ] + xx [ 17 ] * xx [ 52
] ) + xx [ 35 ] - xx [ 47 ] ; J [ 103 ] = ( xx [ 17 ] * xx [ 55 ] + xx [ 63 ]
) * xx [ 4 ] + xx [ 24 ] ; J [ 104 ] = xx [ 53 ] + ( xx [ 49 ] * xx [ 31 ] +
xx [ 69 ] ) * xx [ 4 ] ; J [ 111 ] = xx [ 0 ] ; J [ 112 ] = xx [ 65 ] - ( xx
[ 66 ] + xx [ 66 ] ) ; J [ 113 ] = - ( xx [ 37 ] + xx [ 37 ] ) ; J [ 120 ] =
xx [ 0 ] ; J [ 121 ] = xx [ 0 ] ; J [ 122 ] = xx [ 8 ] ; J [ 123 ] = ( xx [
58 ] - xx [ 47 ] * xx [ 11 ] ) * xx [ 4 ] + xx [ 36 ] - xx [ 49 ] ; J [ 124 ]
= xx [ 4 ] * ( xx [ 64 ] - xx [ 17 ] * xx [ 48 ] ) + xx [ 25 ] - xx [ 53 ] ;
J [ 125 ] = ( xx [ 17 ] * xx [ 60 ] + xx [ 70 ] ) * xx [ 4 ] ; J [ 135 ] = xx
[ 0 ] ; J [ 136 ] = xx [ 71 ] ; J [ 137 ] = - xx [ 72 ] ; J [ 141 ] = xx [ 8
] ; J [ 142 ] = xx [ 0 ] ; J [ 143 ] = xx [ 0 ] ; J [ 144 ] = ( xx [ 17 ] *
xx [ 76 ] + xx [ 81 ] ) * xx [ 4 ] + xx [ 34 ] ; J [ 145 ] = ( xx [ 78 ] * xx
[ 33 ] + xx [ 87 ] ) * xx [ 4 ] + xx [ 23 ] + xx [ 46 ] ; J [ 146 ] = xx [ 74
] + xx [ 4 ] * ( xx [ 93 ] + xx [ 17 ] * xx [ 84 ] ) ; J [ 156 ] = xx [ 0 ] ;
J [ 157 ] = - xx [ 20 ] ; J [ 158 ] = xx [ 75 ] - xx [ 61 ] ; J [ 162 ] = xx
[ 0 ] ; J [ 163 ] = xx [ 8 ] ; J [ 164 ] = xx [ 0 ] ; J [ 165 ] = xx [ 4 ] *
( xx [ 82 ] + xx [ 17 ] * xx [ 77 ] ) + xx [ 35 ] - xx [ 46 ] ; J [ 166 ] = (
xx [ 17 ] * xx [ 80 ] + xx [ 88 ] ) * xx [ 4 ] + xx [ 24 ] ; J [ 167 ] = ( xx
[ 74 ] * xx [ 31 ] + xx [ 94 ] ) * xx [ 4 ] - xx [ 78 ] ; J [ 177 ] = xx [ 0
] ; J [ 178 ] = xx [ 61 ] - xx [ 19 ] ; J [ 179 ] = - xx [ 18 ] ; J [ 183 ] =
xx [ 0 ] ; J [ 184 ] = xx [ 0 ] ; J [ 185 ] = xx [ 8 ] ; J [ 186 ] = ( xx [
83 ] - xx [ 46 ] * xx [ 11 ] ) * xx [ 4 ] + xx [ 36 ] - xx [ 74 ] ; J [ 187 ]
= xx [ 4 ] * ( xx [ 89 ] - xx [ 17 ] * xx [ 73 ] ) + xx [ 25 ] + xx [ 78 ] ;
J [ 188 ] = ( xx [ 95 ] - xx [ 17 ] * xx [ 85 ] ) * xx [ 4 ] ; J [ 189 ] = xx
[ 0 ] ; J [ 190 ] = - xx [ 6 ] ; J [ 191 ] = xx [ 7 ] ; J [ 192 ] = xx [ 0 ]
; J [ 193 ] = xx [ 86 ] + xx [ 86 ] ; J [ 194 ] = - ( xx [ 50 ] + xx [ 50 ] )
; J [ 210 ] = xx [ 0 ] ; J [ 211 ] = xx [ 14 ] ; J [ 212 ] = xx [ 3 ] - xx [
30 ] ; J [ 213 ] = xx [ 0 ] ; J [ 214 ] = - ( xx [ 92 ] + xx [ 92 ] ) ; J [
215 ] = xx [ 79 ] + xx [ 79 ] - xx [ 97 ] ; J [ 231 ] = xx [ 0 ] ; J [ 232 ]
= xx [ 2 ] - xx [ 3 ] ; J [ 233 ] = xx [ 5 ] ; J [ 234 ] = xx [ 0 ] ; J [ 235
] = xx [ 97 ] - ( xx [ 98 ] + xx [ 98 ] ) ; J [ 236 ] = - ( xx [ 67 ] + xx [
67 ] ) ; J [ 261 ] = xx [ 0 ] ; J [ 262 ] = - xx [ 71 ] ; J [ 263 ] = xx [ 72
] ; J [ 264 ] = xx [ 0 ] ; J [ 265 ] = xx [ 99 ] + xx [ 99 ] ; J [ 266 ] = -
( xx [ 90 ] + xx [ 90 ] ) ; J [ 282 ] = xx [ 0 ] ; J [ 283 ] = xx [ 20 ] ; J
[ 284 ] = xx [ 61 ] - xx [ 75 ] ; J [ 285 ] = xx [ 0 ] ; J [ 286 ] = - ( xx [
102 ] + xx [ 102 ] ) ; J [ 287 ] = xx [ 96 ] + xx [ 96 ] - xx [ 104 ] ; J [
303 ] = xx [ 0 ] ; J [ 304 ] = xx [ 19 ] - xx [ 61 ] ; J [ 305 ] = xx [ 18 ]
; J [ 306 ] = xx [ 0 ] ; J [ 307 ] = xx [ 104 ] - ( xx [ 105 ] + xx [ 105 ] )
; J [ 308 ] = - ( xx [ 91 ] + xx [ 91 ] ) ; return 15 ; } static int
isInKinematicSingularity_0 ( const double * rtdv , const double * motionData
) { ( void ) rtdv ; ( void ) motionData ; return 0 ; } static int
isInKinematicSingularity_1 ( const double * rtdv , const double * motionData
) { ( void ) rtdv ; ( void ) motionData ; return 0 ; } static int
isInKinematicSingularity_2 ( const double * rtdv , const double * motionData
) { ( void ) rtdv ; ( void ) motionData ; return 0 ; } static int
isInKinematicSingularity_3 ( const double * rtdv , const double * motionData
) { ( void ) rtdv ; ( void ) motionData ; return 0 ; } static int
isInKinematicSingularity_4 ( const double * rtdv , const double * motionData
) { ( void ) rtdv ; ( void ) motionData ; return 0 ; } int
Kinematics_Model_2b2b31c2_1_isInKinematicSingularity ( const void * mech ,
const double * rtdv , size_t constraintIdx , const double * motionData ) { (
void ) mech ; ( void ) rtdv ; ( void ) motionData ; switch ( constraintIdx )
{ case 0 : return isInKinematicSingularity_0 ( rtdv , motionData ) ; case 1 :
return isInKinematicSingularity_1 ( rtdv , motionData ) ; case 2 : return
isInKinematicSingularity_2 ( rtdv , motionData ) ; case 3 : return
isInKinematicSingularity_3 ( rtdv , motionData ) ; case 4 : return
isInKinematicSingularity_4 ( rtdv , motionData ) ; } return 0 ; }
PmfMessageId Kinematics_Model_2b2b31c2_1_convertStateVector ( const void *
asmMech , const double * rtdv , const void * simMech , const double *
asmState , double * simState , void * neDiagMgr0 ) { NeuDiagnosticManager *
neDiagMgr = ( NeuDiagnosticManager * ) neDiagMgr0 ; ( void ) asmMech ; ( void
) rtdv ; ( void ) simMech ; ( void ) neDiagMgr ; simState [ 0 ] = asmState [
0 ] ; simState [ 1 ] = asmState [ 1 ] ; simState [ 2 ] = asmState [ 2 ] ;
simState [ 3 ] = asmState [ 3 ] ; simState [ 4 ] = asmState [ 4 ] ; simState
[ 5 ] = asmState [ 5 ] ; simState [ 6 ] = asmState [ 6 ] ; simState [ 7 ] =
asmState [ 7 ] ; simState [ 8 ] = asmState [ 8 ] ; simState [ 9 ] = asmState
[ 9 ] ; simState [ 10 ] = asmState [ 10 ] ; simState [ 11 ] = asmState [ 11 ]
; simState [ 12 ] = asmState [ 12 ] ; simState [ 13 ] = asmState [ 13 ] ;
simState [ 14 ] = asmState [ 14 ] ; simState [ 15 ] = asmState [ 15 ] ;
simState [ 16 ] = asmState [ 16 ] ; simState [ 17 ] = asmState [ 17 ] ;
simState [ 18 ] = asmState [ 18 ] ; simState [ 19 ] = asmState [ 19 ] ;
simState [ 20 ] = asmState [ 20 ] ; simState [ 21 ] = asmState [ 21 ] ;
simState [ 22 ] = asmState [ 22 ] ; simState [ 23 ] = asmState [ 23 ] ;
simState [ 24 ] = asmState [ 24 ] ; simState [ 25 ] = asmState [ 25 ] ;
simState [ 26 ] = asmState [ 26 ] ; simState [ 27 ] = asmState [ 27 ] ;
simState [ 28 ] = asmState [ 28 ] ; simState [ 29 ] = asmState [ 29 ] ;
simState [ 30 ] = asmState [ 30 ] ; simState [ 31 ] = asmState [ 31 ] ;
simState [ 32 ] = asmState [ 32 ] ; simState [ 33 ] = asmState [ 33 ] ;
simState [ 34 ] = asmState [ 34 ] ; simState [ 35 ] = asmState [ 35 ] ;
simState [ 36 ] = asmState [ 36 ] ; simState [ 37 ] = asmState [ 37 ] ;
simState [ 38 ] = asmState [ 38 ] ; simState [ 39 ] = asmState [ 39 ] ;
simState [ 40 ] = asmState [ 40 ] ; simState [ 41 ] = asmState [ 41 ] ;
simState [ 42 ] = asmState [ 42 ] ; simState [ 43 ] = asmState [ 43 ] ;
simState [ 44 ] = asmState [ 44 ] ; simState [ 45 ] = asmState [ 45 ] ;
simState [ 46 ] = asmState [ 46 ] ; simState [ 47 ] = asmState [ 47 ] ;
return NULL ; } void Kinematics_Model_2b2b31c2_1_constructStateVector ( const
void * mech , const double * solverState , const double * u , const double *
uDot , double * discreteState , double * fullState ) { ( void ) mech ; ( void
) discreteState ; fullState [ 0 ] = solverState [ 0 ] ; fullState [ 1 ] =
solverState [ 1 ] ; fullState [ 2 ] = solverState [ 2 ] ; fullState [ 3 ] =
solverState [ 3 ] ; fullState [ 4 ] = solverState [ 4 ] ; fullState [ 5 ] =
solverState [ 5 ] ; fullState [ 6 ] = solverState [ 6 ] ; fullState [ 7 ] =
solverState [ 7 ] ; fullState [ 8 ] = solverState [ 8 ] ; fullState [ 9 ] =
solverState [ 9 ] ; fullState [ 10 ] = solverState [ 10 ] ; fullState [ 11 ]
= solverState [ 11 ] ; fullState [ 12 ] = solverState [ 12 ] ; fullState [ 13
] = solverState [ 13 ] ; fullState [ 14 ] = solverState [ 14 ] ; fullState [
15 ] = solverState [ 15 ] ; fullState [ 16 ] = solverState [ 16 ] ; fullState
[ 17 ] = solverState [ 17 ] ; fullState [ 18 ] = solverState [ 18 ] ;
fullState [ 19 ] = solverState [ 19 ] ; fullState [ 20 ] = solverState [ 20 ]
; fullState [ 21 ] = solverState [ 21 ] ; fullState [ 22 ] = solverState [ 22
] ; fullState [ 23 ] = solverState [ 23 ] ; fullState [ 24 ] = solverState [
24 ] ; fullState [ 25 ] = solverState [ 25 ] ; fullState [ 26 ] = solverState
[ 26 ] ; fullState [ 27 ] = solverState [ 27 ] ; fullState [ 28 ] =
solverState [ 28 ] ; fullState [ 29 ] = solverState [ 29 ] ; fullState [ 30 ]
= solverState [ 30 ] ; fullState [ 31 ] = solverState [ 31 ] ; fullState [ 32
] = solverState [ 32 ] ; fullState [ 33 ] = solverState [ 33 ] ; fullState [
34 ] = solverState [ 34 ] ; fullState [ 35 ] = solverState [ 35 ] ; fullState
[ 36 ] = solverState [ 36 ] ; fullState [ 37 ] = u [ 0 ] ; fullState [ 38 ] =
solverState [ 37 ] ; fullState [ 39 ] = solverState [ 38 ] ; fullState [ 40 ]
= uDot [ 0 ] ; fullState [ 41 ] = solverState [ 39 ] ; fullState [ 42 ] =
solverState [ 40 ] ; fullState [ 43 ] = solverState [ 41 ] ; fullState [ 44 ]
= solverState [ 42 ] ; fullState [ 45 ] = solverState [ 43 ] ; fullState [ 46
] = solverState [ 44 ] ; fullState [ 47 ] = solverState [ 45 ] ; } void
Kinematics_Model_2b2b31c2_1_extractSolverStateVector ( const void * mech ,
const double * fullState , double * solverState ) { ( void ) mech ;
solverState [ 0 ] = fullState [ 0 ] ; solverState [ 1 ] = fullState [ 1 ] ;
solverState [ 2 ] = fullState [ 2 ] ; solverState [ 3 ] = fullState [ 3 ] ;
solverState [ 4 ] = fullState [ 4 ] ; solverState [ 5 ] = fullState [ 5 ] ;
solverState [ 6 ] = fullState [ 6 ] ; solverState [ 7 ] = fullState [ 7 ] ;
solverState [ 8 ] = fullState [ 8 ] ; solverState [ 9 ] = fullState [ 9 ] ;
solverState [ 10 ] = fullState [ 10 ] ; solverState [ 11 ] = fullState [ 11 ]
; solverState [ 12 ] = fullState [ 12 ] ; solverState [ 13 ] = fullState [ 13
] ; solverState [ 14 ] = fullState [ 14 ] ; solverState [ 15 ] = fullState [
15 ] ; solverState [ 16 ] = fullState [ 16 ] ; solverState [ 17 ] = fullState
[ 17 ] ; solverState [ 18 ] = fullState [ 18 ] ; solverState [ 19 ] =
fullState [ 19 ] ; solverState [ 20 ] = fullState [ 20 ] ; solverState [ 21 ]
= fullState [ 21 ] ; solverState [ 22 ] = fullState [ 22 ] ; solverState [ 23
] = fullState [ 23 ] ; solverState [ 24 ] = fullState [ 24 ] ; solverState [
25 ] = fullState [ 25 ] ; solverState [ 26 ] = fullState [ 26 ] ; solverState
[ 27 ] = fullState [ 27 ] ; solverState [ 28 ] = fullState [ 28 ] ;
solverState [ 29 ] = fullState [ 29 ] ; solverState [ 30 ] = fullState [ 30 ]
; solverState [ 31 ] = fullState [ 31 ] ; solverState [ 32 ] = fullState [ 32
] ; solverState [ 33 ] = fullState [ 33 ] ; solverState [ 34 ] = fullState [
34 ] ; solverState [ 35 ] = fullState [ 35 ] ; solverState [ 36 ] = fullState
[ 36 ] ; solverState [ 37 ] = fullState [ 38 ] ; solverState [ 38 ] =
fullState [ 39 ] ; solverState [ 39 ] = fullState [ 41 ] ; solverState [ 40 ]
= fullState [ 42 ] ; solverState [ 41 ] = fullState [ 43 ] ; solverState [ 42
] = fullState [ 44 ] ; solverState [ 43 ] = fullState [ 45 ] ; solverState [
44 ] = fullState [ 46 ] ; solverState [ 45 ] = fullState [ 47 ] ; } int
Kinematics_Model_2b2b31c2_1_isPositionViolation ( const void * mech , const
double * rtdv , const int * eqnEnableFlags , const double * state ) { int ii
[ 3 ] ; double xx [ 45 ] ; ( void ) mech ; ( void ) rtdv ; ( void )
eqnEnableFlags ; xx [ 0 ] = - state [ 41 ] ; xx [ 1 ] = - state [ 42 ] ; xx [
2 ] = - state [ 43 ] ; xx [ 3 ] = - state [ 44 ] ; xx [ 4 ] = 8.93e-3 ; xx [
5 ] = - 0.03858000000000004 ; xx [ 6 ] = - 0.09166000000000001 ;
pm_math_quatXform ( xx + 0 , xx + 4 , xx + 7 ) ; xx [ 4 ] = 0.23241 ; xx [ 5
] = xx [ 4 ] * state [ 43 ] ; xx [ 6 ] = xx [ 4 ] * state [ 42 ] ; xx [ 10 ]
= 2.0 ; xx [ 11 ] = ( xx [ 5 ] * state [ 41 ] + xx [ 6 ] * state [ 44 ] ) *
xx [ 10 ] + state [ 35 ] ; xx [ 12 ] = 0.1761018998335906 ; xx [ 13 ] = xx [
12 ] * state [ 2 ] ; xx [ 14 ] = xx [ 12 ] * state [ 3 ] ; xx [ 15 ] = ( xx [
13 ] * state [ 2 ] + xx [ 14 ] * state [ 3 ] ) * xx [ 10 ] ; xx [ 16 ] = xx [
12 ] - xx [ 15 ] + 0.3530818998335906 - xx [ 15 ] ; xx [ 12 ] = xx [ 10 ] * (
xx [ 5 ] * state [ 44 ] - xx [ 6 ] * state [ 41 ] ) + state [ 36 ] ; xx [ 15
] = ( xx [ 14 ] * state [ 0 ] + xx [ 13 ] * state [ 1 ] ) * xx [ 10 ] ; xx [
17 ] = xx [ 15 ] + 0.2523 + xx [ 15 ] ; xx [ 15 ] = state [ 37 ] - ( xx [ 6 ]
* state [ 42 ] + xx [ 5 ] * state [ 43 ] ) * xx [ 10 ] + xx [ 4 ] ; xx [ 4 ]
= xx [ 10 ] * ( xx [ 14 ] * state [ 1 ] - xx [ 13 ] * state [ 0 ] ) ; xx [ 5
] = xx [ 4 ] + 0.12489 + xx [ 4 ] ; xx [ 18 ] = 0.07589 ; xx [ 19 ] = -
0.04750999999999999 ; xx [ 20 ] = 8.530000000000001e-3 ; pm_math_quatXform (
xx + 0 , xx + 18 , xx + 21 ) ; xx [ 4 ] = 0.1624769242846504 ; xx [ 6 ] = xx
[ 4 ] * state [ 16 ] ; xx [ 13 ] = xx [ 4 ] * state [ 17 ] ; xx [ 4 ] = ( xx
[ 6 ] * state [ 16 ] + xx [ 13 ] * state [ 17 ] ) * xx [ 10 ] ; xx [ 14 ] = (
xx [ 13 ] * state [ 14 ] + xx [ 6 ] * state [ 15 ] ) * xx [ 10 ] ; xx [ 18 ]
= xx [ 10 ] * ( xx [ 13 ] * state [ 15 ] - xx [ 6 ] * state [ 14 ] ) ; xx [
24 ] = - 0.01565 ; xx [ 25 ] = - 0.05489999999999998 ; xx [ 26 ] = 0.09134 ;
pm_math_quatXform ( xx + 0 , xx + 24 , xx + 27 ) ; xx [ 0 ] =
0.1774935228395673 ; xx [ 1 ] = xx [ 0 ] * state [ 23 ] ; xx [ 2 ] = xx [ 0 ]
* state [ 24 ] ; xx [ 3 ] = ( xx [ 1 ] * state [ 23 ] + xx [ 2 ] * state [ 24
] ) * xx [ 10 ] ; xx [ 6 ] = xx [ 0 ] - xx [ 3 ] + 0.3560035228395673 - xx [
3 ] ; xx [ 0 ] = ( xx [ 2 ] * state [ 21 ] + xx [ 1 ] * state [ 22 ] ) * xx [
10 ] ; xx [ 3 ] = xx [ 0 ] + 0.25087 + xx [ 0 ] ; xx [ 0 ] = xx [ 10 ] * ( xx
[ 2 ] * state [ 22 ] - xx [ 1 ] * state [ 21 ] ) ; xx [ 1 ] = xx [ 0 ] +
0.28196 + xx [ 0 ] ; xx [ 0 ] = 0.1675024183407511 ; xx [ 2 ] = xx [ 0 ] *
state [ 9 ] ; xx [ 13 ] = xx [ 0 ] * state [ 10 ] ; xx [ 0 ] = ( xx [ 2 ] *
state [ 9 ] + xx [ 13 ] * state [ 10 ] ) * xx [ 10 ] ; xx [ 19 ] = ( xx [ 13
] * state [ 7 ] + xx [ 2 ] * state [ 8 ] ) * xx [ 10 ] ; xx [ 20 ] = xx [ 10
] * ( xx [ 13 ] * state [ 8 ] - xx [ 2 ] * state [ 7 ] ) ; xx [ 2 ] =
0.1575773583037868 ; xx [ 13 ] = xx [ 2 ] * state [ 30 ] ; xx [ 24 ] = xx [ 2
] * state [ 31 ] ; xx [ 2 ] = ( xx [ 13 ] * state [ 30 ] + xx [ 24 ] * state
[ 31 ] ) * xx [ 10 ] ; xx [ 25 ] = ( xx [ 24 ] * state [ 28 ] + xx [ 13 ] *
state [ 29 ] ) * xx [ 10 ] ; xx [ 26 ] = xx [ 10 ] * ( xx [ 24 ] * state [ 29
] - xx [ 13 ] * state [ 28 ] ) ; xx [ 30 ] = fabs ( xx [ 7 ] + xx [ 11 ] - xx
[ 16 ] ) ; xx [ 31 ] = fabs ( xx [ 8 ] + xx [ 12 ] - xx [ 17 ] ) ; xx [ 32 ]
= fabs ( xx [ 9 ] + xx [ 15 ] - xx [ 5 ] ) ; xx [ 33 ] = fabs ( xx [ 21 ] +
xx [ 11 ] + xx [ 4 ] + xx [ 4 ] - 0.4008438485693007 ) ; xx [ 34 ] = fabs (
xx [ 22 ] + xx [ 12 ] - ( xx [ 14 ] + xx [ 14 ] ) - 0.23 ) ; xx [ 35 ] = fabs
( xx [ 23 ] + xx [ 15 ] - ( xx [ 18 ] + xx [ 18 ] ) - 0.201 ) ; xx [ 36 ] =
fabs ( xx [ 27 ] + xx [ 11 ] - xx [ 6 ] ) ; xx [ 37 ] = fabs ( xx [ 28 ] + xx
[ 12 ] - xx [ 3 ] ) ; xx [ 38 ] = fabs ( xx [ 29 ] + xx [ 15 ] - xx [ 1 ] ) ;
xx [ 39 ] = fabs ( xx [ 16 ] + xx [ 0 ] + xx [ 0 ] - 0.1598848366815023 ) ;
xx [ 40 ] = fabs ( xx [ 17 ] - ( xx [ 19 ] + xx [ 19 ] ) - 0.28187 ) ; xx [
41 ] = fabs ( xx [ 5 ] - ( xx [ 20 ] + xx [ 20 ] ) - 0.12641 ) ; xx [ 42 ] =
fabs ( xx [ 6 ] + xx [ 2 ] + xx [ 2 ] - 0.1374147166075735 ) ; xx [ 43 ] =
fabs ( xx [ 3 ] - ( xx [ 25 ] + xx [ 25 ] ) - 0.28138 ) ; xx [ 44 ] = fabs (
xx [ 1 ] - ( xx [ 26 ] + xx [ 26 ] ) - 0.26458 ) ; ii [ 0 ] = 30 ; { int ll ;
for ( ll = 31 ; ll < 45 ; ++ ll ) if ( xx [ ll ] > xx [ ii [ 0 ] ] ) ii [ 0 ]
= ll ; } ii [ 0 ] -= 30 ; xx [ 0 ] = xx [ 30 + ( ii [ 0 ] ) ] ; xx [ 1 ] = xx
[ 0 ] - 1.0e-6 ; if ( xx [ 1 ] < 0.0 ) ii [ 0 ] = - 1 ; else if ( xx [ 1 ] >
0.0 ) ii [ 0 ] = + 1 ; else ii [ 0 ] = 0 ; ii [ 1 ] = ii [ 0 ] ; if ( 0 > ii
[ 1 ] ) ii [ 1 ] = 0 ; return ii [ 1 ] ; } int
Kinematics_Model_2b2b31c2_1_isVelocityViolation ( const void * mech , const
double * rtdv , const int * eqnEnableFlags , const double * state ) { int ii
[ 3 ] ; double xx [ 43 ] ; ( void ) mech ; ( void ) rtdv ; ( void )
eqnEnableFlags ; xx [ 0 ] = - state [ 41 ] ; xx [ 1 ] = - state [ 42 ] ; xx [
2 ] = - state [ 43 ] ; xx [ 3 ] = - state [ 44 ] ; xx [ 4 ] = state [ 45 ] ;
xx [ 5 ] = state [ 46 ] ; xx [ 6 ] = state [ 47 ] ; xx [ 7 ] = 8.93e-3 ; xx [
8 ] = - 0.03858000000000004 ; xx [ 9 ] = - 0.09166000000000001 ;
pm_math_cross3 ( xx + 4 , xx + 7 , xx + 10 ) ; pm_math_quatXform ( xx + 0 ,
xx + 10 , xx + 7 ) ; xx [ 10 ] = 0.23241 ; xx [ 11 ] = xx [ 10 ] * state [ 46
] ; xx [ 12 ] = xx [ 10 ] * state [ 45 ] ; xx [ 10 ] = xx [ 12 ] * state [ 44
] ; xx [ 13 ] = state [ 42 ] ; xx [ 14 ] = state [ 43 ] ; xx [ 15 ] = state [
44 ] ; xx [ 16 ] = xx [ 11 ] * state [ 44 ] ; xx [ 17 ] = xx [ 12 ] * state [
42 ] + xx [ 11 ] * state [ 43 ] ; xx [ 18 ] = xx [ 10 ] ; xx [ 19 ] = xx [ 16
] ; xx [ 20 ] = - xx [ 17 ] ; pm_math_cross3 ( xx + 13 , xx + 18 , xx + 21 )
; xx [ 13 ] = 2.0 ; xx [ 14 ] = state [ 38 ] + xx [ 11 ] + ( xx [ 10 ] *
state [ 41 ] + xx [ 21 ] ) * xx [ 13 ] ; xx [ 18 ] = - state [ 1 ] ; xx [ 19
] = - state [ 2 ] ; xx [ 20 ] = - state [ 3 ] ; xx [ 10 ] =
0.1761018998335906 ; xx [ 11 ] = xx [ 10 ] * state [ 5 ] ; xx [ 15 ] = xx [
10 ] * state [ 6 ] ; xx [ 10 ] = xx [ 11 ] * state [ 2 ] + xx [ 15 ] * state
[ 3 ] ; xx [ 24 ] = xx [ 11 ] * state [ 1 ] ; xx [ 25 ] = xx [ 15 ] * state [
1 ] ; xx [ 26 ] = xx [ 10 ] ; xx [ 27 ] = - xx [ 24 ] ; xx [ 28 ] = - xx [ 25
] ; pm_math_cross3 ( xx + 18 , xx + 26 , xx + 29 ) ; xx [ 18 ] = xx [ 13 ] *
( xx [ 29 ] - xx [ 10 ] * state [ 0 ] ) ; xx [ 10 ] = xx [ 18 ] + xx [ 18 ] ;
xx [ 18 ] = state [ 39 ] + ( xx [ 16 ] * state [ 41 ] + xx [ 22 ] ) * xx [ 13
] - xx [ 12 ] ; xx [ 12 ] = xx [ 15 ] + ( xx [ 24 ] * state [ 0 ] + xx [ 30 ]
) * xx [ 13 ] ; xx [ 15 ] = xx [ 12 ] + xx [ 12 ] ; xx [ 12 ] = state [ 40 ]
+ xx [ 13 ] * ( xx [ 23 ] - xx [ 17 ] * state [ 41 ] ) ; xx [ 16 ] = ( xx [
25 ] * state [ 0 ] + xx [ 31 ] ) * xx [ 13 ] - xx [ 11 ] ; xx [ 11 ] = xx [
16 ] + xx [ 16 ] ; xx [ 19 ] = 0.07589 ; xx [ 20 ] = - 0.04750999999999999 ;
xx [ 21 ] = 8.530000000000001e-3 ; pm_math_cross3 ( xx + 4 , xx + 19 , xx +
22 ) ; pm_math_quatXform ( xx + 0 , xx + 22 , xx + 19 ) ; xx [ 22 ] = - state
[ 15 ] ; xx [ 23 ] = - state [ 16 ] ; xx [ 24 ] = - state [ 17 ] ; xx [ 16 ]
= 0.1624769242846504 ; xx [ 17 ] = xx [ 16 ] * state [ 19 ] ; xx [ 25 ] = xx
[ 16 ] * state [ 20 ] ; xx [ 16 ] = xx [ 17 ] * state [ 16 ] + xx [ 25 ] *
state [ 17 ] ; xx [ 26 ] = xx [ 17 ] * state [ 15 ] ; xx [ 27 ] = xx [ 25 ] *
state [ 15 ] ; xx [ 28 ] = xx [ 16 ] ; xx [ 29 ] = - xx [ 26 ] ; xx [ 30 ] =
- xx [ 27 ] ; pm_math_cross3 ( xx + 22 , xx + 28 , xx + 31 ) ; xx [ 22 ] = xx
[ 13 ] * ( xx [ 31 ] - xx [ 16 ] * state [ 14 ] ) ; xx [ 16 ] = xx [ 25 ] + (
xx [ 26 ] * state [ 14 ] + xx [ 32 ] ) * xx [ 13 ] ; xx [ 23 ] = ( xx [ 27 ]
* state [ 14 ] + xx [ 33 ] ) * xx [ 13 ] - xx [ 17 ] ; xx [ 24 ] = - 0.01565
; xx [ 25 ] = - 0.05489999999999998 ; xx [ 26 ] = 0.09134 ; pm_math_cross3 (
xx + 4 , xx + 24 , xx + 27 ) ; pm_math_quatXform ( xx + 0 , xx + 27 , xx + 4
) ; xx [ 0 ] = - state [ 22 ] ; xx [ 1 ] = - state [ 23 ] ; xx [ 2 ] = -
state [ 24 ] ; xx [ 3 ] = 0.1774935228395673 ; xx [ 17 ] = xx [ 3 ] * state [
26 ] ; xx [ 24 ] = xx [ 3 ] * state [ 27 ] ; xx [ 3 ] = xx [ 17 ] * state [
23 ] + xx [ 24 ] * state [ 24 ] ; xx [ 25 ] = xx [ 17 ] * state [ 22 ] ; xx [
26 ] = xx [ 24 ] * state [ 22 ] ; xx [ 27 ] = xx [ 3 ] ; xx [ 28 ] = - xx [
25 ] ; xx [ 29 ] = - xx [ 26 ] ; pm_math_cross3 ( xx + 0 , xx + 27 , xx + 30
) ; xx [ 0 ] = xx [ 13 ] * ( xx [ 30 ] - xx [ 3 ] * state [ 21 ] ) ; xx [ 1 ]
= xx [ 0 ] + xx [ 0 ] ; xx [ 0 ] = xx [ 24 ] + ( xx [ 25 ] * state [ 21 ] +
xx [ 31 ] ) * xx [ 13 ] ; xx [ 2 ] = xx [ 0 ] + xx [ 0 ] ; xx [ 0 ] = ( xx [
26 ] * state [ 21 ] + xx [ 32 ] ) * xx [ 13 ] - xx [ 17 ] ; xx [ 3 ] = xx [ 0
] + xx [ 0 ] ; xx [ 24 ] = - state [ 8 ] ; xx [ 25 ] = - state [ 9 ] ; xx [
26 ] = - state [ 10 ] ; xx [ 0 ] = 0.1675024183407511 ; xx [ 17 ] = xx [ 0 ]
* state [ 12 ] ; xx [ 27 ] = xx [ 0 ] * state [ 13 ] ; xx [ 0 ] = xx [ 17 ] *
state [ 9 ] + xx [ 27 ] * state [ 10 ] ; xx [ 28 ] = xx [ 17 ] * state [ 8 ]
; xx [ 29 ] = xx [ 27 ] * state [ 8 ] ; xx [ 30 ] = xx [ 0 ] ; xx [ 31 ] = -
xx [ 28 ] ; xx [ 32 ] = - xx [ 29 ] ; pm_math_cross3 ( xx + 24 , xx + 30 , xx
+ 33 ) ; xx [ 24 ] = xx [ 13 ] * ( xx [ 33 ] - xx [ 0 ] * state [ 7 ] ) ; xx
[ 0 ] = xx [ 27 ] + ( xx [ 28 ] * state [ 7 ] + xx [ 34 ] ) * xx [ 13 ] ; xx
[ 25 ] = ( xx [ 29 ] * state [ 7 ] + xx [ 35 ] ) * xx [ 13 ] - xx [ 17 ] ; xx
[ 26 ] = - state [ 29 ] ; xx [ 27 ] = - state [ 30 ] ; xx [ 28 ] = - state [
31 ] ; xx [ 17 ] = 0.1575773583037868 ; xx [ 29 ] = xx [ 17 ] * state [ 33 ]
; xx [ 30 ] = xx [ 17 ] * state [ 34 ] ; xx [ 17 ] = xx [ 29 ] * state [ 30 ]
+ xx [ 30 ] * state [ 31 ] ; xx [ 31 ] = xx [ 29 ] * state [ 29 ] ; xx [ 32 ]
= xx [ 30 ] * state [ 29 ] ; xx [ 33 ] = xx [ 17 ] ; xx [ 34 ] = - xx [ 31 ]
; xx [ 35 ] = - xx [ 32 ] ; pm_math_cross3 ( xx + 26 , xx + 33 , xx + 36 ) ;
xx [ 26 ] = xx [ 13 ] * ( xx [ 36 ] - xx [ 17 ] * state [ 28 ] ) ; xx [ 17 ]
= xx [ 30 ] + ( xx [ 31 ] * state [ 28 ] + xx [ 37 ] ) * xx [ 13 ] ; xx [ 27
] = ( xx [ 32 ] * state [ 28 ] + xx [ 38 ] ) * xx [ 13 ] - xx [ 29 ] ; xx [
28 ] = fabs ( xx [ 7 ] + xx [ 14 ] - xx [ 10 ] ) ; xx [ 29 ] = fabs ( xx [ 8
] + xx [ 18 ] - xx [ 15 ] ) ; xx [ 30 ] = fabs ( xx [ 9 ] + xx [ 12 ] - xx [
11 ] ) ; xx [ 31 ] = fabs ( xx [ 19 ] + xx [ 14 ] - ( xx [ 22 ] + xx [ 22 ] )
) ; xx [ 32 ] = fabs ( xx [ 20 ] + xx [ 18 ] - ( xx [ 16 ] + xx [ 16 ] ) ) ;
xx [ 33 ] = fabs ( xx [ 21 ] + xx [ 12 ] - ( xx [ 23 ] + xx [ 23 ] ) ) ; xx [
34 ] = fabs ( xx [ 4 ] + xx [ 14 ] - xx [ 1 ] ) ; xx [ 35 ] = fabs ( xx [ 5 ]
+ xx [ 18 ] - xx [ 2 ] ) ; xx [ 36 ] = fabs ( xx [ 6 ] + xx [ 12 ] - xx [ 3 ]
) ; xx [ 37 ] = fabs ( xx [ 10 ] - ( xx [ 24 ] + xx [ 24 ] ) ) ; xx [ 38 ] =
fabs ( xx [ 15 ] - ( xx [ 0 ] + xx [ 0 ] ) ) ; xx [ 39 ] = fabs ( xx [ 11 ] -
( xx [ 25 ] + xx [ 25 ] ) ) ; xx [ 40 ] = fabs ( xx [ 1 ] - ( xx [ 26 ] + xx
[ 26 ] ) ) ; xx [ 41 ] = fabs ( xx [ 2 ] - ( xx [ 17 ] + xx [ 17 ] ) ) ; xx [
42 ] = fabs ( xx [ 3 ] - ( xx [ 27 ] + xx [ 27 ] ) ) ; ii [ 0 ] = 28 ; { int
ll ; for ( ll = 29 ; ll < 43 ; ++ ll ) if ( xx [ ll ] > xx [ ii [ 0 ] ] ) ii
[ 0 ] = ll ; } ii [ 0 ] -= 28 ; xx [ 0 ] = xx [ 28 + ( ii [ 0 ] ) ] ; xx [ 1
] = xx [ 0 ] - 1.0e-6 ; if ( xx [ 1 ] < 0.0 ) ii [ 0 ] = - 1 ; else if ( xx [
1 ] > 0.0 ) ii [ 0 ] = + 1 ; else ii [ 0 ] = 0 ; ii [ 1 ] = ii [ 0 ] ; if ( 0
> ii [ 1 ] ) ii [ 1 ] = 0 ; return ii [ 1 ] ; } PmfMessageId
Kinematics_Model_2b2b31c2_1_projectStateSim ( const void * mech , const
double * rtdv , const int * eqnEnableFlags , const double * input , double *
state , void * neDiagMgr0 ) { NeuDiagnosticManager * neDiagMgr = (
NeuDiagnosticManager * ) neDiagMgr0 ; int ii [ 15 ] ; double xx [ 1115 ] ; (
void ) mech ; ( void ) rtdv ; ( void ) eqnEnableFlags ; ( void ) input ; (
void ) neDiagMgr ; xx [ 0 ] = 1.0 ; xx [ 1 ] = xx [ 0 ] / sqrt ( state [ 0 ]
* state [ 0 ] + state [ 1 ] * state [ 1 ] + state [ 2 ] * state [ 2 ] + state
[ 3 ] * state [ 3 ] ) ; xx [ 2 ] = xx [ 1 ] * state [ 0 ] ; xx [ 3 ] = xx [ 1
] * state [ 1 ] ; xx [ 4 ] = xx [ 1 ] * state [ 2 ] ; xx [ 5 ] = xx [ 1 ] *
state [ 3 ] ; xx [ 1 ] = 0.0 ; xx [ 6 ] = 0.1761018998335906 ; xx [ 7 ] = xx
[ 6 ] * xx [ 4 ] ; xx [ 8 ] = xx [ 2 ] * xx [ 7 ] ; xx [ 9 ] = xx [ 6 ] * xx
[ 3 ] ; xx [ 10 ] = 2.0 ; xx [ 11 ] = ( xx [ 8 ] + xx [ 5 ] * xx [ 9 ] ) * xx
[ 10 ] ; xx [ 12 ] = xx [ 11 ] + xx [ 11 ] ; xx [ 11 ] = xx [ 6 ] * xx [ 5 ]
; xx [ 13 ] = xx [ 2 ] * xx [ 11 ] ; xx [ 14 ] = xx [ 10 ] * ( xx [ 4 ] * xx
[ 9 ] - xx [ 13 ] ) ; xx [ 15 ] = xx [ 14 ] + xx [ 14 ] ; xx [ 14 ] = xx [ 0
] / sqrt ( state [ 41 ] * state [ 41 ] + state [ 42 ] * state [ 42 ] + state
[ 43 ] * state [ 43 ] + state [ 44 ] * state [ 44 ] ) ; xx [ 16 ] = xx [ 14 ]
* state [ 42 ] ; xx [ 17 ] = - xx [ 16 ] ; xx [ 18 ] = xx [ 14 ] * state [ 43
] ; xx [ 19 ] = - xx [ 18 ] ; xx [ 20 ] = xx [ 14 ] * state [ 44 ] ; xx [ 21
] = - xx [ 20 ] ; xx [ 22 ] = xx [ 17 ] ; xx [ 23 ] = xx [ 19 ] ; xx [ 24 ] =
xx [ 21 ] ; xx [ 25 ] = 0.09166000000000001 ; xx [ 26 ] = xx [ 25 ] * xx [ 20
] ; xx [ 27 ] = 0.03858000000000004 ; xx [ 28 ] = xx [ 27 ] * xx [ 18 ] ; xx
[ 29 ] = xx [ 26 ] + xx [ 28 ] ; xx [ 30 ] = xx [ 27 ] * xx [ 16 ] ; xx [ 31
] = xx [ 25 ] * xx [ 16 ] ; xx [ 32 ] = xx [ 29 ] ; xx [ 33 ] = - xx [ 30 ] ;
xx [ 34 ] = - xx [ 31 ] ; pm_math_cross3 ( xx + 22 , xx + 32 , xx + 35 ) ; xx
[ 32 ] = xx [ 14 ] * state [ 41 ] ; xx [ 14 ] = 0.23241 ; xx [ 33 ] = xx [ 14
] * xx [ 20 ] ; xx [ 34 ] = xx [ 32 ] * xx [ 33 ] ; xx [ 38 ] = xx [ 14 ] *
xx [ 16 ] ; xx [ 39 ] = xx [ 10 ] * ( xx [ 34 ] - xx [ 18 ] * xx [ 38 ] ) ;
xx [ 40 ] = 8.93e-3 ; xx [ 41 ] = xx [ 40 ] * xx [ 18 ] ; xx [ 42 ] = xx [ 40
] * xx [ 16 ] ; xx [ 43 ] = xx [ 26 ] - xx [ 42 ] ; xx [ 26 ] = xx [ 25 ] *
xx [ 18 ] ; xx [ 44 ] = xx [ 41 ] ; xx [ 45 ] = xx [ 43 ] ; xx [ 46 ] = - xx
[ 26 ] ; pm_math_cross3 ( xx + 22 , xx + 44 , xx + 47 ) ; xx [ 44 ] = xx [ 14
] * xx [ 18 ] ; xx [ 45 ] = xx [ 18 ] * xx [ 44 ] ; xx [ 46 ] = xx [ 20 ] *
xx [ 33 ] ; xx [ 50 ] = ( xx [ 45 ] + xx [ 46 ] ) * xx [ 10 ] ; xx [ 51 ] =
0.14075 ; xx [ 52 ] = xx [ 40 ] * xx [ 20 ] ; xx [ 53 ] = xx [ 27 ] * xx [ 20
] ; xx [ 54 ] = xx [ 28 ] - xx [ 42 ] ; xx [ 55 ] = xx [ 52 ] ; xx [ 56 ] = -
xx [ 53 ] ; xx [ 57 ] = xx [ 54 ] ; pm_math_cross3 ( xx + 22 , xx + 55 , xx +
58 ) ; xx [ 28 ] = xx [ 2 ] * xx [ 9 ] ; xx [ 42 ] = xx [ 10 ] * ( xx [ 28 ]
- xx [ 5 ] * xx [ 7 ] ) ; xx [ 55 ] = xx [ 42 ] + xx [ 42 ] ; xx [ 42 ] = xx
[ 5 ] * xx [ 11 ] ; xx [ 56 ] = xx [ 3 ] * xx [ 9 ] ; xx [ 9 ] = ( xx [ 42 ]
+ xx [ 56 ] ) * xx [ 10 ] ; xx [ 57 ] = xx [ 9 ] + xx [ 9 ] ; xx [ 9 ] =
0.3522037996671813 ; xx [ 61 ] = xx [ 16 ] * xx [ 38 ] ; xx [ 62 ] = ( xx [
46 ] + xx [ 61 ] ) * xx [ 10 ] ; xx [ 46 ] = ( xx [ 34 ] + xx [ 16 ] * xx [
44 ] ) * xx [ 10 ] ; xx [ 34 ] = xx [ 4 ] * xx [ 7 ] ; xx [ 63 ] = ( xx [ 56
] + xx [ 34 ] ) * xx [ 10 ] ; xx [ 56 ] = xx [ 63 ] + xx [ 63 ] ; xx [ 63 ] =
( xx [ 28 ] + xx [ 4 ] * xx [ 11 ] ) * xx [ 10 ] ; xx [ 28 ] = xx [ 63 ] + xx
[ 63 ] ; xx [ 63 ] = xx [ 32 ] * xx [ 38 ] ; xx [ 64 ] = ( xx [ 63 ] + xx [
18 ] * xx [ 33 ] ) * xx [ 10 ] ; xx [ 65 ] = xx [ 32 ] * xx [ 44 ] ; xx [ 66
] = xx [ 10 ] * ( xx [ 16 ] * xx [ 33 ] - xx [ 65 ] ) ; xx [ 33 ] = xx [ 0 ]
/ sqrt ( state [ 14 ] * state [ 14 ] + state [ 15 ] * state [ 15 ] + state [
16 ] * state [ 16 ] + state [ 17 ] * state [ 17 ] ) ; xx [ 67 ] = xx [ 33 ] *
state [ 14 ] ; xx [ 68 ] = 0.1624769242846504 ; xx [ 69 ] = xx [ 33 ] * state
[ 16 ] ; xx [ 70 ] = xx [ 68 ] * xx [ 69 ] ; xx [ 71 ] = xx [ 67 ] * xx [ 70
] ; xx [ 72 ] = xx [ 33 ] * state [ 17 ] ; xx [ 73 ] = xx [ 33 ] * state [ 15
] ; xx [ 33 ] = xx [ 68 ] * xx [ 73 ] ; xx [ 74 ] = ( xx [ 71 ] + xx [ 72 ] *
xx [ 33 ] ) * xx [ 10 ] ; xx [ 75 ] = xx [ 68 ] * xx [ 72 ] ; xx [ 76 ] = xx
[ 67 ] * xx [ 75 ] ; xx [ 77 ] = xx [ 10 ] * ( xx [ 69 ] * xx [ 33 ] - xx [
76 ] ) ; xx [ 78 ] = 0.04750999999999999 ; xx [ 79 ] = xx [ 78 ] * xx [ 18 ]
; xx [ 80 ] = 8.530000000000001e-3 ; xx [ 81 ] = xx [ 80 ] * xx [ 20 ] ; xx [
82 ] = xx [ 79 ] - xx [ 81 ] ; xx [ 83 ] = xx [ 78 ] * xx [ 16 ] ; xx [ 84 ]
= xx [ 80 ] * xx [ 16 ] ; xx [ 85 ] = xx [ 82 ] ; xx [ 86 ] = - xx [ 83 ] ;
xx [ 87 ] = xx [ 84 ] ; pm_math_cross3 ( xx + 22 , xx + 85 , xx + 88 ) ; xx [
85 ] = 0.07589 ; xx [ 86 ] = xx [ 85 ] * xx [ 18 ] ; xx [ 87 ] = xx [ 85 ] *
xx [ 16 ] ; xx [ 91 ] = xx [ 87 ] + xx [ 81 ] ; xx [ 81 ] = xx [ 80 ] * xx [
18 ] ; xx [ 92 ] = xx [ 86 ] ; xx [ 93 ] = - xx [ 91 ] ; xx [ 94 ] = xx [ 81
] ; pm_math_cross3 ( xx + 22 , xx + 92 , xx + 95 ) ; xx [ 92 ] = 0.24094 ; xx
[ 93 ] = xx [ 85 ] * xx [ 20 ] ; xx [ 94 ] = xx [ 78 ] * xx [ 20 ] ; xx [ 98
] = xx [ 79 ] - xx [ 87 ] ; xx [ 99 ] = xx [ 93 ] ; xx [ 100 ] = - xx [ 94 ]
; xx [ 101 ] = xx [ 98 ] ; pm_math_cross3 ( xx + 22 , xx + 99 , xx + 102 ) ;
xx [ 79 ] = xx [ 67 ] * xx [ 33 ] ; xx [ 87 ] = xx [ 10 ] * ( xx [ 79 ] - xx
[ 72 ] * xx [ 70 ] ) ; xx [ 99 ] = xx [ 72 ] * xx [ 75 ] ; xx [ 100 ] = xx [
73 ] * xx [ 33 ] ; xx [ 33 ] = ( xx [ 99 ] + xx [ 100 ] ) * xx [ 10 ] ; xx [
101 ] = 0.3249538485693007 ; xx [ 105 ] = xx [ 69 ] * xx [ 70 ] ; xx [ 106 ]
= ( xx [ 100 ] + xx [ 105 ] ) * xx [ 10 ] ; xx [ 100 ] = ( xx [ 79 ] + xx [
69 ] * xx [ 75 ] ) * xx [ 10 ] ; xx [ 79 ] = xx [ 0 ] / sqrt ( state [ 21 ] *
state [ 21 ] + state [ 22 ] * state [ 22 ] + state [ 23 ] * state [ 23 ] +
state [ 24 ] * state [ 24 ] ) ; xx [ 107 ] = xx [ 79 ] * state [ 21 ] ; xx [
108 ] = 0.1774935228395673 ; xx [ 109 ] = xx [ 79 ] * state [ 23 ] ; xx [ 110
] = xx [ 108 ] * xx [ 109 ] ; xx [ 111 ] = xx [ 107 ] * xx [ 110 ] ; xx [ 112
] = xx [ 79 ] * state [ 24 ] ; xx [ 113 ] = xx [ 79 ] * state [ 22 ] ; xx [
79 ] = xx [ 108 ] * xx [ 113 ] ; xx [ 114 ] = ( xx [ 111 ] + xx [ 112 ] * xx
[ 79 ] ) * xx [ 10 ] ; xx [ 115 ] = xx [ 114 ] + xx [ 114 ] ; xx [ 114 ] = xx
[ 108 ] * xx [ 112 ] ; xx [ 116 ] = xx [ 107 ] * xx [ 114 ] ; xx [ 117 ] = xx
[ 10 ] * ( xx [ 109 ] * xx [ 79 ] - xx [ 116 ] ) ; xx [ 118 ] = xx [ 117 ] +
xx [ 117 ] ; xx [ 117 ] = 0.05489999999999998 ; xx [ 119 ] = xx [ 117 ] * xx
[ 18 ] ; xx [ 120 ] = 0.09134 ; xx [ 121 ] = xx [ 120 ] * xx [ 20 ] ; xx [
122 ] = xx [ 119 ] - xx [ 121 ] ; xx [ 123 ] = xx [ 117 ] * xx [ 16 ] ; xx [
124 ] = xx [ 120 ] * xx [ 16 ] ; xx [ 125 ] = xx [ 122 ] ; xx [ 126 ] = - xx
[ 123 ] ; xx [ 127 ] = xx [ 124 ] ; pm_math_cross3 ( xx + 22 , xx + 125 , xx
+ 128 ) ; xx [ 125 ] = 0.01565 ; xx [ 126 ] = xx [ 125 ] * xx [ 18 ] ; xx [
127 ] = xx [ 125 ] * xx [ 16 ] ; xx [ 131 ] = xx [ 127 ] - xx [ 121 ] ; xx [
121 ] = xx [ 120 ] * xx [ 18 ] ; xx [ 132 ] = - xx [ 126 ] ; xx [ 133 ] = xx
[ 131 ] ; xx [ 134 ] = xx [ 121 ] ; pm_math_cross3 ( xx + 22 , xx + 132 , xx
+ 135 ) ; xx [ 132 ] = 0.32375 ; xx [ 133 ] = xx [ 125 ] * xx [ 20 ] ; xx [
134 ] = xx [ 117 ] * xx [ 20 ] ; xx [ 138 ] = xx [ 119 ] + xx [ 127 ] ; xx [
139 ] = - xx [ 133 ] ; xx [ 140 ] = - xx [ 134 ] ; xx [ 141 ] = xx [ 138 ] ;
pm_math_cross3 ( xx + 22 , xx + 139 , xx + 142 ) ; xx [ 22 ] = xx [ 107 ] *
xx [ 79 ] ; xx [ 23 ] = xx [ 10 ] * ( xx [ 22 ] - xx [ 112 ] * xx [ 110 ] ) ;
xx [ 24 ] = xx [ 23 ] + xx [ 23 ] ; xx [ 23 ] = xx [ 112 ] * xx [ 114 ] ; xx
[ 119 ] = xx [ 113 ] * xx [ 79 ] ; xx [ 79 ] = ( xx [ 23 ] + xx [ 119 ] ) *
xx [ 10 ] ; xx [ 127 ] = xx [ 79 ] + xx [ 79 ] ; xx [ 79 ] =
0.3549870456791346 ; xx [ 139 ] = xx [ 109 ] * xx [ 110 ] ; xx [ 140 ] = ( xx
[ 119 ] + xx [ 139 ] ) * xx [ 10 ] ; xx [ 119 ] = xx [ 140 ] + xx [ 140 ] ;
xx [ 140 ] = ( xx [ 22 ] + xx [ 109 ] * xx [ 114 ] ) * xx [ 10 ] ; xx [ 22 ]
= xx [ 140 ] + xx [ 140 ] ; xx [ 140 ] = xx [ 0 ] / sqrt ( state [ 7 ] *
state [ 7 ] + state [ 8 ] * state [ 8 ] + state [ 9 ] * state [ 9 ] + state [
10 ] * state [ 10 ] ) ; xx [ 141 ] = xx [ 140 ] * state [ 7 ] ; xx [ 145 ] =
0.1675024183407511 ; xx [ 146 ] = xx [ 140 ] * state [ 9 ] ; xx [ 147 ] = xx
[ 145 ] * xx [ 146 ] ; xx [ 148 ] = xx [ 141 ] * xx [ 147 ] ; xx [ 149 ] = xx
[ 140 ] * state [ 10 ] ; xx [ 150 ] = xx [ 140 ] * state [ 8 ] ; xx [ 140 ] =
xx [ 145 ] * xx [ 150 ] ; xx [ 151 ] = ( xx [ 148 ] + xx [ 149 ] * xx [ 140 ]
) * xx [ 10 ] ; xx [ 152 ] = xx [ 145 ] * xx [ 149 ] ; xx [ 153 ] = xx [ 141
] * xx [ 152 ] ; xx [ 154 ] = xx [ 10 ] * ( xx [ 146 ] * xx [ 140 ] - xx [
153 ] ) ; xx [ 155 ] = xx [ 141 ] * xx [ 140 ] ; xx [ 156 ] = xx [ 10 ] * (
xx [ 155 ] - xx [ 149 ] * xx [ 147 ] ) ; xx [ 157 ] = xx [ 149 ] * xx [ 152 ]
; xx [ 158 ] = xx [ 150 ] * xx [ 140 ] ; xx [ 140 ] = ( xx [ 157 ] + xx [ 158
] ) * xx [ 10 ] ; xx [ 159 ] = 0.3350048366815023 ; xx [ 160 ] = xx [ 146 ] *
xx [ 147 ] ; xx [ 161 ] = ( xx [ 158 ] + xx [ 160 ] ) * xx [ 10 ] ; xx [ 158
] = ( xx [ 155 ] + xx [ 146 ] * xx [ 152 ] ) * xx [ 10 ] ; xx [ 155 ] = xx [
0 ] / sqrt ( state [ 28 ] * state [ 28 ] + state [ 29 ] * state [ 29 ] +
state [ 30 ] * state [ 30 ] + state [ 31 ] * state [ 31 ] ) ; xx [ 162 ] = xx
[ 155 ] * state [ 28 ] ; xx [ 163 ] = 0.1575773583037868 ; xx [ 164 ] = xx [
155 ] * state [ 30 ] ; xx [ 165 ] = xx [ 163 ] * xx [ 164 ] ; xx [ 166 ] = xx
[ 162 ] * xx [ 165 ] ; xx [ 167 ] = xx [ 155 ] * state [ 31 ] ; xx [ 168 ] =
xx [ 155 ] * state [ 29 ] ; xx [ 155 ] = xx [ 163 ] * xx [ 168 ] ; xx [ 169 ]
= ( xx [ 166 ] + xx [ 167 ] * xx [ 155 ] ) * xx [ 10 ] ; xx [ 170 ] = xx [
163 ] * xx [ 167 ] ; xx [ 171 ] = xx [ 162 ] * xx [ 170 ] ; xx [ 172 ] = xx [
10 ] * ( xx [ 164 ] * xx [ 155 ] - xx [ 171 ] ) ; xx [ 173 ] = xx [ 162 ] *
xx [ 155 ] ; xx [ 174 ] = xx [ 10 ] * ( xx [ 173 ] - xx [ 167 ] * xx [ 165 ]
) ; xx [ 175 ] = xx [ 167 ] * xx [ 170 ] ; xx [ 176 ] = xx [ 168 ] * xx [ 155
] ; xx [ 155 ] = ( xx [ 175 ] + xx [ 176 ] ) * xx [ 10 ] ; xx [ 177 ] =
0.3151547166075735 ; xx [ 178 ] = xx [ 164 ] * xx [ 165 ] ; xx [ 179 ] = ( xx
[ 176 ] + xx [ 178 ] ) * xx [ 10 ] ; xx [ 176 ] = ( xx [ 173 ] + xx [ 164 ] *
xx [ 170 ] ) * xx [ 10 ] ; xx [ 180 ] = xx [ 1 ] ; xx [ 181 ] = xx [ 12 ] ;
xx [ 182 ] = - xx [ 15 ] ; xx [ 183 ] = xx [ 1 ] ; xx [ 184 ] = xx [ 1 ] ; xx
[ 185 ] = xx [ 1 ] ; xx [ 186 ] = xx [ 1 ] ; xx [ 187 ] = xx [ 1 ] ; xx [ 188
] = xx [ 1 ] ; xx [ 189 ] = xx [ 1 ] ; xx [ 190 ] = xx [ 1 ] ; xx [ 191 ] =
xx [ 1 ] ; xx [ 192 ] = xx [ 1 ] ; xx [ 193 ] = xx [ 1 ] ; xx [ 194 ] = xx [
1 ] ; xx [ 195 ] = xx [ 0 ] ; xx [ 196 ] = xx [ 1 ] ; xx [ 197 ] = xx [ 10 ]
* ( xx [ 35 ] - xx [ 32 ] * xx [ 29 ] ) + xx [ 39 ] ; xx [ 198 ] = ( xx [ 47
] - xx [ 32 ] * xx [ 41 ] ) * xx [ 10 ] - xx [ 50 ] + xx [ 51 ] ; xx [ 199 ]
= xx [ 27 ] + xx [ 10 ] * ( xx [ 58 ] - xx [ 32 ] * xx [ 52 ] ) ; xx [ 200 ]
= xx [ 1 ] ; xx [ 201 ] = - xx [ 55 ] ; xx [ 202 ] = xx [ 57 ] - xx [ 9 ] ;
xx [ 203 ] = xx [ 1 ] ; xx [ 204 ] = xx [ 1 ] ; xx [ 205 ] = xx [ 1 ] ; xx [
206 ] = xx [ 1 ] ; xx [ 207 ] = xx [ 1 ] ; xx [ 208 ] = xx [ 1 ] ; xx [ 209 ]
= xx [ 1 ] ; xx [ 210 ] = xx [ 1 ] ; xx [ 211 ] = xx [ 1 ] ; xx [ 212 ] = xx
[ 1 ] ; xx [ 213 ] = xx [ 1 ] ; xx [ 214 ] = xx [ 1 ] ; xx [ 215 ] = xx [ 1 ]
; xx [ 216 ] = xx [ 0 ] ; xx [ 217 ] = xx [ 10 ] * ( xx [ 36 ] + xx [ 32 ] *
xx [ 30 ] ) + xx [ 62 ] - xx [ 51 ] ; xx [ 218 ] = xx [ 10 ] * ( xx [ 48 ] -
xx [ 32 ] * xx [ 43 ] ) + xx [ 46 ] ; xx [ 219 ] = xx [ 40 ] + ( xx [ 32 ] *
xx [ 53 ] + xx [ 59 ] ) * xx [ 10 ] ; xx [ 220 ] = xx [ 1 ] ; xx [ 221 ] = xx
[ 9 ] - xx [ 56 ] ; xx [ 222 ] = - xx [ 28 ] ; xx [ 223 ] = xx [ 1 ] ; xx [
224 ] = xx [ 1 ] ; xx [ 225 ] = xx [ 1 ] ; xx [ 226 ] = xx [ 1 ] ; xx [ 227 ]
= xx [ 1 ] ; xx [ 228 ] = xx [ 1 ] ; xx [ 229 ] = xx [ 1 ] ; xx [ 230 ] = xx
[ 1 ] ; xx [ 231 ] = xx [ 1 ] ; xx [ 232 ] = xx [ 1 ] ; xx [ 233 ] = xx [ 1 ]
; xx [ 234 ] = xx [ 1 ] ; xx [ 235 ] = xx [ 1 ] ; xx [ 236 ] = xx [ 1 ] ; xx
[ 237 ] = ( xx [ 31 ] * xx [ 32 ] + xx [ 37 ] ) * xx [ 10 ] - xx [ 64 ] - xx
[ 27 ] ; xx [ 238 ] = xx [ 10 ] * ( xx [ 49 ] + xx [ 26 ] * xx [ 32 ] ) + xx
[ 66 ] - xx [ 40 ] ; xx [ 239 ] = xx [ 10 ] * ( xx [ 60 ] - xx [ 32 ] * xx [
54 ] ) ; xx [ 240 ] = xx [ 1 ] ; xx [ 241 ] = xx [ 1 ] ; xx [ 242 ] = xx [ 1
] ; xx [ 243 ] = xx [ 1 ] ; xx [ 244 ] = xx [ 1 ] ; xx [ 245 ] = xx [ 1 ] ;
xx [ 246 ] = xx [ 1 ] ; xx [ 247 ] = xx [ 74 ] + xx [ 74 ] ; xx [ 248 ] = - (
xx [ 77 ] + xx [ 77 ] ) ; xx [ 249 ] = xx [ 1 ] ; xx [ 250 ] = xx [ 1 ] ; xx
[ 251 ] = xx [ 1 ] ; xx [ 252 ] = xx [ 1 ] ; xx [ 253 ] = xx [ 1 ] ; xx [ 254
] = xx [ 1 ] ; xx [ 255 ] = xx [ 0 ] ; xx [ 256 ] = xx [ 1 ] ; xx [ 257 ] =
xx [ 10 ] * ( xx [ 88 ] - xx [ 32 ] * xx [ 82 ] ) + xx [ 39 ] ; xx [ 258 ] =
( xx [ 95 ] - xx [ 32 ] * xx [ 86 ] ) * xx [ 10 ] - xx [ 50 ] + xx [ 92 ] ;
xx [ 259 ] = xx [ 78 ] + xx [ 10 ] * ( xx [ 102 ] - xx [ 32 ] * xx [ 93 ] ) ;
xx [ 260 ] = xx [ 1 ] ; xx [ 261 ] = xx [ 1 ] ; xx [ 262 ] = xx [ 1 ] ; xx [
263 ] = xx [ 1 ] ; xx [ 264 ] = xx [ 1 ] ; xx [ 265 ] = xx [ 1 ] ; xx [ 266 ]
= xx [ 1 ] ; xx [ 267 ] = - ( xx [ 87 ] + xx [ 87 ] ) ; xx [ 268 ] = xx [ 33
] + xx [ 33 ] - xx [ 101 ] ; xx [ 269 ] = xx [ 1 ] ; xx [ 270 ] = xx [ 1 ] ;
xx [ 271 ] = xx [ 1 ] ; xx [ 272 ] = xx [ 1 ] ; xx [ 273 ] = xx [ 1 ] ; xx [
274 ] = xx [ 1 ] ; xx [ 275 ] = xx [ 1 ] ; xx [ 276 ] = xx [ 0 ] ; xx [ 277 ]
= xx [ 10 ] * ( xx [ 89 ] + xx [ 32 ] * xx [ 83 ] ) + xx [ 62 ] - xx [ 92 ] ;
xx [ 278 ] = xx [ 10 ] * ( xx [ 96 ] + xx [ 32 ] * xx [ 91 ] ) + xx [ 46 ] ;
xx [ 279 ] = xx [ 85 ] + ( xx [ 32 ] * xx [ 94 ] + xx [ 103 ] ) * xx [ 10 ] ;
xx [ 280 ] = xx [ 1 ] ; xx [ 281 ] = xx [ 1 ] ; xx [ 282 ] = xx [ 1 ] ; xx [
283 ] = xx [ 1 ] ; xx [ 284 ] = xx [ 1 ] ; xx [ 285 ] = xx [ 1 ] ; xx [ 286 ]
= xx [ 1 ] ; xx [ 287 ] = xx [ 101 ] - ( xx [ 106 ] + xx [ 106 ] ) ; xx [ 288
] = - ( xx [ 100 ] + xx [ 100 ] ) ; xx [ 289 ] = xx [ 1 ] ; xx [ 290 ] = xx [
1 ] ; xx [ 291 ] = xx [ 1 ] ; xx [ 292 ] = xx [ 1 ] ; xx [ 293 ] = xx [ 1 ] ;
xx [ 294 ] = xx [ 1 ] ; xx [ 295 ] = xx [ 1 ] ; xx [ 296 ] = xx [ 1 ] ; xx [
297 ] = ( xx [ 90 ] - xx [ 32 ] * xx [ 84 ] ) * xx [ 10 ] - xx [ 64 ] - xx [
78 ] ; xx [ 298 ] = xx [ 10 ] * ( xx [ 97 ] - xx [ 32 ] * xx [ 81 ] ) + xx [
66 ] - xx [ 85 ] ; xx [ 299 ] = xx [ 10 ] * ( xx [ 104 ] - xx [ 32 ] * xx [
98 ] ) ; xx [ 300 ] = xx [ 1 ] ; xx [ 301 ] = xx [ 1 ] ; xx [ 302 ] = xx [ 1
] ; xx [ 303 ] = xx [ 1 ] ; xx [ 304 ] = xx [ 1 ] ; xx [ 305 ] = xx [ 1 ] ;
xx [ 306 ] = xx [ 1 ] ; xx [ 307 ] = xx [ 1 ] ; xx [ 308 ] = xx [ 1 ] ; xx [
309 ] = xx [ 1 ] ; xx [ 310 ] = xx [ 115 ] ; xx [ 311 ] = - xx [ 118 ] ; xx [
312 ] = xx [ 1 ] ; xx [ 313 ] = xx [ 1 ] ; xx [ 314 ] = xx [ 1 ] ; xx [ 315 ]
= xx [ 0 ] ; xx [ 316 ] = xx [ 1 ] ; xx [ 317 ] = xx [ 10 ] * ( xx [ 128 ] -
xx [ 32 ] * xx [ 122 ] ) + xx [ 39 ] ; xx [ 318 ] = ( xx [ 126 ] * xx [ 32 ]
+ xx [ 135 ] ) * xx [ 10 ] - xx [ 50 ] + xx [ 132 ] ; xx [ 319 ] = xx [ 117 ]
+ xx [ 10 ] * ( xx [ 142 ] + xx [ 133 ] * xx [ 32 ] ) ; xx [ 320 ] = xx [ 1 ]
; xx [ 321 ] = xx [ 1 ] ; xx [ 322 ] = xx [ 1 ] ; xx [ 323 ] = xx [ 1 ] ; xx
[ 324 ] = xx [ 1 ] ; xx [ 325 ] = xx [ 1 ] ; xx [ 326 ] = xx [ 1 ] ; xx [ 327
] = xx [ 1 ] ; xx [ 328 ] = xx [ 1 ] ; xx [ 329 ] = xx [ 1 ] ; xx [ 330 ] = -
xx [ 24 ] ; xx [ 331 ] = xx [ 127 ] - xx [ 79 ] ; xx [ 332 ] = xx [ 1 ] ; xx
[ 333 ] = xx [ 1 ] ; xx [ 334 ] = xx [ 1 ] ; xx [ 335 ] = xx [ 1 ] ; xx [ 336
] = xx [ 0 ] ; xx [ 337 ] = xx [ 10 ] * ( xx [ 129 ] + xx [ 32 ] * xx [ 123 ]
) + xx [ 62 ] - xx [ 132 ] ; xx [ 338 ] = xx [ 10 ] * ( xx [ 136 ] - xx [ 32
] * xx [ 131 ] ) + xx [ 46 ] ; xx [ 339 ] = ( xx [ 32 ] * xx [ 134 ] + xx [
143 ] ) * xx [ 10 ] - xx [ 125 ] ; xx [ 340 ] = xx [ 1 ] ; xx [ 341 ] = xx [
1 ] ; xx [ 342 ] = xx [ 1 ] ; xx [ 343 ] = xx [ 1 ] ; xx [ 344 ] = xx [ 1 ] ;
xx [ 345 ] = xx [ 1 ] ; xx [ 346 ] = xx [ 1 ] ; xx [ 347 ] = xx [ 1 ] ; xx [
348 ] = xx [ 1 ] ; xx [ 349 ] = xx [ 1 ] ; xx [ 350 ] = xx [ 79 ] - xx [ 119
] ; xx [ 351 ] = - xx [ 22 ] ; xx [ 352 ] = xx [ 1 ] ; xx [ 353 ] = xx [ 1 ]
; xx [ 354 ] = xx [ 1 ] ; xx [ 355 ] = xx [ 1 ] ; xx [ 356 ] = xx [ 1 ] ; xx
[ 357 ] = ( xx [ 130 ] - xx [ 32 ] * xx [ 124 ] ) * xx [ 10 ] - xx [ 64 ] -
xx [ 117 ] ; xx [ 358 ] = xx [ 10 ] * ( xx [ 137 ] - xx [ 32 ] * xx [ 121 ] )
+ xx [ 66 ] + xx [ 125 ] ; xx [ 359 ] = xx [ 10 ] * ( xx [ 144 ] - xx [ 32 ]
* xx [ 138 ] ) ; xx [ 360 ] = xx [ 1 ] ; xx [ 361 ] = - xx [ 12 ] ; xx [ 362
] = xx [ 15 ] ; xx [ 363 ] = xx [ 1 ] ; xx [ 364 ] = xx [ 151 ] + xx [ 151 ]
; xx [ 365 ] = - ( xx [ 154 ] + xx [ 154 ] ) ; xx [ 366 ] = xx [ 1 ] ; xx [
367 ] = xx [ 1 ] ; xx [ 368 ] = xx [ 1 ] ; xx [ 369 ] = xx [ 1 ] ; xx [ 370 ]
= xx [ 1 ] ; xx [ 371 ] = xx [ 1 ] ; xx [ 372 ] = xx [ 1 ] ; xx [ 373 ] = xx
[ 1 ] ; xx [ 374 ] = xx [ 1 ] ; xx [ 375 ] = xx [ 1 ] ; xx [ 376 ] = xx [ 1 ]
; xx [ 377 ] = xx [ 1 ] ; xx [ 378 ] = xx [ 1 ] ; xx [ 379 ] = xx [ 1 ] ; xx
[ 380 ] = xx [ 1 ] ; xx [ 381 ] = xx [ 55 ] ; xx [ 382 ] = xx [ 9 ] - xx [ 57
] ; xx [ 383 ] = xx [ 1 ] ; xx [ 384 ] = - ( xx [ 156 ] + xx [ 156 ] ) ; xx [
385 ] = xx [ 140 ] + xx [ 140 ] - xx [ 159 ] ; xx [ 386 ] = xx [ 1 ] ; xx [
387 ] = xx [ 1 ] ; xx [ 388 ] = xx [ 1 ] ; xx [ 389 ] = xx [ 1 ] ; xx [ 390 ]
= xx [ 1 ] ; xx [ 391 ] = xx [ 1 ] ; xx [ 392 ] = xx [ 1 ] ; xx [ 393 ] = xx
[ 1 ] ; xx [ 394 ] = xx [ 1 ] ; xx [ 395 ] = xx [ 1 ] ; xx [ 396 ] = xx [ 1 ]
; xx [ 397 ] = xx [ 1 ] ; xx [ 398 ] = xx [ 1 ] ; xx [ 399 ] = xx [ 1 ] ; xx
[ 400 ] = xx [ 1 ] ; xx [ 401 ] = xx [ 56 ] - xx [ 9 ] ; xx [ 402 ] = xx [ 28
] ; xx [ 403 ] = xx [ 1 ] ; xx [ 404 ] = xx [ 159 ] - ( xx [ 161 ] + xx [ 161
] ) ; xx [ 405 ] = - ( xx [ 158 ] + xx [ 158 ] ) ; xx [ 406 ] = xx [ 1 ] ; xx
[ 407 ] = xx [ 1 ] ; xx [ 408 ] = xx [ 1 ] ; xx [ 409 ] = xx [ 1 ] ; xx [ 410
] = xx [ 1 ] ; xx [ 411 ] = xx [ 1 ] ; xx [ 412 ] = xx [ 1 ] ; xx [ 413 ] =
xx [ 1 ] ; xx [ 414 ] = xx [ 1 ] ; xx [ 415 ] = xx [ 1 ] ; xx [ 416 ] = xx [
1 ] ; xx [ 417 ] = xx [ 1 ] ; xx [ 418 ] = xx [ 1 ] ; xx [ 419 ] = xx [ 1 ] ;
xx [ 420 ] = xx [ 1 ] ; xx [ 421 ] = xx [ 1 ] ; xx [ 422 ] = xx [ 1 ] ; xx [
423 ] = xx [ 1 ] ; xx [ 424 ] = xx [ 1 ] ; xx [ 425 ] = xx [ 1 ] ; xx [ 426 ]
= xx [ 1 ] ; xx [ 427 ] = xx [ 1 ] ; xx [ 428 ] = xx [ 1 ] ; xx [ 429 ] = xx
[ 1 ] ; xx [ 430 ] = - xx [ 115 ] ; xx [ 431 ] = xx [ 118 ] ; xx [ 432 ] = xx
[ 1 ] ; xx [ 433 ] = xx [ 169 ] + xx [ 169 ] ; xx [ 434 ] = - ( xx [ 172 ] +
xx [ 172 ] ) ; xx [ 435 ] = xx [ 1 ] ; xx [ 436 ] = xx [ 1 ] ; xx [ 437 ] =
xx [ 1 ] ; xx [ 438 ] = xx [ 1 ] ; xx [ 439 ] = xx [ 1 ] ; xx [ 440 ] = xx [
1 ] ; xx [ 441 ] = xx [ 1 ] ; xx [ 442 ] = xx [ 1 ] ; xx [ 443 ] = xx [ 1 ] ;
xx [ 444 ] = xx [ 1 ] ; xx [ 445 ] = xx [ 1 ] ; xx [ 446 ] = xx [ 1 ] ; xx [
447 ] = xx [ 1 ] ; xx [ 448 ] = xx [ 1 ] ; xx [ 449 ] = xx [ 1 ] ; xx [ 450 ]
= xx [ 24 ] ; xx [ 451 ] = xx [ 79 ] - xx [ 127 ] ; xx [ 452 ] = xx [ 1 ] ;
xx [ 453 ] = - ( xx [ 174 ] + xx [ 174 ] ) ; xx [ 454 ] = xx [ 155 ] + xx [
155 ] - xx [ 177 ] ; xx [ 455 ] = xx [ 1 ] ; xx [ 456 ] = xx [ 1 ] ; xx [ 457
] = xx [ 1 ] ; xx [ 458 ] = xx [ 1 ] ; xx [ 459 ] = xx [ 1 ] ; xx [ 460 ] =
xx [ 1 ] ; xx [ 461 ] = xx [ 1 ] ; xx [ 462 ] = xx [ 1 ] ; xx [ 463 ] = xx [
1 ] ; xx [ 464 ] = xx [ 1 ] ; xx [ 465 ] = xx [ 1 ] ; xx [ 466 ] = xx [ 1 ] ;
xx [ 467 ] = xx [ 1 ] ; xx [ 468 ] = xx [ 1 ] ; xx [ 469 ] = xx [ 1 ] ; xx [
470 ] = xx [ 119 ] - xx [ 79 ] ; xx [ 471 ] = xx [ 22 ] ; xx [ 472 ] = xx [ 1
] ; xx [ 473 ] = xx [ 177 ] - ( xx [ 179 ] + xx [ 179 ] ) ; xx [ 474 ] = - (
xx [ 176 ] + xx [ 176 ] ) ; xx [ 475 ] = xx [ 1 ] ; xx [ 476 ] = xx [ 1 ] ;
xx [ 477 ] = xx [ 1 ] ; xx [ 478 ] = xx [ 1 ] ; xx [ 479 ] = xx [ 1 ] ; xx [
12 ] = ( xx [ 34 ] + xx [ 42 ] ) * xx [ 10 ] ; xx [ 15 ] = 0.3530818998335906
; xx [ 22 ] = xx [ 6 ] - xx [ 12 ] + xx [ 15 ] - xx [ 12 ] ; xx [ 28 ] = - xx
[ 32 ] ; xx [ 29 ] = xx [ 17 ] ; xx [ 30 ] = xx [ 19 ] ; xx [ 31 ] = xx [ 21
] ; xx [ 33 ] = xx [ 40 ] ; xx [ 34 ] = - xx [ 27 ] ; xx [ 35 ] = - xx [ 25 ]
; pm_math_quatXform ( xx + 28 , xx + 33 , xx + 41 ) ; xx [ 12 ] = ( xx [ 65 ]
+ xx [ 20 ] * xx [ 38 ] ) * xx [ 10 ] + state [ 35 ] ; xx [ 17 ] = ( xx [ 13
] + xx [ 3 ] * xx [ 7 ] ) * xx [ 10 ] ; xx [ 7 ] = 0.2523 ; xx [ 13 ] = xx [
17 ] + xx [ 7 ] + xx [ 17 ] ; xx [ 17 ] = xx [ 10 ] * ( xx [ 20 ] * xx [ 44 ]
- xx [ 63 ] ) + state [ 36 ] ; xx [ 19 ] = xx [ 10 ] * ( xx [ 3 ] * xx [ 11 ]
- xx [ 8 ] ) ; xx [ 8 ] = 0.12489 ; xx [ 11 ] = xx [ 19 ] + xx [ 8 ] + xx [
19 ] ; xx [ 19 ] = state [ 37 ] - ( xx [ 61 ] + xx [ 45 ] ) * xx [ 10 ] + xx
[ 14 ] ; xx [ 36 ] = xx [ 85 ] ; xx [ 37 ] = - xx [ 78 ] ; xx [ 38 ] = xx [
80 ] ; pm_math_quatXform ( xx + 28 , xx + 36 , xx + 44 ) ; xx [ 21 ] = ( xx [
105 ] + xx [ 99 ] ) * xx [ 10 ] ; xx [ 24 ] = 0.4008438485693007 ; xx [ 26 ]
= ( xx [ 76 ] + xx [ 73 ] * xx [ 70 ] ) * xx [ 10 ] ; xx [ 39 ] = 0.23 ; xx [
47 ] = xx [ 10 ] * ( xx [ 73 ] * xx [ 75 ] - xx [ 71 ] ) ; xx [ 48 ] = 0.201
; xx [ 49 ] = ( xx [ 139 ] + xx [ 23 ] ) * xx [ 10 ] ; xx [ 23 ] =
0.3560035228395673 ; xx [ 50 ] = xx [ 108 ] - xx [ 49 ] + xx [ 23 ] - xx [ 49
] ; xx [ 52 ] = - xx [ 125 ] ; xx [ 53 ] = - xx [ 117 ] ; xx [ 54 ] = xx [
120 ] ; pm_math_quatXform ( xx + 28 , xx + 52 , xx + 55 ) ; xx [ 28 ] = ( xx
[ 116 ] + xx [ 113 ] * xx [ 110 ] ) * xx [ 10 ] ; xx [ 29 ] = 0.25087 ; xx [
30 ] = xx [ 28 ] + xx [ 29 ] + xx [ 28 ] ; xx [ 28 ] = xx [ 10 ] * ( xx [ 113
] * xx [ 114 ] - xx [ 111 ] ) ; xx [ 31 ] = 0.28196 ; xx [ 49 ] = xx [ 28 ] +
xx [ 31 ] + xx [ 28 ] ; xx [ 28 ] = ( xx [ 160 ] + xx [ 157 ] ) * xx [ 10 ] ;
xx [ 58 ] = 0.1598848366815023 ; xx [ 59 ] = ( xx [ 153 ] + xx [ 150 ] * xx [
147 ] ) * xx [ 10 ] ; xx [ 60 ] = 0.28187 ; xx [ 61 ] = xx [ 10 ] * ( xx [
150 ] * xx [ 152 ] - xx [ 148 ] ) ; xx [ 62 ] = 0.12641 ; xx [ 63 ] = ( xx [
178 ] + xx [ 175 ] ) * xx [ 10 ] ; xx [ 64 ] = 0.1374147166075735 ; xx [ 65 ]
= ( xx [ 171 ] + xx [ 168 ] * xx [ 165 ] ) * xx [ 10 ] ; xx [ 66 ] = 0.28138
; xx [ 70 ] = xx [ 10 ] * ( xx [ 168 ] * xx [ 170 ] - xx [ 166 ] ) ; xx [ 71
] = 0.26458 ; xx [ 480 ] = xx [ 22 ] - ( xx [ 41 ] + xx [ 12 ] ) ; xx [ 481 ]
= xx [ 13 ] - ( xx [ 42 ] + xx [ 17 ] ) ; xx [ 482 ] = xx [ 11 ] - ( xx [ 43
] + xx [ 19 ] ) ; xx [ 483 ] = - ( xx [ 44 ] + xx [ 12 ] + xx [ 21 ] + xx [
21 ] - xx [ 24 ] ) ; xx [ 484 ] = - ( xx [ 45 ] + xx [ 17 ] - ( xx [ 26 ] +
xx [ 26 ] ) - xx [ 39 ] ) ; xx [ 485 ] = - ( xx [ 46 ] + xx [ 19 ] - ( xx [
47 ] + xx [ 47 ] ) - xx [ 48 ] ) ; xx [ 486 ] = xx [ 50 ] - ( xx [ 55 ] + xx
[ 12 ] ) ; xx [ 487 ] = xx [ 30 ] - ( xx [ 56 ] + xx [ 17 ] ) ; xx [ 488 ] =
xx [ 49 ] - ( xx [ 57 ] + xx [ 19 ] ) ; xx [ 489 ] = - ( xx [ 22 ] + xx [ 28
] + xx [ 28 ] - xx [ 58 ] ) ; xx [ 490 ] = - ( xx [ 13 ] - ( xx [ 59 ] + xx [
59 ] ) - xx [ 60 ] ) ; xx [ 491 ] = - ( xx [ 11 ] - ( xx [ 61 ] + xx [ 61 ] )
- xx [ 62 ] ) ; xx [ 492 ] = - ( xx [ 50 ] + xx [ 63 ] + xx [ 63 ] - xx [ 64
] ) ; xx [ 493 ] = - ( xx [ 30 ] - ( xx [ 65 ] + xx [ 65 ] ) - xx [ 66 ] ) ;
xx [ 494 ] = - ( xx [ 49 ] - ( xx [ 70 ] + xx [ 70 ] ) - xx [ 71 ] ) ; xx [
11 ] = 1.0e-8 ; memcpy ( xx + 515 , xx + 180 , 300 * sizeof ( double ) ) ;
factorAndSolveWide ( 15 , 20 , xx + 515 , xx + 815 , xx + 830 , ii + 0 , xx +
480 , xx [ 11 ] , xx + 495 ) ; pm_math_quatDeriv ( xx + 2 , xx + 495 , xx +
41 ) ; xx [ 12 ] = xx [ 2 ] + xx [ 41 ] ; xx [ 2 ] = xx [ 3 ] + xx [ 42 ] ;
xx [ 3 ] = xx [ 4 ] + xx [ 43 ] ; xx [ 4 ] = xx [ 5 ] + xx [ 44 ] ; xx [ 5 ]
= 1.0e-64 ; xx [ 13 ] = sqrt ( xx [ 12 ] * xx [ 12 ] + xx [ 2 ] * xx [ 2 ] +
xx [ 3 ] * xx [ 3 ] + xx [ 4 ] * xx [ 4 ] ) ; if ( xx [ 5 ] > xx [ 13 ] ) xx
[ 13 ] = xx [ 5 ] ; xx [ 17 ] = xx [ 12 ] / xx [ 13 ] ; xx [ 12 ] = xx [ 2 ]
/ xx [ 13 ] ; xx [ 2 ] = xx [ 3 ] / xx [ 13 ] ; xx [ 3 ] = xx [ 4 ] / xx [ 13
] ; xx [ 41 ] = xx [ 17 ] ; xx [ 42 ] = xx [ 12 ] ; xx [ 43 ] = xx [ 2 ] ; xx
[ 44 ] = xx [ 3 ] ; xx [ 4 ] = xx [ 6 ] * xx [ 2 ] ; xx [ 13 ] = xx [ 17 ] *
xx [ 4 ] ; xx [ 19 ] = xx [ 6 ] * xx [ 12 ] ; xx [ 21 ] = ( xx [ 13 ] + xx [
3 ] * xx [ 19 ] ) * xx [ 10 ] ; xx [ 22 ] = xx [ 21 ] + xx [ 21 ] ; xx [ 21 ]
= xx [ 6 ] * xx [ 3 ] ; xx [ 26 ] = xx [ 17 ] * xx [ 21 ] ; xx [ 28 ] = xx [
10 ] * ( xx [ 2 ] * xx [ 19 ] - xx [ 26 ] ) ; xx [ 30 ] = xx [ 28 ] + xx [ 28
] ; xx [ 74 ] = xx [ 32 ] ; xx [ 75 ] = xx [ 16 ] ; xx [ 76 ] = xx [ 18 ] ;
xx [ 77 ] = xx [ 20 ] ; pm_math_quatDeriv ( xx + 74 , xx + 512 , xx + 81 ) ;
xx [ 28 ] = xx [ 16 ] + xx [ 82 ] ; xx [ 16 ] = xx [ 32 ] + xx [ 81 ] ; xx [
32 ] = xx [ 18 ] + xx [ 83 ] ; xx [ 18 ] = xx [ 20 ] + xx [ 84 ] ; xx [ 20 ]
= sqrt ( xx [ 16 ] * xx [ 16 ] + xx [ 28 ] * xx [ 28 ] + xx [ 32 ] * xx [ 32
] + xx [ 18 ] * xx [ 18 ] ) ; if ( xx [ 5 ] > xx [ 20 ] ) xx [ 20 ] = xx [ 5
] ; xx [ 45 ] = xx [ 28 ] / xx [ 20 ] ; xx [ 28 ] = - xx [ 45 ] ; xx [ 46 ] =
xx [ 32 ] / xx [ 20 ] ; xx [ 32 ] = - xx [ 46 ] ; xx [ 47 ] = xx [ 18 ] / xx
[ 20 ] ; xx [ 18 ] = - xx [ 47 ] ; xx [ 55 ] = xx [ 28 ] ; xx [ 56 ] = xx [
32 ] ; xx [ 57 ] = xx [ 18 ] ; xx [ 49 ] = xx [ 25 ] * xx [ 47 ] ; xx [ 50 ]
= xx [ 27 ] * xx [ 46 ] ; xx [ 59 ] = xx [ 49 ] + xx [ 50 ] ; xx [ 61 ] = xx
[ 27 ] * xx [ 45 ] ; xx [ 63 ] = xx [ 25 ] * xx [ 45 ] ; xx [ 74 ] = xx [ 59
] ; xx [ 75 ] = - xx [ 61 ] ; xx [ 76 ] = - xx [ 63 ] ; pm_math_cross3 ( xx +
55 , xx + 74 , xx + 81 ) ; xx [ 65 ] = xx [ 16 ] / xx [ 20 ] ; xx [ 16 ] = xx
[ 14 ] * xx [ 47 ] ; xx [ 20 ] = xx [ 65 ] * xx [ 16 ] ; xx [ 70 ] = xx [ 14
] * xx [ 45 ] ; xx [ 74 ] = xx [ 10 ] * ( xx [ 20 ] - xx [ 46 ] * xx [ 70 ] )
; xx [ 75 ] = xx [ 40 ] * xx [ 46 ] ; xx [ 76 ] = xx [ 40 ] * xx [ 45 ] ; xx
[ 77 ] = xx [ 49 ] - xx [ 76 ] ; xx [ 49 ] = xx [ 25 ] * xx [ 46 ] ; xx [ 86
] = xx [ 75 ] ; xx [ 87 ] = xx [ 77 ] ; xx [ 88 ] = - xx [ 49 ] ;
pm_math_cross3 ( xx + 55 , xx + 86 , xx + 89 ) ; xx [ 84 ] = xx [ 14 ] * xx [
46 ] ; xx [ 86 ] = xx [ 46 ] * xx [ 84 ] ; xx [ 87 ] = xx [ 47 ] * xx [ 16 ]
; xx [ 88 ] = ( xx [ 86 ] + xx [ 87 ] ) * xx [ 10 ] ; xx [ 93 ] = xx [ 40 ] *
xx [ 47 ] ; xx [ 94 ] = xx [ 27 ] * xx [ 47 ] ; xx [ 95 ] = xx [ 50 ] - xx [
76 ] ; xx [ 96 ] = xx [ 93 ] ; xx [ 97 ] = - xx [ 94 ] ; xx [ 98 ] = xx [ 95
] ; pm_math_cross3 ( xx + 55 , xx + 96 , xx + 102 ) ; xx [ 50 ] = xx [ 17 ] *
xx [ 19 ] ; xx [ 76 ] = xx [ 10 ] * ( xx [ 50 ] - xx [ 3 ] * xx [ 4 ] ) ; xx
[ 96 ] = xx [ 76 ] + xx [ 76 ] ; xx [ 76 ] = xx [ 3 ] * xx [ 21 ] ; xx [ 97 ]
= xx [ 12 ] * xx [ 19 ] ; xx [ 19 ] = ( xx [ 76 ] + xx [ 97 ] ) * xx [ 10 ] ;
xx [ 98 ] = xx [ 19 ] + xx [ 19 ] ; xx [ 19 ] = xx [ 45 ] * xx [ 70 ] ; xx [
99 ] = ( xx [ 87 ] + xx [ 19 ] ) * xx [ 10 ] ; xx [ 87 ] = ( xx [ 20 ] + xx [
45 ] * xx [ 84 ] ) * xx [ 10 ] ; xx [ 20 ] = xx [ 2 ] * xx [ 4 ] ; xx [ 100 ]
= ( xx [ 97 ] + xx [ 20 ] ) * xx [ 10 ] ; xx [ 97 ] = xx [ 100 ] + xx [ 100 ]
; xx [ 100 ] = ( xx [ 50 ] + xx [ 2 ] * xx [ 21 ] ) * xx [ 10 ] ; xx [ 50 ] =
xx [ 100 ] + xx [ 100 ] ; xx [ 100 ] = xx [ 65 ] * xx [ 70 ] ; xx [ 105 ] = (
xx [ 100 ] + xx [ 46 ] * xx [ 16 ] ) * xx [ 10 ] ; xx [ 106 ] = xx [ 65 ] *
xx [ 84 ] ; xx [ 110 ] = xx [ 10 ] * ( xx [ 45 ] * xx [ 16 ] - xx [ 106 ] ) ;
xx [ 121 ] = xx [ 67 ] ; xx [ 122 ] = xx [ 73 ] ; xx [ 123 ] = xx [ 69 ] ; xx
[ 124 ] = xx [ 72 ] ; pm_math_quatDeriv ( xx + 121 , xx + 501 , xx + 126 ) ;
xx [ 16 ] = xx [ 67 ] + xx [ 126 ] ; xx [ 67 ] = xx [ 73 ] + xx [ 127 ] ; xx
[ 73 ] = xx [ 69 ] + xx [ 128 ] ; xx [ 69 ] = xx [ 72 ] + xx [ 129 ] ; xx [
72 ] = sqrt ( xx [ 16 ] * xx [ 16 ] + xx [ 67 ] * xx [ 67 ] + xx [ 73 ] * xx
[ 73 ] + xx [ 69 ] * xx [ 69 ] ) ; if ( xx [ 5 ] > xx [ 72 ] ) xx [ 72 ] = xx
[ 5 ] ; xx [ 111 ] = xx [ 16 ] / xx [ 72 ] ; xx [ 16 ] = xx [ 73 ] / xx [ 72
] ; xx [ 73 ] = xx [ 68 ] * xx [ 16 ] ; xx [ 114 ] = xx [ 111 ] * xx [ 73 ] ;
xx [ 115 ] = xx [ 69 ] / xx [ 72 ] ; xx [ 69 ] = xx [ 67 ] / xx [ 72 ] ; xx [
67 ] = xx [ 68 ] * xx [ 69 ] ; xx [ 72 ] = ( xx [ 114 ] + xx [ 115 ] * xx [
67 ] ) * xx [ 10 ] ; xx [ 116 ] = xx [ 68 ] * xx [ 115 ] ; xx [ 118 ] = xx [
111 ] * xx [ 116 ] ; xx [ 119 ] = xx [ 10 ] * ( xx [ 16 ] * xx [ 67 ] - xx [
118 ] ) ; xx [ 121 ] = xx [ 78 ] * xx [ 46 ] ; xx [ 122 ] = xx [ 80 ] * xx [
47 ] ; xx [ 123 ] = xx [ 121 ] - xx [ 122 ] ; xx [ 124 ] = xx [ 78 ] * xx [
45 ] ; xx [ 126 ] = xx [ 80 ] * xx [ 45 ] ; xx [ 127 ] = xx [ 123 ] ; xx [
128 ] = - xx [ 124 ] ; xx [ 129 ] = xx [ 126 ] ; pm_math_cross3 ( xx + 55 ,
xx + 127 , xx + 133 ) ; xx [ 127 ] = xx [ 85 ] * xx [ 46 ] ; xx [ 128 ] = xx
[ 85 ] * xx [ 45 ] ; xx [ 129 ] = xx [ 128 ] + xx [ 122 ] ; xx [ 122 ] = xx [
80 ] * xx [ 46 ] ; xx [ 136 ] = xx [ 127 ] ; xx [ 137 ] = - xx [ 129 ] ; xx [
138 ] = xx [ 122 ] ; pm_math_cross3 ( xx + 55 , xx + 136 , xx + 142 ) ; xx [
130 ] = xx [ 85 ] * xx [ 47 ] ; xx [ 131 ] = xx [ 78 ] * xx [ 47 ] ; xx [ 136
] = xx [ 121 ] - xx [ 128 ] ; xx [ 137 ] = xx [ 130 ] ; xx [ 138 ] = - xx [
131 ] ; xx [ 139 ] = xx [ 136 ] ; pm_math_cross3 ( xx + 55 , xx + 137 , xx +
151 ) ; xx [ 121 ] = xx [ 111 ] * xx [ 67 ] ; xx [ 128 ] = xx [ 10 ] * ( xx [
121 ] - xx [ 115 ] * xx [ 73 ] ) ; xx [ 137 ] = xx [ 115 ] * xx [ 116 ] ; xx
[ 138 ] = xx [ 69 ] * xx [ 67 ] ; xx [ 67 ] = ( xx [ 137 ] + xx [ 138 ] ) *
xx [ 10 ] ; xx [ 139 ] = xx [ 16 ] * xx [ 73 ] ; xx [ 140 ] = ( xx [ 138 ] +
xx [ 139 ] ) * xx [ 10 ] ; xx [ 138 ] = ( xx [ 121 ] + xx [ 16 ] * xx [ 116 ]
) * xx [ 10 ] ; xx [ 154 ] = xx [ 107 ] ; xx [ 155 ] = xx [ 113 ] ; xx [ 156
] = xx [ 109 ] ; xx [ 157 ] = xx [ 112 ] ; pm_math_quatDeriv ( xx + 154 , xx
+ 504 , xx + 169 ) ; xx [ 121 ] = xx [ 107 ] + xx [ 169 ] ; xx [ 107 ] = xx [
113 ] + xx [ 170 ] ; xx [ 113 ] = xx [ 109 ] + xx [ 171 ] ; xx [ 109 ] = xx [
112 ] + xx [ 172 ] ; xx [ 112 ] = sqrt ( xx [ 121 ] * xx [ 121 ] + xx [ 107 ]
* xx [ 107 ] + xx [ 113 ] * xx [ 113 ] + xx [ 109 ] * xx [ 109 ] ) ; if ( xx
[ 5 ] > xx [ 112 ] ) xx [ 112 ] = xx [ 5 ] ; xx [ 147 ] = xx [ 121 ] / xx [
112 ] ; xx [ 121 ] = xx [ 113 ] / xx [ 112 ] ; xx [ 113 ] = xx [ 108 ] * xx [
121 ] ; xx [ 148 ] = xx [ 147 ] * xx [ 113 ] ; xx [ 154 ] = xx [ 109 ] / xx [
112 ] ; xx [ 109 ] = xx [ 107 ] / xx [ 112 ] ; xx [ 107 ] = xx [ 108 ] * xx [
109 ] ; xx [ 112 ] = ( xx [ 148 ] + xx [ 154 ] * xx [ 107 ] ) * xx [ 10 ] ;
xx [ 155 ] = xx [ 112 ] + xx [ 112 ] ; xx [ 112 ] = xx [ 108 ] * xx [ 154 ] ;
xx [ 156 ] = xx [ 147 ] * xx [ 112 ] ; xx [ 157 ] = xx [ 10 ] * ( xx [ 121 ]
* xx [ 107 ] - xx [ 156 ] ) ; xx [ 158 ] = xx [ 157 ] + xx [ 157 ] ; xx [ 157
] = xx [ 117 ] * xx [ 46 ] ; xx [ 160 ] = xx [ 120 ] * xx [ 47 ] ; xx [ 161 ]
= xx [ 157 ] - xx [ 160 ] ; xx [ 165 ] = xx [ 117 ] * xx [ 45 ] ; xx [ 166 ]
= xx [ 120 ] * xx [ 45 ] ; xx [ 169 ] = xx [ 161 ] ; xx [ 170 ] = - xx [ 165
] ; xx [ 171 ] = xx [ 166 ] ; pm_math_cross3 ( xx + 55 , xx + 169 , xx + 172
) ; xx [ 169 ] = xx [ 125 ] * xx [ 46 ] ; xx [ 170 ] = xx [ 125 ] * xx [ 45 ]
; xx [ 171 ] = xx [ 170 ] - xx [ 160 ] ; xx [ 160 ] = xx [ 120 ] * xx [ 46 ]
; xx [ 178 ] = - xx [ 169 ] ; xx [ 179 ] = xx [ 171 ] ; xx [ 180 ] = xx [ 160
] ; pm_math_cross3 ( xx + 55 , xx + 178 , xx + 181 ) ; xx [ 175 ] = xx [ 125
] * xx [ 47 ] ; xx [ 176 ] = xx [ 117 ] * xx [ 47 ] ; xx [ 178 ] = xx [ 157 ]
+ xx [ 170 ] ; xx [ 184 ] = - xx [ 175 ] ; xx [ 185 ] = - xx [ 176 ] ; xx [
186 ] = xx [ 178 ] ; pm_math_cross3 ( xx + 55 , xx + 184 , xx + 187 ) ; xx [
55 ] = xx [ 147 ] * xx [ 107 ] ; xx [ 56 ] = xx [ 10 ] * ( xx [ 55 ] - xx [
154 ] * xx [ 113 ] ) ; xx [ 57 ] = xx [ 56 ] + xx [ 56 ] ; xx [ 56 ] = xx [
154 ] * xx [ 112 ] ; xx [ 157 ] = xx [ 109 ] * xx [ 107 ] ; xx [ 107 ] = ( xx
[ 56 ] + xx [ 157 ] ) * xx [ 10 ] ; xx [ 170 ] = xx [ 107 ] + xx [ 107 ] ; xx
[ 107 ] = xx [ 121 ] * xx [ 113 ] ; xx [ 179 ] = ( xx [ 157 ] + xx [ 107 ] )
* xx [ 10 ] ; xx [ 157 ] = xx [ 179 ] + xx [ 179 ] ; xx [ 179 ] = ( xx [ 55 ]
+ xx [ 121 ] * xx [ 112 ] ) * xx [ 10 ] ; xx [ 55 ] = xx [ 179 ] + xx [ 179 ]
; xx [ 190 ] = xx [ 141 ] ; xx [ 191 ] = xx [ 150 ] ; xx [ 192 ] = xx [ 146 ]
; xx [ 193 ] = xx [ 149 ] ; pm_math_quatDeriv ( xx + 190 , xx + 498 , xx +
194 ) ; xx [ 179 ] = xx [ 141 ] + xx [ 194 ] ; xx [ 141 ] = xx [ 150 ] + xx [
195 ] ; xx [ 150 ] = xx [ 146 ] + xx [ 196 ] ; xx [ 146 ] = xx [ 149 ] + xx [
197 ] ; xx [ 149 ] = sqrt ( xx [ 179 ] * xx [ 179 ] + xx [ 141 ] * xx [ 141 ]
+ xx [ 150 ] * xx [ 150 ] + xx [ 146 ] * xx [ 146 ] ) ; if ( xx [ 5 ] > xx [
149 ] ) xx [ 149 ] = xx [ 5 ] ; xx [ 180 ] = xx [ 179 ] / xx [ 149 ] ; xx [
179 ] = xx [ 150 ] / xx [ 149 ] ; xx [ 150 ] = xx [ 145 ] * xx [ 179 ] ; xx [
184 ] = xx [ 180 ] * xx [ 150 ] ; xx [ 185 ] = xx [ 146 ] / xx [ 149 ] ; xx [
146 ] = xx [ 141 ] / xx [ 149 ] ; xx [ 141 ] = xx [ 145 ] * xx [ 146 ] ; xx [
149 ] = ( xx [ 184 ] + xx [ 185 ] * xx [ 141 ] ) * xx [ 10 ] ; xx [ 186 ] =
xx [ 145 ] * xx [ 185 ] ; xx [ 190 ] = xx [ 180 ] * xx [ 186 ] ; xx [ 191 ] =
xx [ 10 ] * ( xx [ 179 ] * xx [ 141 ] - xx [ 190 ] ) ; xx [ 192 ] = xx [ 180
] * xx [ 141 ] ; xx [ 193 ] = xx [ 10 ] * ( xx [ 192 ] - xx [ 185 ] * xx [
150 ] ) ; xx [ 194 ] = xx [ 185 ] * xx [ 186 ] ; xx [ 195 ] = xx [ 146 ] * xx
[ 141 ] ; xx [ 141 ] = ( xx [ 194 ] + xx [ 195 ] ) * xx [ 10 ] ; xx [ 196 ] =
xx [ 179 ] * xx [ 150 ] ; xx [ 197 ] = ( xx [ 195 ] + xx [ 196 ] ) * xx [ 10
] ; xx [ 195 ] = ( xx [ 192 ] + xx [ 179 ] * xx [ 186 ] ) * xx [ 10 ] ; xx [
198 ] = xx [ 162 ] ; xx [ 199 ] = xx [ 168 ] ; xx [ 200 ] = xx [ 164 ] ; xx [
201 ] = xx [ 167 ] ; pm_math_quatDeriv ( xx + 198 , xx + 507 , xx + 202 ) ;
xx [ 192 ] = xx [ 162 ] + xx [ 202 ] ; xx [ 162 ] = xx [ 168 ] + xx [ 203 ] ;
xx [ 168 ] = xx [ 164 ] + xx [ 204 ] ; xx [ 164 ] = xx [ 167 ] + xx [ 205 ] ;
xx [ 167 ] = sqrt ( xx [ 192 ] * xx [ 192 ] + xx [ 162 ] * xx [ 162 ] + xx [
168 ] * xx [ 168 ] + xx [ 164 ] * xx [ 164 ] ) ; if ( xx [ 5 ] > xx [ 167 ] )
xx [ 167 ] = xx [ 5 ] ; xx [ 198 ] = xx [ 192 ] / xx [ 167 ] ; xx [ 192 ] =
xx [ 168 ] / xx [ 167 ] ; xx [ 168 ] = xx [ 163 ] * xx [ 192 ] ; xx [ 199 ] =
xx [ 198 ] * xx [ 168 ] ; xx [ 200 ] = xx [ 164 ] / xx [ 167 ] ; xx [ 164 ] =
xx [ 162 ] / xx [ 167 ] ; xx [ 162 ] = xx [ 163 ] * xx [ 164 ] ; xx [ 167 ] =
( xx [ 199 ] + xx [ 200 ] * xx [ 162 ] ) * xx [ 10 ] ; xx [ 201 ] = xx [ 163
] * xx [ 200 ] ; xx [ 202 ] = xx [ 198 ] * xx [ 201 ] ; xx [ 203 ] = xx [ 10
] * ( xx [ 192 ] * xx [ 162 ] - xx [ 202 ] ) ; xx [ 204 ] = xx [ 198 ] * xx [
162 ] ; xx [ 205 ] = xx [ 10 ] * ( xx [ 204 ] - xx [ 200 ] * xx [ 168 ] ) ;
xx [ 206 ] = xx [ 200 ] * xx [ 201 ] ; xx [ 207 ] = xx [ 164 ] * xx [ 162 ] ;
xx [ 162 ] = ( xx [ 206 ] + xx [ 207 ] ) * xx [ 10 ] ; xx [ 208 ] = xx [ 192
] * xx [ 168 ] ; xx [ 209 ] = ( xx [ 207 ] + xx [ 208 ] ) * xx [ 10 ] ; xx [
207 ] = ( xx [ 204 ] + xx [ 192 ] * xx [ 201 ] ) * xx [ 10 ] ; xx [ 515 ] =
xx [ 1 ] ; xx [ 516 ] = xx [ 22 ] ; xx [ 517 ] = - xx [ 30 ] ; xx [ 518 ] =
xx [ 1 ] ; xx [ 519 ] = xx [ 1 ] ; xx [ 520 ] = xx [ 1 ] ; xx [ 521 ] = xx [
1 ] ; xx [ 522 ] = xx [ 1 ] ; xx [ 523 ] = xx [ 1 ] ; xx [ 524 ] = xx [ 1 ] ;
xx [ 525 ] = xx [ 1 ] ; xx [ 526 ] = xx [ 1 ] ; xx [ 527 ] = xx [ 1 ] ; xx [
528 ] = xx [ 1 ] ; xx [ 529 ] = xx [ 1 ] ; xx [ 530 ] = xx [ 0 ] ; xx [ 531 ]
= xx [ 1 ] ; xx [ 532 ] = xx [ 10 ] * ( xx [ 81 ] - xx [ 65 ] * xx [ 59 ] ) +
xx [ 74 ] ; xx [ 533 ] = ( xx [ 89 ] - xx [ 65 ] * xx [ 75 ] ) * xx [ 10 ] -
xx [ 88 ] + xx [ 51 ] ; xx [ 534 ] = xx [ 27 ] + xx [ 10 ] * ( xx [ 102 ] -
xx [ 65 ] * xx [ 93 ] ) ; xx [ 535 ] = xx [ 1 ] ; xx [ 536 ] = - xx [ 96 ] ;
xx [ 537 ] = xx [ 98 ] - xx [ 9 ] ; xx [ 538 ] = xx [ 1 ] ; xx [ 539 ] = xx [
1 ] ; xx [ 540 ] = xx [ 1 ] ; xx [ 541 ] = xx [ 1 ] ; xx [ 542 ] = xx [ 1 ] ;
xx [ 543 ] = xx [ 1 ] ; xx [ 544 ] = xx [ 1 ] ; xx [ 545 ] = xx [ 1 ] ; xx [
546 ] = xx [ 1 ] ; xx [ 547 ] = xx [ 1 ] ; xx [ 548 ] = xx [ 1 ] ; xx [ 549 ]
= xx [ 1 ] ; xx [ 550 ] = xx [ 1 ] ; xx [ 551 ] = xx [ 0 ] ; xx [ 552 ] = xx
[ 10 ] * ( xx [ 82 ] + xx [ 65 ] * xx [ 61 ] ) + xx [ 99 ] - xx [ 51 ] ; xx [
553 ] = xx [ 10 ] * ( xx [ 90 ] - xx [ 65 ] * xx [ 77 ] ) + xx [ 87 ] ; xx [
554 ] = xx [ 40 ] + ( xx [ 65 ] * xx [ 94 ] + xx [ 103 ] ) * xx [ 10 ] ; xx [
555 ] = xx [ 1 ] ; xx [ 556 ] = xx [ 9 ] - xx [ 97 ] ; xx [ 557 ] = - xx [ 50
] ; xx [ 558 ] = xx [ 1 ] ; xx [ 559 ] = xx [ 1 ] ; xx [ 560 ] = xx [ 1 ] ;
xx [ 561 ] = xx [ 1 ] ; xx [ 562 ] = xx [ 1 ] ; xx [ 563 ] = xx [ 1 ] ; xx [
564 ] = xx [ 1 ] ; xx [ 565 ] = xx [ 1 ] ; xx [ 566 ] = xx [ 1 ] ; xx [ 567 ]
= xx [ 1 ] ; xx [ 568 ] = xx [ 1 ] ; xx [ 569 ] = xx [ 1 ] ; xx [ 570 ] = xx
[ 1 ] ; xx [ 571 ] = xx [ 1 ] ; xx [ 572 ] = ( xx [ 65 ] * xx [ 63 ] + xx [
83 ] ) * xx [ 10 ] - xx [ 105 ] - xx [ 27 ] ; xx [ 573 ] = xx [ 10 ] * ( xx [
91 ] + xx [ 65 ] * xx [ 49 ] ) + xx [ 110 ] - xx [ 40 ] ; xx [ 574 ] = xx [
10 ] * ( xx [ 104 ] - xx [ 65 ] * xx [ 95 ] ) ; xx [ 575 ] = xx [ 1 ] ; xx [
576 ] = xx [ 1 ] ; xx [ 577 ] = xx [ 1 ] ; xx [ 578 ] = xx [ 1 ] ; xx [ 579 ]
= xx [ 1 ] ; xx [ 580 ] = xx [ 1 ] ; xx [ 581 ] = xx [ 1 ] ; xx [ 582 ] = xx
[ 72 ] + xx [ 72 ] ; xx [ 583 ] = - ( xx [ 119 ] + xx [ 119 ] ) ; xx [ 584 ]
= xx [ 1 ] ; xx [ 585 ] = xx [ 1 ] ; xx [ 586 ] = xx [ 1 ] ; xx [ 587 ] = xx
[ 1 ] ; xx [ 588 ] = xx [ 1 ] ; xx [ 589 ] = xx [ 1 ] ; xx [ 590 ] = xx [ 0 ]
; xx [ 591 ] = xx [ 1 ] ; xx [ 592 ] = xx [ 10 ] * ( xx [ 133 ] - xx [ 65 ] *
xx [ 123 ] ) + xx [ 74 ] ; xx [ 593 ] = ( xx [ 142 ] - xx [ 65 ] * xx [ 127 ]
) * xx [ 10 ] - xx [ 88 ] + xx [ 92 ] ; xx [ 594 ] = xx [ 78 ] + xx [ 10 ] *
( xx [ 151 ] - xx [ 65 ] * xx [ 130 ] ) ; xx [ 595 ] = xx [ 1 ] ; xx [ 596 ]
= xx [ 1 ] ; xx [ 597 ] = xx [ 1 ] ; xx [ 598 ] = xx [ 1 ] ; xx [ 599 ] = xx
[ 1 ] ; xx [ 600 ] = xx [ 1 ] ; xx [ 601 ] = xx [ 1 ] ; xx [ 602 ] = - ( xx [
128 ] + xx [ 128 ] ) ; xx [ 603 ] = xx [ 67 ] + xx [ 67 ] - xx [ 101 ] ; xx [
604 ] = xx [ 1 ] ; xx [ 605 ] = xx [ 1 ] ; xx [ 606 ] = xx [ 1 ] ; xx [ 607 ]
= xx [ 1 ] ; xx [ 608 ] = xx [ 1 ] ; xx [ 609 ] = xx [ 1 ] ; xx [ 610 ] = xx
[ 1 ] ; xx [ 611 ] = xx [ 0 ] ; xx [ 612 ] = xx [ 10 ] * ( xx [ 134 ] + xx [
65 ] * xx [ 124 ] ) + xx [ 99 ] - xx [ 92 ] ; xx [ 613 ] = xx [ 10 ] * ( xx [
143 ] + xx [ 65 ] * xx [ 129 ] ) + xx [ 87 ] ; xx [ 614 ] = xx [ 85 ] + ( xx
[ 65 ] * xx [ 131 ] + xx [ 152 ] ) * xx [ 10 ] ; xx [ 615 ] = xx [ 1 ] ; xx [
616 ] = xx [ 1 ] ; xx [ 617 ] = xx [ 1 ] ; xx [ 618 ] = xx [ 1 ] ; xx [ 619 ]
= xx [ 1 ] ; xx [ 620 ] = xx [ 1 ] ; xx [ 621 ] = xx [ 1 ] ; xx [ 622 ] = xx
[ 101 ] - ( xx [ 140 ] + xx [ 140 ] ) ; xx [ 623 ] = - ( xx [ 138 ] + xx [
138 ] ) ; xx [ 624 ] = xx [ 1 ] ; xx [ 625 ] = xx [ 1 ] ; xx [ 626 ] = xx [ 1
] ; xx [ 627 ] = xx [ 1 ] ; xx [ 628 ] = xx [ 1 ] ; xx [ 629 ] = xx [ 1 ] ;
xx [ 630 ] = xx [ 1 ] ; xx [ 631 ] = xx [ 1 ] ; xx [ 632 ] = ( xx [ 135 ] -
xx [ 65 ] * xx [ 126 ] ) * xx [ 10 ] - xx [ 105 ] - xx [ 78 ] ; xx [ 633 ] =
xx [ 10 ] * ( xx [ 144 ] - xx [ 65 ] * xx [ 122 ] ) + xx [ 110 ] - xx [ 85 ]
; xx [ 634 ] = xx [ 10 ] * ( xx [ 153 ] - xx [ 65 ] * xx [ 136 ] ) ; xx [ 635
] = xx [ 1 ] ; xx [ 636 ] = xx [ 1 ] ; xx [ 637 ] = xx [ 1 ] ; xx [ 638 ] =
xx [ 1 ] ; xx [ 639 ] = xx [ 1 ] ; xx [ 640 ] = xx [ 1 ] ; xx [ 641 ] = xx [
1 ] ; xx [ 642 ] = xx [ 1 ] ; xx [ 643 ] = xx [ 1 ] ; xx [ 644 ] = xx [ 1 ] ;
xx [ 645 ] = xx [ 155 ] ; xx [ 646 ] = - xx [ 158 ] ; xx [ 647 ] = xx [ 1 ] ;
xx [ 648 ] = xx [ 1 ] ; xx [ 649 ] = xx [ 1 ] ; xx [ 650 ] = xx [ 0 ] ; xx [
651 ] = xx [ 1 ] ; xx [ 652 ] = xx [ 10 ] * ( xx [ 172 ] - xx [ 65 ] * xx [
161 ] ) + xx [ 74 ] ; xx [ 653 ] = ( xx [ 65 ] * xx [ 169 ] + xx [ 181 ] ) *
xx [ 10 ] - xx [ 88 ] + xx [ 132 ] ; xx [ 654 ] = xx [ 117 ] + xx [ 10 ] * (
xx [ 187 ] + xx [ 65 ] * xx [ 175 ] ) ; xx [ 655 ] = xx [ 1 ] ; xx [ 656 ] =
xx [ 1 ] ; xx [ 657 ] = xx [ 1 ] ; xx [ 658 ] = xx [ 1 ] ; xx [ 659 ] = xx [
1 ] ; xx [ 660 ] = xx [ 1 ] ; xx [ 661 ] = xx [ 1 ] ; xx [ 662 ] = xx [ 1 ] ;
xx [ 663 ] = xx [ 1 ] ; xx [ 664 ] = xx [ 1 ] ; xx [ 665 ] = - xx [ 57 ] ; xx
[ 666 ] = xx [ 170 ] - xx [ 79 ] ; xx [ 667 ] = xx [ 1 ] ; xx [ 668 ] = xx [
1 ] ; xx [ 669 ] = xx [ 1 ] ; xx [ 670 ] = xx [ 1 ] ; xx [ 671 ] = xx [ 0 ] ;
xx [ 672 ] = xx [ 10 ] * ( xx [ 173 ] + xx [ 65 ] * xx [ 165 ] ) + xx [ 99 ]
- xx [ 132 ] ; xx [ 673 ] = xx [ 10 ] * ( xx [ 182 ] - xx [ 65 ] * xx [ 171 ]
) + xx [ 87 ] ; xx [ 674 ] = ( xx [ 65 ] * xx [ 176 ] + xx [ 188 ] ) * xx [
10 ] - xx [ 125 ] ; xx [ 675 ] = xx [ 1 ] ; xx [ 676 ] = xx [ 1 ] ; xx [ 677
] = xx [ 1 ] ; xx [ 678 ] = xx [ 1 ] ; xx [ 679 ] = xx [ 1 ] ; xx [ 680 ] =
xx [ 1 ] ; xx [ 681 ] = xx [ 1 ] ; xx [ 682 ] = xx [ 1 ] ; xx [ 683 ] = xx [
1 ] ; xx [ 684 ] = xx [ 1 ] ; xx [ 685 ] = xx [ 79 ] - xx [ 157 ] ; xx [ 686
] = - xx [ 55 ] ; xx [ 687 ] = xx [ 1 ] ; xx [ 688 ] = xx [ 1 ] ; xx [ 689 ]
= xx [ 1 ] ; xx [ 690 ] = xx [ 1 ] ; xx [ 691 ] = xx [ 1 ] ; xx [ 692 ] = (
xx [ 174 ] - xx [ 65 ] * xx [ 166 ] ) * xx [ 10 ] - xx [ 105 ] - xx [ 117 ] ;
xx [ 693 ] = xx [ 10 ] * ( xx [ 183 ] - xx [ 65 ] * xx [ 160 ] ) + xx [ 110 ]
+ xx [ 125 ] ; xx [ 694 ] = xx [ 10 ] * ( xx [ 189 ] - xx [ 65 ] * xx [ 178 ]
) ; xx [ 695 ] = xx [ 1 ] ; xx [ 696 ] = - xx [ 22 ] ; xx [ 697 ] = xx [ 30 ]
; xx [ 698 ] = xx [ 1 ] ; xx [ 699 ] = xx [ 149 ] + xx [ 149 ] ; xx [ 700 ] =
- ( xx [ 191 ] + xx [ 191 ] ) ; xx [ 701 ] = xx [ 1 ] ; xx [ 702 ] = xx [ 1 ]
; xx [ 703 ] = xx [ 1 ] ; xx [ 704 ] = xx [ 1 ] ; xx [ 705 ] = xx [ 1 ] ; xx
[ 706 ] = xx [ 1 ] ; xx [ 707 ] = xx [ 1 ] ; xx [ 708 ] = xx [ 1 ] ; xx [ 709
] = xx [ 1 ] ; xx [ 710 ] = xx [ 1 ] ; xx [ 711 ] = xx [ 1 ] ; xx [ 712 ] =
xx [ 1 ] ; xx [ 713 ] = xx [ 1 ] ; xx [ 714 ] = xx [ 1 ] ; xx [ 715 ] = xx [
1 ] ; xx [ 716 ] = xx [ 96 ] ; xx [ 717 ] = xx [ 9 ] - xx [ 98 ] ; xx [ 718 ]
= xx [ 1 ] ; xx [ 719 ] = - ( xx [ 193 ] + xx [ 193 ] ) ; xx [ 720 ] = xx [
141 ] + xx [ 141 ] - xx [ 159 ] ; xx [ 721 ] = xx [ 1 ] ; xx [ 722 ] = xx [ 1
] ; xx [ 723 ] = xx [ 1 ] ; xx [ 724 ] = xx [ 1 ] ; xx [ 725 ] = xx [ 1 ] ;
xx [ 726 ] = xx [ 1 ] ; xx [ 727 ] = xx [ 1 ] ; xx [ 728 ] = xx [ 1 ] ; xx [
729 ] = xx [ 1 ] ; xx [ 730 ] = xx [ 1 ] ; xx [ 731 ] = xx [ 1 ] ; xx [ 732 ]
= xx [ 1 ] ; xx [ 733 ] = xx [ 1 ] ; xx [ 734 ] = xx [ 1 ] ; xx [ 735 ] = xx
[ 1 ] ; xx [ 736 ] = xx [ 97 ] - xx [ 9 ] ; xx [ 737 ] = xx [ 50 ] ; xx [ 738
] = xx [ 1 ] ; xx [ 739 ] = xx [ 159 ] - ( xx [ 197 ] + xx [ 197 ] ) ; xx [
740 ] = - ( xx [ 195 ] + xx [ 195 ] ) ; xx [ 741 ] = xx [ 1 ] ; xx [ 742 ] =
xx [ 1 ] ; xx [ 743 ] = xx [ 1 ] ; xx [ 744 ] = xx [ 1 ] ; xx [ 745 ] = xx [
1 ] ; xx [ 746 ] = xx [ 1 ] ; xx [ 747 ] = xx [ 1 ] ; xx [ 748 ] = xx [ 1 ] ;
xx [ 749 ] = xx [ 1 ] ; xx [ 750 ] = xx [ 1 ] ; xx [ 751 ] = xx [ 1 ] ; xx [
752 ] = xx [ 1 ] ; xx [ 753 ] = xx [ 1 ] ; xx [ 754 ] = xx [ 1 ] ; xx [ 755 ]
= xx [ 1 ] ; xx [ 756 ] = xx [ 1 ] ; xx [ 757 ] = xx [ 1 ] ; xx [ 758 ] = xx
[ 1 ] ; xx [ 759 ] = xx [ 1 ] ; xx [ 760 ] = xx [ 1 ] ; xx [ 761 ] = xx [ 1 ]
; xx [ 762 ] = xx [ 1 ] ; xx [ 763 ] = xx [ 1 ] ; xx [ 764 ] = xx [ 1 ] ; xx
[ 765 ] = - xx [ 155 ] ; xx [ 766 ] = xx [ 158 ] ; xx [ 767 ] = xx [ 1 ] ; xx
[ 768 ] = xx [ 167 ] + xx [ 167 ] ; xx [ 769 ] = - ( xx [ 203 ] + xx [ 203 ]
) ; xx [ 770 ] = xx [ 1 ] ; xx [ 771 ] = xx [ 1 ] ; xx [ 772 ] = xx [ 1 ] ;
xx [ 773 ] = xx [ 1 ] ; xx [ 774 ] = xx [ 1 ] ; xx [ 775 ] = xx [ 1 ] ; xx [
776 ] = xx [ 1 ] ; xx [ 777 ] = xx [ 1 ] ; xx [ 778 ] = xx [ 1 ] ; xx [ 779 ]
= xx [ 1 ] ; xx [ 780 ] = xx [ 1 ] ; xx [ 781 ] = xx [ 1 ] ; xx [ 782 ] = xx
[ 1 ] ; xx [ 783 ] = xx [ 1 ] ; xx [ 784 ] = xx [ 1 ] ; xx [ 785 ] = xx [ 57
] ; xx [ 786 ] = xx [ 79 ] - xx [ 170 ] ; xx [ 787 ] = xx [ 1 ] ; xx [ 788 ]
= - ( xx [ 205 ] + xx [ 205 ] ) ; xx [ 789 ] = xx [ 162 ] + xx [ 162 ] - xx [
177 ] ; xx [ 790 ] = xx [ 1 ] ; xx [ 791 ] = xx [ 1 ] ; xx [ 792 ] = xx [ 1 ]
; xx [ 793 ] = xx [ 1 ] ; xx [ 794 ] = xx [ 1 ] ; xx [ 795 ] = xx [ 1 ] ; xx
[ 796 ] = xx [ 1 ] ; xx [ 797 ] = xx [ 1 ] ; xx [ 798 ] = xx [ 1 ] ; xx [ 799
] = xx [ 1 ] ; xx [ 800 ] = xx [ 1 ] ; xx [ 801 ] = xx [ 1 ] ; xx [ 802 ] =
xx [ 1 ] ; xx [ 803 ] = xx [ 1 ] ; xx [ 804 ] = xx [ 1 ] ; xx [ 805 ] = xx [
157 ] - xx [ 79 ] ; xx [ 806 ] = xx [ 55 ] ; xx [ 807 ] = xx [ 1 ] ; xx [ 808
] = xx [ 177 ] - ( xx [ 209 ] + xx [ 209 ] ) ; xx [ 809 ] = - ( xx [ 207 ] +
xx [ 207 ] ) ; xx [ 810 ] = xx [ 1 ] ; xx [ 811 ] = xx [ 1 ] ; xx [ 812 ] =
xx [ 1 ] ; xx [ 813 ] = xx [ 1 ] ; xx [ 814 ] = xx [ 1 ] ; xx [ 22 ] = ( xx [
20 ] + xx [ 76 ] ) * xx [ 10 ] ; xx [ 20 ] = xx [ 6 ] - xx [ 22 ] + xx [ 15 ]
- xx [ 22 ] ; xx [ 74 ] = - xx [ 65 ] ; xx [ 75 ] = xx [ 28 ] ; xx [ 76 ] =
xx [ 32 ] ; xx [ 77 ] = xx [ 18 ] ; pm_math_quatXform ( xx + 74 , xx + 33 ,
xx + 81 ) ; xx [ 18 ] = state [ 35 ] + xx [ 510 ] ; xx [ 22 ] = ( xx [ 106 ]
+ xx [ 47 ] * xx [ 70 ] ) * xx [ 10 ] + xx [ 18 ] ; xx [ 28 ] = ( xx [ 26 ] +
xx [ 12 ] * xx [ 4 ] ) * xx [ 10 ] ; xx [ 4 ] = xx [ 28 ] + xx [ 7 ] + xx [
28 ] ; xx [ 26 ] = state [ 36 ] + xx [ 511 ] ; xx [ 28 ] = xx [ 10 ] * ( xx [
47 ] * xx [ 84 ] - xx [ 100 ] ) + xx [ 26 ] ; xx [ 30 ] = xx [ 10 ] * ( xx [
12 ] * xx [ 21 ] - xx [ 13 ] ) ; xx [ 13 ] = xx [ 30 ] + xx [ 8 ] + xx [ 30 ]
; xx [ 21 ] = state [ 37 ] - ( xx [ 19 ] + xx [ 86 ] ) * xx [ 10 ] + xx [ 14
] ; pm_math_quatXform ( xx + 74 , xx + 36 , xx + 86 ) ; xx [ 19 ] = ( xx [
139 ] + xx [ 137 ] ) * xx [ 10 ] ; xx [ 30 ] = ( xx [ 118 ] + xx [ 69 ] * xx
[ 73 ] ) * xx [ 10 ] ; xx [ 32 ] = xx [ 10 ] * ( xx [ 69 ] * xx [ 116 ] - xx
[ 114 ] ) ; xx [ 49 ] = ( xx [ 107 ] + xx [ 56 ] ) * xx [ 10 ] ; xx [ 50 ] =
xx [ 108 ] - xx [ 49 ] + xx [ 23 ] - xx [ 49 ] ; pm_math_quatXform ( xx + 74
, xx + 52 , xx + 55 ) ; xx [ 49 ] = ( xx [ 156 ] + xx [ 109 ] * xx [ 113 ] )
* xx [ 10 ] ; xx [ 59 ] = xx [ 49 ] + xx [ 29 ] + xx [ 49 ] ; xx [ 49 ] = xx
[ 10 ] * ( xx [ 109 ] * xx [ 112 ] - xx [ 148 ] ) ; xx [ 61 ] = xx [ 49 ] +
xx [ 31 ] + xx [ 49 ] ; xx [ 49 ] = ( xx [ 196 ] + xx [ 194 ] ) * xx [ 10 ] ;
xx [ 63 ] = ( xx [ 190 ] + xx [ 146 ] * xx [ 150 ] ) * xx [ 10 ] ; xx [ 67 ]
= xx [ 10 ] * ( xx [ 146 ] * xx [ 186 ] - xx [ 184 ] ) ; xx [ 70 ] = ( xx [
208 ] + xx [ 206 ] ) * xx [ 10 ] ; xx [ 72 ] = ( xx [ 202 ] + xx [ 164 ] * xx
[ 168 ] ) * xx [ 10 ] ; xx [ 73 ] = xx [ 10 ] * ( xx [ 164 ] * xx [ 201 ] -
xx [ 199 ] ) ; xx [ 201 ] = xx [ 20 ] - ( xx [ 81 ] + xx [ 22 ] ) ; xx [ 202
] = xx [ 4 ] - ( xx [ 82 ] + xx [ 28 ] ) ; xx [ 203 ] = xx [ 13 ] - ( xx [ 83
] + xx [ 21 ] ) ; xx [ 204 ] = - ( xx [ 86 ] + xx [ 22 ] + xx [ 19 ] + xx [
19 ] - xx [ 24 ] ) ; xx [ 205 ] = - ( xx [ 87 ] + xx [ 28 ] - ( xx [ 30 ] +
xx [ 30 ] ) - xx [ 39 ] ) ; xx [ 206 ] = - ( xx [ 88 ] + xx [ 21 ] - ( xx [
32 ] + xx [ 32 ] ) - xx [ 48 ] ) ; xx [ 207 ] = xx [ 50 ] - ( xx [ 55 ] + xx
[ 22 ] ) ; xx [ 208 ] = xx [ 59 ] - ( xx [ 56 ] + xx [ 28 ] ) ; xx [ 209 ] =
xx [ 61 ] - ( xx [ 57 ] + xx [ 21 ] ) ; xx [ 210 ] = - ( xx [ 20 ] + xx [ 49
] + xx [ 49 ] - xx [ 58 ] ) ; xx [ 211 ] = - ( xx [ 4 ] - ( xx [ 63 ] + xx [
63 ] ) - xx [ 60 ] ) ; xx [ 212 ] = - ( xx [ 13 ] - ( xx [ 67 ] + xx [ 67 ] )
- xx [ 62 ] ) ; xx [ 213 ] = - ( xx [ 50 ] + xx [ 70 ] + xx [ 70 ] - xx [ 64
] ) ; xx [ 214 ] = - ( xx [ 59 ] - ( xx [ 72 ] + xx [ 72 ] ) - xx [ 66 ] ) ;
xx [ 215 ] = - ( xx [ 61 ] - ( xx [ 73 ] + xx [ 73 ] ) - xx [ 71 ] ) ; memcpy
( xx + 815 , xx + 515 , 300 * sizeof ( double ) ) ; factorAndSolveWide ( 15 ,
20 , xx + 815 , xx + 236 , xx + 251 , ii + 0 , xx + 201 , xx [ 11 ] , xx +
216 ) ; pm_math_quatDeriv ( xx + 41 , xx + 216 , xx + 19 ) ; xx [ 4 ] = xx [
17 ] + xx [ 19 ] ; xx [ 13 ] = xx [ 12 ] + xx [ 20 ] ; xx [ 12 ] = xx [ 2 ] +
xx [ 21 ] ; xx [ 2 ] = xx [ 3 ] + xx [ 22 ] ; xx [ 3 ] = sqrt ( xx [ 4 ] * xx
[ 4 ] + xx [ 13 ] * xx [ 13 ] + xx [ 12 ] * xx [ 12 ] + xx [ 2 ] * xx [ 2 ] )
; if ( xx [ 5 ] > xx [ 3 ] ) xx [ 3 ] = xx [ 5 ] ; xx [ 17 ] = xx [ 4 ] / xx
[ 3 ] ; xx [ 4 ] = xx [ 13 ] / xx [ 3 ] ; xx [ 13 ] = xx [ 12 ] / xx [ 3 ] ;
xx [ 12 ] = xx [ 2 ] / xx [ 3 ] ; xx [ 19 ] = xx [ 180 ] ; xx [ 20 ] = xx [
146 ] ; xx [ 21 ] = xx [ 179 ] ; xx [ 22 ] = xx [ 185 ] ; pm_math_quatDeriv (
xx + 19 , xx + 219 , xx + 41 ) ; xx [ 2 ] = xx [ 180 ] + xx [ 41 ] ; xx [ 3 ]
= xx [ 146 ] + xx [ 42 ] ; xx [ 19 ] = xx [ 179 ] + xx [ 43 ] ; xx [ 20 ] =
xx [ 185 ] + xx [ 44 ] ; xx [ 21 ] = sqrt ( xx [ 2 ] * xx [ 2 ] + xx [ 3 ] *
xx [ 3 ] + xx [ 19 ] * xx [ 19 ] + xx [ 20 ] * xx [ 20 ] ) ; if ( xx [ 5 ] >
xx [ 21 ] ) xx [ 21 ] = xx [ 5 ] ; xx [ 22 ] = xx [ 2 ] / xx [ 21 ] ; xx [ 2
] = xx [ 3 ] / xx [ 21 ] ; xx [ 3 ] = xx [ 19 ] / xx [ 21 ] ; xx [ 19 ] = xx
[ 20 ] / xx [ 21 ] ; xx [ 41 ] = xx [ 111 ] ; xx [ 42 ] = xx [ 69 ] ; xx [ 43
] = xx [ 16 ] ; xx [ 44 ] = xx [ 115 ] ; pm_math_quatDeriv ( xx + 41 , xx +
222 , xx + 72 ) ; xx [ 20 ] = xx [ 111 ] + xx [ 72 ] ; xx [ 21 ] = xx [ 69 ]
+ xx [ 73 ] ; xx [ 28 ] = xx [ 16 ] + xx [ 74 ] ; xx [ 16 ] = xx [ 115 ] + xx
[ 75 ] ; xx [ 30 ] = sqrt ( xx [ 20 ] * xx [ 20 ] + xx [ 21 ] * xx [ 21 ] +
xx [ 28 ] * xx [ 28 ] + xx [ 16 ] * xx [ 16 ] ) ; if ( xx [ 5 ] > xx [ 30 ] )
xx [ 30 ] = xx [ 5 ] ; xx [ 32 ] = xx [ 20 ] / xx [ 30 ] ; xx [ 20 ] = xx [
21 ] / xx [ 30 ] ; xx [ 21 ] = xx [ 28 ] / xx [ 30 ] ; xx [ 28 ] = xx [ 16 ]
/ xx [ 30 ] ; xx [ 41 ] = xx [ 147 ] ; xx [ 42 ] = xx [ 109 ] ; xx [ 43 ] =
xx [ 121 ] ; xx [ 44 ] = xx [ 154 ] ; pm_math_quatDeriv ( xx + 41 , xx + 225
, xx + 72 ) ; xx [ 16 ] = xx [ 147 ] + xx [ 72 ] ; xx [ 30 ] = xx [ 109 ] +
xx [ 73 ] ; xx [ 41 ] = xx [ 121 ] + xx [ 74 ] ; xx [ 42 ] = xx [ 154 ] + xx
[ 75 ] ; xx [ 43 ] = sqrt ( xx [ 16 ] * xx [ 16 ] + xx [ 30 ] * xx [ 30 ] +
xx [ 41 ] * xx [ 41 ] + xx [ 42 ] * xx [ 42 ] ) ; if ( xx [ 5 ] > xx [ 43 ] )
xx [ 43 ] = xx [ 5 ] ; xx [ 44 ] = xx [ 16 ] / xx [ 43 ] ; xx [ 16 ] = xx [
30 ] / xx [ 43 ] ; xx [ 30 ] = xx [ 41 ] / xx [ 43 ] ; xx [ 41 ] = xx [ 42 ]
/ xx [ 43 ] ; xx [ 72 ] = xx [ 198 ] ; xx [ 73 ] = xx [ 164 ] ; xx [ 74 ] =
xx [ 192 ] ; xx [ 75 ] = xx [ 200 ] ; pm_math_quatDeriv ( xx + 72 , xx + 228
, xx + 81 ) ; xx [ 42 ] = xx [ 198 ] + xx [ 81 ] ; xx [ 43 ] = xx [ 164 ] +
xx [ 82 ] ; xx [ 49 ] = xx [ 192 ] + xx [ 83 ] ; xx [ 50 ] = xx [ 200 ] + xx
[ 84 ] ; xx [ 55 ] = sqrt ( xx [ 42 ] * xx [ 42 ] + xx [ 43 ] * xx [ 43 ] +
xx [ 49 ] * xx [ 49 ] + xx [ 50 ] * xx [ 50 ] ) ; if ( xx [ 5 ] > xx [ 55 ] )
xx [ 55 ] = xx [ 5 ] ; xx [ 56 ] = xx [ 42 ] / xx [ 55 ] ; xx [ 42 ] = xx [
43 ] / xx [ 55 ] ; xx [ 43 ] = xx [ 49 ] / xx [ 55 ] ; xx [ 49 ] = xx [ 50 ]
/ xx [ 55 ] ; xx [ 50 ] = xx [ 18 ] + xx [ 231 ] ; xx [ 18 ] = xx [ 26 ] + xx
[ 232 ] ; xx [ 72 ] = xx [ 65 ] ; xx [ 73 ] = xx [ 45 ] ; xx [ 74 ] = xx [ 46
] ; xx [ 75 ] = xx [ 47 ] ; pm_math_quatDeriv ( xx + 72 , xx + 233 , xx + 81
) ; xx [ 26 ] = xx [ 65 ] + xx [ 81 ] ; xx [ 55 ] = xx [ 45 ] + xx [ 82 ] ;
xx [ 45 ] = xx [ 46 ] + xx [ 83 ] ; xx [ 46 ] = xx [ 47 ] + xx [ 84 ] ; xx [
47 ] = sqrt ( xx [ 26 ] * xx [ 26 ] + xx [ 55 ] * xx [ 55 ] + xx [ 45 ] * xx
[ 45 ] + xx [ 46 ] * xx [ 46 ] ) ; if ( xx [ 5 ] > xx [ 47 ] ) xx [ 47 ] = xx
[ 5 ] ; xx [ 5 ] = xx [ 26 ] / xx [ 47 ] ; xx [ 26 ] = xx [ 55 ] / xx [ 47 ]
; xx [ 55 ] = xx [ 45 ] / xx [ 47 ] ; xx [ 45 ] = xx [ 46 ] / xx [ 47 ] ; xx
[ 178 ] = xx [ 17 ] ; xx [ 179 ] = xx [ 4 ] ; xx [ 180 ] = xx [ 13 ] ; xx [
181 ] = xx [ 12 ] ; xx [ 182 ] = state [ 4 ] ; xx [ 183 ] = state [ 5 ] ; xx
[ 184 ] = state [ 6 ] ; xx [ 185 ] = xx [ 22 ] ; xx [ 186 ] = xx [ 2 ] ; xx [
187 ] = xx [ 3 ] ; xx [ 188 ] = xx [ 19 ] ; xx [ 189 ] = state [ 11 ] ; xx [
190 ] = state [ 12 ] ; xx [ 191 ] = state [ 13 ] ; xx [ 192 ] = xx [ 32 ] ;
xx [ 193 ] = xx [ 20 ] ; xx [ 194 ] = xx [ 21 ] ; xx [ 195 ] = xx [ 28 ] ; xx
[ 196 ] = state [ 18 ] ; xx [ 197 ] = state [ 19 ] ; xx [ 198 ] = state [ 20
] ; xx [ 199 ] = xx [ 44 ] ; xx [ 200 ] = xx [ 16 ] ; xx [ 201 ] = xx [ 30 ]
; xx [ 202 ] = xx [ 41 ] ; xx [ 203 ] = state [ 25 ] ; xx [ 204 ] = state [
26 ] ; xx [ 205 ] = state [ 27 ] ; xx [ 206 ] = xx [ 56 ] ; xx [ 207 ] = xx [
42 ] ; xx [ 208 ] = xx [ 43 ] ; xx [ 209 ] = xx [ 49 ] ; xx [ 210 ] = state [
32 ] ; xx [ 211 ] = state [ 33 ] ; xx [ 212 ] = state [ 34 ] ; xx [ 213 ] =
xx [ 50 ] ; xx [ 214 ] = xx [ 18 ] ; xx [ 215 ] = state [ 37 ] ; xx [ 216 ] =
state [ 38 ] ; xx [ 217 ] = state [ 39 ] ; xx [ 218 ] = state [ 40 ] ; xx [
219 ] = xx [ 5 ] ; xx [ 220 ] = xx [ 26 ] ; xx [ 221 ] = xx [ 55 ] ; xx [ 222
] = xx [ 45 ] ; xx [ 223 ] = state [ 45 ] ; xx [ 224 ] = state [ 46 ] ; xx [
225 ] = state [ 47 ] ; xx [ 72 ] = - xx [ 5 ] ; xx [ 73 ] = - xx [ 26 ] ; xx
[ 74 ] = - xx [ 55 ] ; xx [ 75 ] = - xx [ 45 ] ; pm_math_quatXform ( xx + 72
, xx + 33 , xx + 81 ) ; xx [ 46 ] = xx [ 14 ] * xx [ 55 ] ; xx [ 47 ] = xx [
14 ] * xx [ 26 ] ; xx [ 57 ] = ( xx [ 5 ] * xx [ 46 ] + xx [ 45 ] * xx [ 47 ]
) * xx [ 10 ] + xx [ 50 ] ; xx [ 50 ] = xx [ 6 ] * xx [ 13 ] ; xx [ 59 ] = xx
[ 6 ] * xx [ 12 ] ; xx [ 61 ] = ( xx [ 13 ] * xx [ 50 ] + xx [ 12 ] * xx [ 59
] ) * xx [ 10 ] ; xx [ 12 ] = xx [ 6 ] - xx [ 61 ] + xx [ 15 ] - xx [ 61 ] ;
xx [ 13 ] = xx [ 10 ] * ( xx [ 45 ] * xx [ 46 ] - xx [ 5 ] * xx [ 47 ] ) + xx
[ 18 ] ; xx [ 5 ] = ( xx [ 17 ] * xx [ 59 ] + xx [ 4 ] * xx [ 50 ] ) * xx [
10 ] ; xx [ 15 ] = xx [ 5 ] + xx [ 7 ] + xx [ 5 ] ; xx [ 5 ] = state [ 37 ] -
( xx [ 26 ] * xx [ 47 ] + xx [ 55 ] * xx [ 46 ] ) * xx [ 10 ] + xx [ 14 ] ;
xx [ 7 ] = xx [ 10 ] * ( xx [ 4 ] * xx [ 59 ] - xx [ 17 ] * xx [ 50 ] ) ; xx
[ 4 ] = xx [ 7 ] + xx [ 8 ] + xx [ 7 ] ; pm_math_quatXform ( xx + 72 , xx +
36 , xx + 45 ) ; xx [ 7 ] = xx [ 68 ] * xx [ 21 ] ; xx [ 8 ] = xx [ 68 ] * xx
[ 28 ] ; xx [ 17 ] = ( xx [ 21 ] * xx [ 7 ] + xx [ 28 ] * xx [ 8 ] ) * xx [
10 ] ; xx [ 18 ] = ( xx [ 32 ] * xx [ 8 ] + xx [ 20 ] * xx [ 7 ] ) * xx [ 10
] ; xx [ 21 ] = xx [ 10 ] * ( xx [ 20 ] * xx [ 8 ] - xx [ 32 ] * xx [ 7 ] ) ;
pm_math_quatXform ( xx + 72 , xx + 52 , xx + 86 ) ; xx [ 7 ] = xx [ 108 ] *
xx [ 30 ] ; xx [ 8 ] = xx [ 108 ] * xx [ 41 ] ; xx [ 20 ] = ( xx [ 30 ] * xx
[ 7 ] + xx [ 41 ] * xx [ 8 ] ) * xx [ 10 ] ; xx [ 26 ] = xx [ 108 ] - xx [ 20
] + xx [ 23 ] - xx [ 20 ] ; xx [ 20 ] = ( xx [ 44 ] * xx [ 8 ] + xx [ 16 ] *
xx [ 7 ] ) * xx [ 10 ] ; xx [ 23 ] = xx [ 20 ] + xx [ 29 ] + xx [ 20 ] ; xx [
20 ] = xx [ 10 ] * ( xx [ 16 ] * xx [ 8 ] - xx [ 44 ] * xx [ 7 ] ) ; xx [ 7 ]
= xx [ 20 ] + xx [ 31 ] + xx [ 20 ] ; xx [ 8 ] = xx [ 145 ] * xx [ 3 ] ; xx [
16 ] = xx [ 145 ] * xx [ 19 ] ; xx [ 20 ] = ( xx [ 3 ] * xx [ 8 ] + xx [ 19 ]
* xx [ 16 ] ) * xx [ 10 ] ; xx [ 3 ] = ( xx [ 22 ] * xx [ 16 ] + xx [ 2 ] *
xx [ 8 ] ) * xx [ 10 ] ; xx [ 19 ] = xx [ 10 ] * ( xx [ 2 ] * xx [ 16 ] - xx
[ 22 ] * xx [ 8 ] ) ; xx [ 2 ] = xx [ 163 ] * xx [ 43 ] ; xx [ 8 ] = xx [ 163
] * xx [ 49 ] ; xx [ 16 ] = ( xx [ 43 ] * xx [ 2 ] + xx [ 49 ] * xx [ 8 ] ) *
xx [ 10 ] ; xx [ 22 ] = ( xx [ 56 ] * xx [ 8 ] + xx [ 42 ] * xx [ 2 ] ) * xx
[ 10 ] ; xx [ 28 ] = xx [ 10 ] * ( xx [ 42 ] * xx [ 8 ] - xx [ 56 ] * xx [ 2
] ) ; xx [ 226 ] = fabs ( xx [ 81 ] + xx [ 57 ] - xx [ 12 ] ) ; xx [ 227 ] =
fabs ( xx [ 82 ] + xx [ 13 ] - xx [ 15 ] ) ; xx [ 228 ] = fabs ( xx [ 83 ] +
xx [ 5 ] - xx [ 4 ] ) ; xx [ 229 ] = fabs ( xx [ 45 ] + xx [ 57 ] + xx [ 17 ]
+ xx [ 17 ] - xx [ 24 ] ) ; xx [ 230 ] = fabs ( xx [ 46 ] + xx [ 13 ] - ( xx
[ 18 ] + xx [ 18 ] ) - xx [ 39 ] ) ; xx [ 231 ] = fabs ( xx [ 47 ] + xx [ 5 ]
- ( xx [ 21 ] + xx [ 21 ] ) - xx [ 48 ] ) ; xx [ 232 ] = fabs ( xx [ 86 ] +
xx [ 57 ] - xx [ 26 ] ) ; xx [ 233 ] = fabs ( xx [ 87 ] + xx [ 13 ] - xx [ 23
] ) ; xx [ 234 ] = fabs ( xx [ 88 ] + xx [ 5 ] - xx [ 7 ] ) ; xx [ 235 ] =
fabs ( xx [ 12 ] + xx [ 20 ] + xx [ 20 ] - xx [ 58 ] ) ; xx [ 236 ] = fabs (
xx [ 15 ] - ( xx [ 3 ] + xx [ 3 ] ) - xx [ 60 ] ) ; xx [ 237 ] = fabs ( xx [
4 ] - ( xx [ 19 ] + xx [ 19 ] ) - xx [ 62 ] ) ; xx [ 238 ] = fabs ( xx [ 26 ]
+ xx [ 16 ] + xx [ 16 ] - xx [ 64 ] ) ; xx [ 239 ] = fabs ( xx [ 23 ] - ( xx
[ 22 ] + xx [ 22 ] ) - xx [ 66 ] ) ; xx [ 240 ] = fabs ( xx [ 7 ] - ( xx [ 28
] + xx [ 28 ] ) - xx [ 71 ] ) ; ii [ 0 ] = 226 ; { int ll ; for ( ll = 227 ;
ll < 241 ; ++ ll ) if ( xx [ ll ] > xx [ ii [ 0 ] ] ) ii [ 0 ] = ll ; } ii [
0 ] -= 226 ; xx [ 2 ] = xx [ 226 + ( ii [ 0 ] ) ] ; xx [ 3 ] = 1.0e-6 ; xx [
4 ] = xx [ 2 ] - xx [ 3 ] ; if ( xx [ 4 ] < 0.0 ) ii [ 1 ] = - 1 ; else if (
xx [ 4 ] > 0.0 ) ii [ 1 ] = + 1 ; else ii [ 1 ] = 0 ; ii [ 2 ] = ii [ 1 ] ;
if ( 0 > ii [ 2 ] ) ii [ 2 ] = 0 ; if ( ii [ 2 ] != 0 ) { switch ( ii [ 0 ] )
{ case 0 : case 1 : case 2 : { return sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:ConstraintViolation" ,
 "'Kinematics_Model/Lower Ball Joint' kinematic constraints cannot be maintained. Check solver type and consistency tolerance in the Simscape Solver Configuration block. Check Simulink solver type and tolerances in Model Configuration Parameters. A kinematic singularity might be the source of this problem."
, neDiagMgr ) ; } case 3 : case 4 : case 5 : { return
sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:ConstraintViolation" ,
 "'Kinematics_Model/Trackrod  Outer Joint' kinematic constraints cannot be maintained. Check solver type and consistency tolerance in the Simscape Solver Configuration block. Check Simulink solver type and tolerances in Model Configuration Parameters. A kinematic singularity might be the source of this problem."
, neDiagMgr ) ; } case 6 : case 7 : case 8 : { return
sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:ConstraintViolation" ,
 "'Kinematics_Model/Upper Ball Joint' kinematic constraints cannot be maintained. Check solver type and consistency tolerance in the Simscape Solver Configuration block. Check Simulink solver type and tolerances in Model Configuration Parameters. A kinematic singularity might be the source of this problem."
, neDiagMgr ) ; } case 9 : case 10 : case 11 : { return
sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:ConstraintViolation" ,
 "'Kinematics_Model/LWB/LWB Apex Joint' kinematic constraints cannot be maintained. Check solver type and consistency tolerance in the Simscape Solver Configuration block. Check Simulink solver type and tolerances in Model Configuration Parameters. A kinematic singularity might be the source of this problem."
, neDiagMgr ) ; } case 12 : case 13 : case 14 : { return
sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:ConstraintViolation" ,
 "'Kinematics_Model/UWB/Spherical Joint' kinematic constraints cannot be maintained. Check solver type and consistency tolerance in the Simscape Solver Configuration block. Check Simulink solver type and tolerances in Model Configuration Parameters. A kinematic singularity might be the source of this problem."
, neDiagMgr ) ; } } } xx [ 2 ] = xx [ 6 ] * xx [ 180 ] ; xx [ 4 ] = xx [ 6 ]
* xx [ 179 ] ; xx [ 5 ] = ( xx [ 178 ] * xx [ 2 ] + xx [ 181 ] * xx [ 4 ] ) *
xx [ 10 ] ; xx [ 7 ] = xx [ 5 ] + xx [ 5 ] ; xx [ 5 ] = xx [ 6 ] * xx [ 181 ]
; xx [ 8 ] = xx [ 10 ] * ( xx [ 180 ] * xx [ 4 ] - xx [ 178 ] * xx [ 5 ] ) ;
xx [ 12 ] = xx [ 8 ] + xx [ 8 ] ; xx [ 8 ] = - xx [ 220 ] ; xx [ 13 ] = - xx
[ 221 ] ; xx [ 15 ] = - xx [ 222 ] ; xx [ 16 ] = xx [ 8 ] ; xx [ 17 ] = xx [
13 ] ; xx [ 18 ] = xx [ 15 ] ; xx [ 19 ] = xx [ 25 ] * xx [ 222 ] ; xx [ 20 ]
= xx [ 27 ] * xx [ 221 ] ; xx [ 21 ] = xx [ 19 ] + xx [ 20 ] ; xx [ 22 ] = xx
[ 27 ] * xx [ 220 ] ; xx [ 28 ] = xx [ 21 ] ; xx [ 29 ] = - xx [ 22 ] ; xx [
30 ] = - ( xx [ 25 ] * xx [ 220 ] ) ; pm_math_cross3 ( xx + 16 , xx + 28 , xx
+ 41 ) ; xx [ 23 ] = xx [ 14 ] * xx [ 222 ] ; xx [ 24 ] = xx [ 219 ] * xx [
23 ] ; xx [ 26 ] = xx [ 14 ] * xx [ 220 ] ; xx [ 28 ] = xx [ 10 ] * ( xx [ 24
] - xx [ 221 ] * xx [ 26 ] ) ; xx [ 29 ] = xx [ 40 ] * xx [ 220 ] ; xx [ 30 ]
= xx [ 19 ] - xx [ 29 ] ; xx [ 19 ] = xx [ 25 ] * xx [ 221 ] ; xx [ 44 ] = xx
[ 40 ] * xx [ 221 ] ; xx [ 45 ] = xx [ 30 ] ; xx [ 46 ] = - xx [ 19 ] ;
pm_math_cross3 ( xx + 16 , xx + 44 , xx + 47 ) ; xx [ 31 ] = xx [ 219 ] * xx
[ 221 ] ; xx [ 32 ] = xx [ 14 ] * xx [ 221 ] ; xx [ 39 ] = xx [ 222 ] * xx [
23 ] ; xx [ 44 ] = ( xx [ 221 ] * xx [ 32 ] + xx [ 39 ] ) * xx [ 10 ] ; xx [
45 ] = xx [ 40 ] * xx [ 222 ] ; xx [ 46 ] = xx [ 20 ] - xx [ 29 ] ; xx [ 55 ]
= xx [ 45 ] ; xx [ 56 ] = - ( xx [ 27 ] * xx [ 222 ] ) ; xx [ 57 ] = xx [ 46
] ; pm_math_cross3 ( xx + 16 , xx + 55 , xx + 58 ) ; xx [ 20 ] = xx [ 178 ] *
xx [ 4 ] ; xx [ 29 ] = xx [ 10 ] * ( xx [ 20 ] - xx [ 181 ] * xx [ 2 ] ) ; xx
[ 50 ] = xx [ 29 ] + xx [ 29 ] ; xx [ 29 ] = xx [ 179 ] * xx [ 4 ] ; xx [ 4 ]
= ( xx [ 181 ] * xx [ 5 ] + xx [ 29 ] ) * xx [ 10 ] ; xx [ 55 ] = xx [ 4 ] +
xx [ 4 ] ; xx [ 4 ] = ( xx [ 39 ] + xx [ 220 ] * xx [ 26 ] ) * xx [ 10 ] ; xx
[ 39 ] = ( xx [ 24 ] + xx [ 220 ] * xx [ 32 ] ) * xx [ 10 ] ; xx [ 24 ] = xx
[ 219 ] * xx [ 222 ] ; xx [ 56 ] = ( xx [ 29 ] + xx [ 180 ] * xx [ 2 ] ) * xx
[ 10 ] ; xx [ 2 ] = xx [ 56 ] + xx [ 56 ] ; xx [ 29 ] = ( xx [ 20 ] + xx [
180 ] * xx [ 5 ] ) * xx [ 10 ] ; xx [ 5 ] = xx [ 29 ] + xx [ 29 ] ; xx [ 20 ]
= xx [ 219 ] * xx [ 220 ] ; xx [ 29 ] = ( xx [ 219 ] * xx [ 26 ] + xx [ 221 ]
* xx [ 23 ] ) * xx [ 10 ] ; xx [ 26 ] = xx [ 10 ] * ( xx [ 220 ] * xx [ 23 ]
- xx [ 219 ] * xx [ 32 ] ) ; xx [ 23 ] = xx [ 68 ] * xx [ 194 ] ; xx [ 32 ] =
xx [ 68 ] * xx [ 193 ] ; xx [ 56 ] = ( xx [ 192 ] * xx [ 23 ] + xx [ 195 ] *
xx [ 32 ] ) * xx [ 10 ] ; xx [ 57 ] = xx [ 68 ] * xx [ 195 ] ; xx [ 61 ] = xx
[ 10 ] * ( xx [ 194 ] * xx [ 32 ] - xx [ 192 ] * xx [ 57 ] ) ; xx [ 62 ] = xx
[ 78 ] * xx [ 221 ] ; xx [ 63 ] = xx [ 80 ] * xx [ 222 ] ; xx [ 64 ] = xx [
62 ] - xx [ 63 ] ; xx [ 65 ] = xx [ 78 ] * xx [ 220 ] ; xx [ 69 ] = xx [ 64 ]
; xx [ 70 ] = - xx [ 65 ] ; xx [ 71 ] = xx [ 80 ] * xx [ 220 ] ;
pm_math_cross3 ( xx + 16 , xx + 69 , xx + 72 ) ; xx [ 66 ] = xx [ 85 ] * xx [
220 ] ; xx [ 67 ] = xx [ 66 ] + xx [ 63 ] ; xx [ 63 ] = xx [ 80 ] * xx [ 221
] ; xx [ 69 ] = xx [ 85 ] * xx [ 221 ] ; xx [ 70 ] = - xx [ 67 ] ; xx [ 71 ]
= xx [ 63 ] ; pm_math_cross3 ( xx + 16 , xx + 69 , xx + 75 ) ; xx [ 69 ] = xx
[ 85 ] * xx [ 222 ] ; xx [ 70 ] = xx [ 62 ] - xx [ 66 ] ; xx [ 81 ] = xx [ 69
] ; xx [ 82 ] = - ( xx [ 78 ] * xx [ 222 ] ) ; xx [ 83 ] = xx [ 70 ] ;
pm_math_cross3 ( xx + 16 , xx + 81 , xx + 86 ) ; xx [ 62 ] = xx [ 192 ] * xx
[ 32 ] ; xx [ 66 ] = xx [ 10 ] * ( xx [ 62 ] - xx [ 195 ] * xx [ 23 ] ) ; xx
[ 71 ] = xx [ 193 ] * xx [ 32 ] ; xx [ 32 ] = ( xx [ 195 ] * xx [ 57 ] + xx [
71 ] ) * xx [ 10 ] ; xx [ 81 ] = ( xx [ 71 ] + xx [ 194 ] * xx [ 23 ] ) * xx
[ 10 ] ; xx [ 23 ] = ( xx [ 62 ] + xx [ 194 ] * xx [ 57 ] ) * xx [ 10 ] ; xx
[ 57 ] = xx [ 108 ] * xx [ 201 ] ; xx [ 62 ] = xx [ 108 ] * xx [ 200 ] ; xx [
71 ] = ( xx [ 199 ] * xx [ 57 ] + xx [ 202 ] * xx [ 62 ] ) * xx [ 10 ] ; xx [
82 ] = xx [ 71 ] + xx [ 71 ] ; xx [ 71 ] = xx [ 108 ] * xx [ 202 ] ; xx [ 83
] = xx [ 10 ] * ( xx [ 201 ] * xx [ 62 ] - xx [ 199 ] * xx [ 71 ] ) ; xx [ 84
] = xx [ 83 ] + xx [ 83 ] ; xx [ 83 ] = xx [ 117 ] * xx [ 221 ] ; xx [ 89 ] =
xx [ 120 ] * xx [ 222 ] ; xx [ 90 ] = xx [ 83 ] - xx [ 89 ] ; xx [ 91 ] = xx
[ 117 ] * xx [ 220 ] ; xx [ 93 ] = xx [ 90 ] ; xx [ 94 ] = - xx [ 91 ] ; xx [
95 ] = xx [ 120 ] * xx [ 220 ] ; pm_math_cross3 ( xx + 16 , xx + 93 , xx + 96
) ; xx [ 93 ] = xx [ 125 ] * xx [ 220 ] ; xx [ 94 ] = xx [ 93 ] - xx [ 89 ] ;
xx [ 89 ] = xx [ 120 ] * xx [ 221 ] ; xx [ 102 ] = - ( xx [ 125 ] * xx [ 221
] ) ; xx [ 103 ] = xx [ 94 ] ; xx [ 104 ] = xx [ 89 ] ; pm_math_cross3 ( xx +
16 , xx + 102 , xx + 105 ) ; xx [ 95 ] = xx [ 125 ] * xx [ 222 ] ; xx [ 99 ]
= xx [ 83 ] + xx [ 93 ] ; xx [ 102 ] = - xx [ 95 ] ; xx [ 103 ] = - ( xx [
117 ] * xx [ 222 ] ) ; xx [ 104 ] = xx [ 99 ] ; pm_math_cross3 ( xx + 16 , xx
+ 102 , xx + 109 ) ; xx [ 16 ] = xx [ 199 ] * xx [ 62 ] ; xx [ 17 ] = xx [ 10
] * ( xx [ 16 ] - xx [ 202 ] * xx [ 57 ] ) ; xx [ 18 ] = xx [ 17 ] + xx [ 17
] ; xx [ 17 ] = xx [ 200 ] * xx [ 62 ] ; xx [ 62 ] = ( xx [ 202 ] * xx [ 71 ]
+ xx [ 17 ] ) * xx [ 10 ] ; xx [ 83 ] = xx [ 62 ] + xx [ 62 ] ; xx [ 62 ] = (
xx [ 17 ] + xx [ 201 ] * xx [ 57 ] ) * xx [ 10 ] ; xx [ 17 ] = xx [ 62 ] + xx
[ 62 ] ; xx [ 57 ] = ( xx [ 16 ] + xx [ 201 ] * xx [ 71 ] ) * xx [ 10 ] ; xx
[ 16 ] = xx [ 57 ] + xx [ 57 ] ; xx [ 57 ] = xx [ 145 ] * xx [ 187 ] ; xx [
62 ] = xx [ 145 ] * xx [ 186 ] ; xx [ 71 ] = ( xx [ 185 ] * xx [ 57 ] + xx [
188 ] * xx [ 62 ] ) * xx [ 10 ] ; xx [ 93 ] = xx [ 145 ] * xx [ 188 ] ; xx [
100 ] = xx [ 10 ] * ( xx [ 187 ] * xx [ 62 ] - xx [ 185 ] * xx [ 93 ] ) ; xx
[ 102 ] = xx [ 185 ] * xx [ 62 ] ; xx [ 103 ] = xx [ 10 ] * ( xx [ 102 ] - xx
[ 188 ] * xx [ 57 ] ) ; xx [ 104 ] = xx [ 186 ] * xx [ 62 ] ; xx [ 62 ] = (
xx [ 188 ] * xx [ 93 ] + xx [ 104 ] ) * xx [ 10 ] ; xx [ 112 ] = ( xx [ 104 ]
+ xx [ 187 ] * xx [ 57 ] ) * xx [ 10 ] ; xx [ 57 ] = ( xx [ 102 ] + xx [ 187
] * xx [ 93 ] ) * xx [ 10 ] ; xx [ 93 ] = xx [ 163 ] * xx [ 208 ] ; xx [ 102
] = xx [ 163 ] * xx [ 207 ] ; xx [ 104 ] = ( xx [ 206 ] * xx [ 93 ] + xx [
209 ] * xx [ 102 ] ) * xx [ 10 ] ; xx [ 113 ] = xx [ 163 ] * xx [ 209 ] ; xx
[ 114 ] = xx [ 10 ] * ( xx [ 208 ] * xx [ 102 ] - xx [ 206 ] * xx [ 113 ] ) ;
xx [ 115 ] = xx [ 206 ] * xx [ 102 ] ; xx [ 116 ] = xx [ 10 ] * ( xx [ 115 ]
- xx [ 209 ] * xx [ 93 ] ) ; xx [ 118 ] = xx [ 207 ] * xx [ 102 ] ; xx [ 102
] = ( xx [ 209 ] * xx [ 113 ] + xx [ 118 ] ) * xx [ 10 ] ; xx [ 119 ] = ( xx
[ 118 ] + xx [ 208 ] * xx [ 93 ] ) * xx [ 10 ] ; xx [ 93 ] = ( xx [ 115 ] +
xx [ 208 ] * xx [ 113 ] ) * xx [ 10 ] ; xx [ 226 ] = xx [ 1 ] ; xx [ 227 ] =
xx [ 7 ] ; xx [ 228 ] = - xx [ 12 ] ; xx [ 229 ] = xx [ 1 ] ; xx [ 230 ] = xx
[ 1 ] ; xx [ 231 ] = xx [ 1 ] ; xx [ 232 ] = xx [ 1 ] ; xx [ 233 ] = xx [ 1 ]
; xx [ 234 ] = xx [ 1 ] ; xx [ 235 ] = xx [ 1 ] ; xx [ 236 ] = xx [ 1 ] ; xx
[ 237 ] = xx [ 1 ] ; xx [ 238 ] = xx [ 1 ] ; xx [ 239 ] = xx [ 1 ] ; xx [ 240
] = xx [ 1 ] ; xx [ 241 ] = xx [ 0 ] ; xx [ 242 ] = xx [ 1 ] ; xx [ 243 ] =
xx [ 10 ] * ( xx [ 41 ] - xx [ 219 ] * xx [ 21 ] ) + xx [ 28 ] ; xx [ 244 ] =
( xx [ 47 ] - xx [ 40 ] * xx [ 31 ] ) * xx [ 10 ] - xx [ 44 ] + xx [ 51 ] ;
xx [ 245 ] = xx [ 27 ] + xx [ 10 ] * ( xx [ 58 ] - xx [ 219 ] * xx [ 45 ] ) ;
xx [ 246 ] = xx [ 1 ] ; xx [ 247 ] = - xx [ 50 ] ; xx [ 248 ] = xx [ 55 ] -
xx [ 9 ] ; xx [ 249 ] = xx [ 1 ] ; xx [ 250 ] = xx [ 1 ] ; xx [ 251 ] = xx [
1 ] ; xx [ 252 ] = xx [ 1 ] ; xx [ 253 ] = xx [ 1 ] ; xx [ 254 ] = xx [ 1 ] ;
xx [ 255 ] = xx [ 1 ] ; xx [ 256 ] = xx [ 1 ] ; xx [ 257 ] = xx [ 1 ] ; xx [
258 ] = xx [ 1 ] ; xx [ 259 ] = xx [ 1 ] ; xx [ 260 ] = xx [ 1 ] ; xx [ 261 ]
= xx [ 1 ] ; xx [ 262 ] = xx [ 0 ] ; xx [ 263 ] = xx [ 10 ] * ( xx [ 42 ] +
xx [ 219 ] * xx [ 22 ] ) + xx [ 4 ] - xx [ 51 ] ; xx [ 264 ] = xx [ 10 ] * (
xx [ 48 ] - xx [ 219 ] * xx [ 30 ] ) + xx [ 39 ] ; xx [ 265 ] = xx [ 40 ] + (
xx [ 27 ] * xx [ 24 ] + xx [ 59 ] ) * xx [ 10 ] ; xx [ 266 ] = xx [ 1 ] ; xx
[ 267 ] = xx [ 9 ] - xx [ 2 ] ; xx [ 268 ] = - xx [ 5 ] ; xx [ 269 ] = xx [ 1
] ; xx [ 270 ] = xx [ 1 ] ; xx [ 271 ] = xx [ 1 ] ; xx [ 272 ] = xx [ 1 ] ;
xx [ 273 ] = xx [ 1 ] ; xx [ 274 ] = xx [ 1 ] ; xx [ 275 ] = xx [ 1 ] ; xx [
276 ] = xx [ 1 ] ; xx [ 277 ] = xx [ 1 ] ; xx [ 278 ] = xx [ 1 ] ; xx [ 279 ]
= xx [ 1 ] ; xx [ 280 ] = xx [ 1 ] ; xx [ 281 ] = xx [ 1 ] ; xx [ 282 ] = xx
[ 1 ] ; xx [ 283 ] = ( xx [ 25 ] * xx [ 20 ] + xx [ 43 ] ) * xx [ 10 ] - xx [
29 ] - xx [ 27 ] ; xx [ 284 ] = xx [ 10 ] * ( xx [ 49 ] + xx [ 219 ] * xx [
19 ] ) + xx [ 26 ] - xx [ 40 ] ; xx [ 285 ] = xx [ 10 ] * ( xx [ 60 ] - xx [
219 ] * xx [ 46 ] ) ; xx [ 286 ] = xx [ 1 ] ; xx [ 287 ] = xx [ 1 ] ; xx [
288 ] = xx [ 1 ] ; xx [ 289 ] = xx [ 1 ] ; xx [ 290 ] = xx [ 1 ] ; xx [ 291 ]
= xx [ 1 ] ; xx [ 292 ] = xx [ 1 ] ; xx [ 293 ] = xx [ 56 ] + xx [ 56 ] ; xx
[ 294 ] = - ( xx [ 61 ] + xx [ 61 ] ) ; xx [ 295 ] = xx [ 1 ] ; xx [ 296 ] =
xx [ 1 ] ; xx [ 297 ] = xx [ 1 ] ; xx [ 298 ] = xx [ 1 ] ; xx [ 299 ] = xx [
1 ] ; xx [ 300 ] = xx [ 1 ] ; xx [ 301 ] = xx [ 0 ] ; xx [ 302 ] = xx [ 1 ] ;
xx [ 303 ] = xx [ 10 ] * ( xx [ 72 ] - xx [ 219 ] * xx [ 64 ] ) + xx [ 28 ] ;
xx [ 304 ] = ( xx [ 75 ] - xx [ 85 ] * xx [ 31 ] ) * xx [ 10 ] - xx [ 44 ] +
xx [ 92 ] ; xx [ 305 ] = xx [ 78 ] + xx [ 10 ] * ( xx [ 86 ] - xx [ 219 ] *
xx [ 69 ] ) ; xx [ 306 ] = xx [ 1 ] ; xx [ 307 ] = xx [ 1 ] ; xx [ 308 ] = xx
[ 1 ] ; xx [ 309 ] = xx [ 1 ] ; xx [ 310 ] = xx [ 1 ] ; xx [ 311 ] = xx [ 1 ]
; xx [ 312 ] = xx [ 1 ] ; xx [ 313 ] = - ( xx [ 66 ] + xx [ 66 ] ) ; xx [ 314
] = xx [ 32 ] + xx [ 32 ] - xx [ 101 ] ; xx [ 315 ] = xx [ 1 ] ; xx [ 316 ] =
xx [ 1 ] ; xx [ 317 ] = xx [ 1 ] ; xx [ 318 ] = xx [ 1 ] ; xx [ 319 ] = xx [
1 ] ; xx [ 320 ] = xx [ 1 ] ; xx [ 321 ] = xx [ 1 ] ; xx [ 322 ] = xx [ 0 ] ;
xx [ 323 ] = xx [ 10 ] * ( xx [ 73 ] + xx [ 219 ] * xx [ 65 ] ) + xx [ 4 ] -
xx [ 92 ] ; xx [ 324 ] = xx [ 10 ] * ( xx [ 76 ] + xx [ 219 ] * xx [ 67 ] ) +
xx [ 39 ] ; xx [ 325 ] = xx [ 85 ] + ( xx [ 78 ] * xx [ 24 ] + xx [ 87 ] ) *
xx [ 10 ] ; xx [ 326 ] = xx [ 1 ] ; xx [ 327 ] = xx [ 1 ] ; xx [ 328 ] = xx [
1 ] ; xx [ 329 ] = xx [ 1 ] ; xx [ 330 ] = xx [ 1 ] ; xx [ 331 ] = xx [ 1 ] ;
xx [ 332 ] = xx [ 1 ] ; xx [ 333 ] = xx [ 101 ] - ( xx [ 81 ] + xx [ 81 ] ) ;
xx [ 334 ] = - ( xx [ 23 ] + xx [ 23 ] ) ; xx [ 335 ] = xx [ 1 ] ; xx [ 336 ]
= xx [ 1 ] ; xx [ 337 ] = xx [ 1 ] ; xx [ 338 ] = xx [ 1 ] ; xx [ 339 ] = xx
[ 1 ] ; xx [ 340 ] = xx [ 1 ] ; xx [ 341 ] = xx [ 1 ] ; xx [ 342 ] = xx [ 1 ]
; xx [ 343 ] = ( xx [ 74 ] - xx [ 80 ] * xx [ 20 ] ) * xx [ 10 ] - xx [ 29 ]
- xx [ 78 ] ; xx [ 344 ] = xx [ 10 ] * ( xx [ 77 ] - xx [ 219 ] * xx [ 63 ] )
+ xx [ 26 ] - xx [ 85 ] ; xx [ 345 ] = xx [ 10 ] * ( xx [ 88 ] - xx [ 219 ] *
xx [ 70 ] ) ; xx [ 346 ] = xx [ 1 ] ; xx [ 347 ] = xx [ 1 ] ; xx [ 348 ] = xx
[ 1 ] ; xx [ 349 ] = xx [ 1 ] ; xx [ 350 ] = xx [ 1 ] ; xx [ 351 ] = xx [ 1 ]
; xx [ 352 ] = xx [ 1 ] ; xx [ 353 ] = xx [ 1 ] ; xx [ 354 ] = xx [ 1 ] ; xx
[ 355 ] = xx [ 1 ] ; xx [ 356 ] = xx [ 82 ] ; xx [ 357 ] = - xx [ 84 ] ; xx [
358 ] = xx [ 1 ] ; xx [ 359 ] = xx [ 1 ] ; xx [ 360 ] = xx [ 1 ] ; xx [ 361 ]
= xx [ 0 ] ; xx [ 362 ] = xx [ 1 ] ; xx [ 363 ] = xx [ 10 ] * ( xx [ 96 ] -
xx [ 219 ] * xx [ 90 ] ) + xx [ 28 ] ; xx [ 364 ] = ( xx [ 125 ] * xx [ 31 ]
+ xx [ 105 ] ) * xx [ 10 ] - xx [ 44 ] + xx [ 132 ] ; xx [ 365 ] = xx [ 117 ]
+ xx [ 10 ] * ( xx [ 109 ] + xx [ 219 ] * xx [ 95 ] ) ; xx [ 366 ] = xx [ 1 ]
; xx [ 367 ] = xx [ 1 ] ; xx [ 368 ] = xx [ 1 ] ; xx [ 369 ] = xx [ 1 ] ; xx
[ 370 ] = xx [ 1 ] ; xx [ 371 ] = xx [ 1 ] ; xx [ 372 ] = xx [ 1 ] ; xx [ 373
] = xx [ 1 ] ; xx [ 374 ] = xx [ 1 ] ; xx [ 375 ] = xx [ 1 ] ; xx [ 376 ] = -
xx [ 18 ] ; xx [ 377 ] = xx [ 83 ] - xx [ 79 ] ; xx [ 378 ] = xx [ 1 ] ; xx [
379 ] = xx [ 1 ] ; xx [ 380 ] = xx [ 1 ] ; xx [ 381 ] = xx [ 1 ] ; xx [ 382 ]
= xx [ 0 ] ; xx [ 383 ] = xx [ 10 ] * ( xx [ 97 ] + xx [ 219 ] * xx [ 91 ] )
+ xx [ 4 ] - xx [ 132 ] ; xx [ 384 ] = xx [ 10 ] * ( xx [ 106 ] - xx [ 219 ]
* xx [ 94 ] ) + xx [ 39 ] ; xx [ 385 ] = ( xx [ 117 ] * xx [ 24 ] + xx [ 110
] ) * xx [ 10 ] - xx [ 125 ] ; xx [ 386 ] = xx [ 1 ] ; xx [ 387 ] = xx [ 1 ]
; xx [ 388 ] = xx [ 1 ] ; xx [ 389 ] = xx [ 1 ] ; xx [ 390 ] = xx [ 1 ] ; xx
[ 391 ] = xx [ 1 ] ; xx [ 392 ] = xx [ 1 ] ; xx [ 393 ] = xx [ 1 ] ; xx [ 394
] = xx [ 1 ] ; xx [ 395 ] = xx [ 1 ] ; xx [ 396 ] = xx [ 79 ] - xx [ 17 ] ;
xx [ 397 ] = - xx [ 16 ] ; xx [ 398 ] = xx [ 1 ] ; xx [ 399 ] = xx [ 1 ] ; xx
[ 400 ] = xx [ 1 ] ; xx [ 401 ] = xx [ 1 ] ; xx [ 402 ] = xx [ 1 ] ; xx [ 403
] = ( xx [ 98 ] - xx [ 120 ] * xx [ 20 ] ) * xx [ 10 ] - xx [ 29 ] - xx [ 117
] ; xx [ 404 ] = xx [ 10 ] * ( xx [ 107 ] - xx [ 219 ] * xx [ 89 ] ) + xx [
26 ] + xx [ 125 ] ; xx [ 405 ] = xx [ 10 ] * ( xx [ 111 ] - xx [ 219 ] * xx [
99 ] ) ; xx [ 406 ] = xx [ 1 ] ; xx [ 407 ] = - xx [ 7 ] ; xx [ 408 ] = xx [
12 ] ; xx [ 409 ] = xx [ 1 ] ; xx [ 410 ] = xx [ 71 ] + xx [ 71 ] ; xx [ 411
] = - ( xx [ 100 ] + xx [ 100 ] ) ; xx [ 412 ] = xx [ 1 ] ; xx [ 413 ] = xx [
1 ] ; xx [ 414 ] = xx [ 1 ] ; xx [ 415 ] = xx [ 1 ] ; xx [ 416 ] = xx [ 1 ] ;
xx [ 417 ] = xx [ 1 ] ; xx [ 418 ] = xx [ 1 ] ; xx [ 419 ] = xx [ 1 ] ; xx [
420 ] = xx [ 1 ] ; xx [ 421 ] = xx [ 1 ] ; xx [ 422 ] = xx [ 1 ] ; xx [ 423 ]
= xx [ 1 ] ; xx [ 424 ] = xx [ 1 ] ; xx [ 425 ] = xx [ 1 ] ; xx [ 426 ] = xx
[ 1 ] ; xx [ 427 ] = xx [ 50 ] ; xx [ 428 ] = xx [ 9 ] - xx [ 55 ] ; xx [ 429
] = xx [ 1 ] ; xx [ 430 ] = - ( xx [ 103 ] + xx [ 103 ] ) ; xx [ 431 ] = xx [
62 ] + xx [ 62 ] - xx [ 159 ] ; xx [ 432 ] = xx [ 1 ] ; xx [ 433 ] = xx [ 1 ]
; xx [ 434 ] = xx [ 1 ] ; xx [ 435 ] = xx [ 1 ] ; xx [ 436 ] = xx [ 1 ] ; xx
[ 437 ] = xx [ 1 ] ; xx [ 438 ] = xx [ 1 ] ; xx [ 439 ] = xx [ 1 ] ; xx [ 440
] = xx [ 1 ] ; xx [ 441 ] = xx [ 1 ] ; xx [ 442 ] = xx [ 1 ] ; xx [ 443 ] =
xx [ 1 ] ; xx [ 444 ] = xx [ 1 ] ; xx [ 445 ] = xx [ 1 ] ; xx [ 446 ] = xx [
1 ] ; xx [ 447 ] = xx [ 2 ] - xx [ 9 ] ; xx [ 448 ] = xx [ 5 ] ; xx [ 449 ] =
xx [ 1 ] ; xx [ 450 ] = xx [ 159 ] - ( xx [ 112 ] + xx [ 112 ] ) ; xx [ 451 ]
= - ( xx [ 57 ] + xx [ 57 ] ) ; xx [ 452 ] = xx [ 1 ] ; xx [ 453 ] = xx [ 1 ]
; xx [ 454 ] = xx [ 1 ] ; xx [ 455 ] = xx [ 1 ] ; xx [ 456 ] = xx [ 1 ] ; xx
[ 457 ] = xx [ 1 ] ; xx [ 458 ] = xx [ 1 ] ; xx [ 459 ] = xx [ 1 ] ; xx [ 460
] = xx [ 1 ] ; xx [ 461 ] = xx [ 1 ] ; xx [ 462 ] = xx [ 1 ] ; xx [ 463 ] =
xx [ 1 ] ; xx [ 464 ] = xx [ 1 ] ; xx [ 465 ] = xx [ 1 ] ; xx [ 466 ] = xx [
1 ] ; xx [ 467 ] = xx [ 1 ] ; xx [ 468 ] = xx [ 1 ] ; xx [ 469 ] = xx [ 1 ] ;
xx [ 470 ] = xx [ 1 ] ; xx [ 471 ] = xx [ 1 ] ; xx [ 472 ] = xx [ 1 ] ; xx [
473 ] = xx [ 1 ] ; xx [ 474 ] = xx [ 1 ] ; xx [ 475 ] = xx [ 1 ] ; xx [ 476 ]
= - xx [ 82 ] ; xx [ 477 ] = xx [ 84 ] ; xx [ 478 ] = xx [ 1 ] ; xx [ 479 ] =
xx [ 104 ] + xx [ 104 ] ; xx [ 480 ] = - ( xx [ 114 ] + xx [ 114 ] ) ; xx [
481 ] = xx [ 1 ] ; xx [ 482 ] = xx [ 1 ] ; xx [ 483 ] = xx [ 1 ] ; xx [ 484 ]
= xx [ 1 ] ; xx [ 485 ] = xx [ 1 ] ; xx [ 486 ] = xx [ 1 ] ; xx [ 487 ] = xx
[ 1 ] ; xx [ 488 ] = xx [ 1 ] ; xx [ 489 ] = xx [ 1 ] ; xx [ 490 ] = xx [ 1 ]
; xx [ 491 ] = xx [ 1 ] ; xx [ 492 ] = xx [ 1 ] ; xx [ 493 ] = xx [ 1 ] ; xx
[ 494 ] = xx [ 1 ] ; xx [ 495 ] = xx [ 1 ] ; xx [ 496 ] = xx [ 18 ] ; xx [
497 ] = xx [ 79 ] - xx [ 83 ] ; xx [ 498 ] = xx [ 1 ] ; xx [ 499 ] = - ( xx [
116 ] + xx [ 116 ] ) ; xx [ 500 ] = xx [ 102 ] + xx [ 102 ] - xx [ 177 ] ; xx
[ 501 ] = xx [ 1 ] ; xx [ 502 ] = xx [ 1 ] ; xx [ 503 ] = xx [ 1 ] ; xx [ 504
] = xx [ 1 ] ; xx [ 505 ] = xx [ 1 ] ; xx [ 506 ] = xx [ 1 ] ; xx [ 507 ] =
xx [ 1 ] ; xx [ 508 ] = xx [ 1 ] ; xx [ 509 ] = xx [ 1 ] ; xx [ 510 ] = xx [
1 ] ; xx [ 511 ] = xx [ 1 ] ; xx [ 512 ] = xx [ 1 ] ; xx [ 513 ] = xx [ 1 ] ;
xx [ 514 ] = xx [ 1 ] ; xx [ 515 ] = xx [ 1 ] ; xx [ 516 ] = xx [ 17 ] - xx [
79 ] ; xx [ 517 ] = xx [ 16 ] ; xx [ 518 ] = xx [ 1 ] ; xx [ 519 ] = xx [ 177
] - ( xx [ 119 ] + xx [ 119 ] ) ; xx [ 520 ] = - ( xx [ 93 ] + xx [ 93 ] ) ;
xx [ 521 ] = xx [ 1 ] ; xx [ 522 ] = xx [ 1 ] ; xx [ 523 ] = xx [ 1 ] ; xx [
524 ] = xx [ 1 ] ; xx [ 525 ] = xx [ 1 ] ; xx [ 0 ] = - xx [ 179 ] ; xx [ 1 ]
= - xx [ 180 ] ; xx [ 2 ] = - xx [ 181 ] ; xx [ 4 ] = xx [ 6 ] * xx [ 183 ] ;
xx [ 5 ] = xx [ 6 ] * xx [ 184 ] ; xx [ 7 ] = xx [ 180 ] * xx [ 4 ] + xx [
181 ] * xx [ 5 ] ; xx [ 9 ] = xx [ 179 ] * xx [ 4 ] ; xx [ 12 ] = xx [ 179 ]
* xx [ 5 ] ; xx [ 16 ] = xx [ 7 ] ; xx [ 17 ] = - xx [ 9 ] ; xx [ 18 ] = - xx
[ 12 ] ; pm_math_cross3 ( xx + 0 , xx + 16 , xx + 19 ) ; xx [ 16 ] = xx [ 10
] * ( xx [ 19 ] - xx [ 7 ] * xx [ 178 ] ) ; xx [ 7 ] = xx [ 16 ] + xx [ 16 ]
; xx [ 22 ] = - xx [ 219 ] ; xx [ 23 ] = xx [ 8 ] ; xx [ 24 ] = xx [ 13 ] ;
xx [ 25 ] = xx [ 15 ] ; pm_math_cross3 ( xx + 223 , xx + 33 , xx + 15 ) ;
pm_math_quatXform ( xx + 22 , xx + 15 , xx + 26 ) ; xx [ 8 ] = xx [ 14 ] * xx
[ 224 ] ; xx [ 13 ] = xx [ 14 ] * xx [ 223 ] ; xx [ 15 ] = xx [ 222 ] * xx [
13 ] ; xx [ 16 ] = xx [ 222 ] * xx [ 8 ] ; xx [ 17 ] = xx [ 220 ] * xx [ 13 ]
+ xx [ 221 ] * xx [ 8 ] ; xx [ 29 ] = xx [ 15 ] ; xx [ 30 ] = xx [ 16 ] ; xx
[ 31 ] = - xx [ 17 ] ; pm_math_cross3 ( xx + 220 , xx + 29 , xx + 39 ) ; xx [
18 ] = xx [ 216 ] + xx [ 8 ] + ( xx [ 219 ] * xx [ 15 ] + xx [ 39 ] ) * xx [
10 ] ; xx [ 8 ] = xx [ 5 ] + ( xx [ 178 ] * xx [ 9 ] + xx [ 20 ] ) * xx [ 10
] ; xx [ 5 ] = xx [ 8 ] + xx [ 8 ] ; xx [ 8 ] = xx [ 217 ] + ( xx [ 219 ] *
xx [ 16 ] + xx [ 40 ] ) * xx [ 10 ] - xx [ 13 ] ; xx [ 9 ] = ( xx [ 178 ] *
xx [ 12 ] + xx [ 21 ] ) * xx [ 10 ] - xx [ 4 ] ; xx [ 4 ] = xx [ 9 ] + xx [ 9
] ; xx [ 9 ] = xx [ 218 ] + xx [ 10 ] * ( xx [ 41 ] - xx [ 17 ] * xx [ 219 ]
) ; xx [ 15 ] = - xx [ 193 ] ; xx [ 16 ] = - xx [ 194 ] ; xx [ 17 ] = - xx [
195 ] ; xx [ 12 ] = xx [ 68 ] * xx [ 197 ] ; xx [ 13 ] = xx [ 68 ] * xx [ 198
] ; xx [ 19 ] = xx [ 194 ] * xx [ 12 ] + xx [ 195 ] * xx [ 13 ] ; xx [ 20 ] =
xx [ 193 ] * xx [ 12 ] ; xx [ 21 ] = xx [ 193 ] * xx [ 13 ] ; xx [ 29 ] = xx
[ 19 ] ; xx [ 30 ] = - xx [ 20 ] ; xx [ 31 ] = - xx [ 21 ] ; pm_math_cross3 (
xx + 15 , xx + 29 , xx + 39 ) ; xx [ 29 ] = xx [ 10 ] * ( xx [ 39 ] - xx [ 19
] * xx [ 192 ] ) ; pm_math_cross3 ( xx + 223 , xx + 36 , xx + 30 ) ;
pm_math_quatXform ( xx + 22 , xx + 30 , xx + 42 ) ; xx [ 19 ] = xx [ 13 ] + (
xx [ 192 ] * xx [ 20 ] + xx [ 40 ] ) * xx [ 10 ] ; xx [ 13 ] = ( xx [ 192 ] *
xx [ 21 ] + xx [ 41 ] ) * xx [ 10 ] - xx [ 12 ] ; xx [ 30 ] = - xx [ 200 ] ;
xx [ 31 ] = - xx [ 201 ] ; xx [ 32 ] = - xx [ 202 ] ; xx [ 12 ] = xx [ 108 ]
* xx [ 204 ] ; xx [ 20 ] = xx [ 108 ] * xx [ 205 ] ; xx [ 21 ] = xx [ 201 ] *
xx [ 12 ] + xx [ 202 ] * xx [ 20 ] ; xx [ 39 ] = xx [ 200 ] * xx [ 12 ] ; xx
[ 40 ] = xx [ 200 ] * xx [ 20 ] ; xx [ 45 ] = xx [ 21 ] ; xx [ 46 ] = - xx [
39 ] ; xx [ 47 ] = - xx [ 40 ] ; pm_math_cross3 ( xx + 30 , xx + 45 , xx + 48
) ; xx [ 41 ] = xx [ 10 ] * ( xx [ 48 ] - xx [ 21 ] * xx [ 199 ] ) ; xx [ 21
] = xx [ 41 ] + xx [ 41 ] ; pm_math_cross3 ( xx + 223 , xx + 52 , xx + 45 ) ;
pm_math_quatXform ( xx + 22 , xx + 45 , xx + 55 ) ; xx [ 41 ] = xx [ 20 ] + (
xx [ 199 ] * xx [ 39 ] + xx [ 49 ] ) * xx [ 10 ] ; xx [ 20 ] = xx [ 41 ] + xx
[ 41 ] ; xx [ 39 ] = ( xx [ 199 ] * xx [ 40 ] + xx [ 50 ] ) * xx [ 10 ] - xx
[ 12 ] ; xx [ 12 ] = xx [ 39 ] + xx [ 39 ] ; xx [ 39 ] = - xx [ 186 ] ; xx [
40 ] = - xx [ 187 ] ; xx [ 41 ] = - xx [ 188 ] ; xx [ 45 ] = xx [ 145 ] * xx
[ 190 ] ; xx [ 46 ] = xx [ 145 ] * xx [ 191 ] ; xx [ 47 ] = xx [ 187 ] * xx [
45 ] + xx [ 188 ] * xx [ 46 ] ; xx [ 48 ] = xx [ 186 ] * xx [ 45 ] ; xx [ 49
] = xx [ 186 ] * xx [ 46 ] ; xx [ 58 ] = xx [ 47 ] ; xx [ 59 ] = - xx [ 48 ]
; xx [ 60 ] = - xx [ 49 ] ; pm_math_cross3 ( xx + 39 , xx + 58 , xx + 61 ) ;
xx [ 50 ] = xx [ 10 ] * ( xx [ 61 ] - xx [ 47 ] * xx [ 185 ] ) ; xx [ 47 ] =
xx [ 46 ] + ( xx [ 185 ] * xx [ 48 ] + xx [ 62 ] ) * xx [ 10 ] ; xx [ 46 ] =
( xx [ 185 ] * xx [ 49 ] + xx [ 63 ] ) * xx [ 10 ] - xx [ 45 ] ; xx [ 58 ] =
- xx [ 207 ] ; xx [ 59 ] = - xx [ 208 ] ; xx [ 60 ] = - xx [ 209 ] ; xx [ 45
] = xx [ 163 ] * xx [ 211 ] ; xx [ 48 ] = xx [ 163 ] * xx [ 212 ] ; xx [ 49 ]
= xx [ 208 ] * xx [ 45 ] + xx [ 209 ] * xx [ 48 ] ; xx [ 51 ] = xx [ 207 ] *
xx [ 45 ] ; xx [ 61 ] = xx [ 207 ] * xx [ 48 ] ; xx [ 62 ] = xx [ 49 ] ; xx [
63 ] = - xx [ 51 ] ; xx [ 64 ] = - xx [ 61 ] ; pm_math_cross3 ( xx + 58 , xx
+ 62 , xx + 65 ) ; xx [ 62 ] = xx [ 10 ] * ( xx [ 65 ] - xx [ 49 ] * xx [ 206
] ) ; xx [ 49 ] = xx [ 48 ] + ( xx [ 206 ] * xx [ 51 ] + xx [ 66 ] ) * xx [
10 ] ; xx [ 48 ] = ( xx [ 206 ] * xx [ 61 ] + xx [ 67 ] ) * xx [ 10 ] - xx [
45 ] ; xx [ 69 ] = xx [ 7 ] - ( xx [ 26 ] + xx [ 18 ] ) ; xx [ 70 ] = xx [ 5
] - ( xx [ 27 ] + xx [ 8 ] ) ; xx [ 71 ] = xx [ 4 ] - ( xx [ 28 ] + xx [ 9 ]
) ; xx [ 72 ] = xx [ 29 ] + xx [ 29 ] - ( xx [ 42 ] + xx [ 18 ] ) ; xx [ 73 ]
= xx [ 19 ] + xx [ 19 ] - ( xx [ 43 ] + xx [ 8 ] ) ; xx [ 74 ] = xx [ 13 ] +
xx [ 13 ] - ( xx [ 44 ] + xx [ 9 ] ) ; xx [ 75 ] = xx [ 21 ] - ( xx [ 55 ] +
xx [ 18 ] ) ; xx [ 76 ] = xx [ 20 ] - ( xx [ 56 ] + xx [ 8 ] ) ; xx [ 77 ] =
xx [ 12 ] - ( xx [ 57 ] + xx [ 9 ] ) ; xx [ 78 ] = xx [ 50 ] + xx [ 50 ] - xx
[ 7 ] ; xx [ 79 ] = xx [ 47 ] + xx [ 47 ] - xx [ 5 ] ; xx [ 80 ] = xx [ 46 ]
+ xx [ 46 ] - xx [ 4 ] ; xx [ 81 ] = xx [ 62 ] + xx [ 62 ] - xx [ 21 ] ; xx [
82 ] = xx [ 49 ] + xx [ 49 ] - xx [ 20 ] ; xx [ 83 ] = xx [ 48 ] + xx [ 48 ]
- xx [ 12 ] ; memcpy ( xx + 526 , xx + 226 , 300 * sizeof ( double ) ) ;
factorAndSolveWide ( 15 , 20 , xx + 526 , xx + 109 , xx + 124 , ii + 0 , xx +
69 , xx [ 11 ] , xx + 84 ) ; xx [ 4 ] = xx [ 183 ] + xx [ 85 ] ; xx [ 5 ] =
xx [ 184 ] + xx [ 86 ] ; xx [ 7 ] = xx [ 190 ] + xx [ 88 ] ; xx [ 8 ] = xx [
191 ] + xx [ 89 ] ; xx [ 9 ] = xx [ 197 ] + xx [ 91 ] ; xx [ 11 ] = xx [ 198
] + xx [ 92 ] ; xx [ 12 ] = xx [ 204 ] + xx [ 94 ] ; xx [ 13 ] = xx [ 205 ] +
xx [ 95 ] ; xx [ 18 ] = xx [ 211 ] + xx [ 97 ] ; xx [ 19 ] = xx [ 212 ] + xx
[ 98 ] ; xx [ 20 ] = xx [ 216 ] + xx [ 99 ] ; xx [ 21 ] = xx [ 217 ] + xx [
100 ] ; xx [ 26 ] = xx [ 223 ] + xx [ 101 ] ; xx [ 27 ] = xx [ 224 ] + xx [
102 ] ; xx [ 28 ] = xx [ 225 ] + xx [ 103 ] ; xx [ 223 ] = xx [ 178 ] ; xx [
224 ] = xx [ 179 ] ; xx [ 225 ] = xx [ 180 ] ; xx [ 226 ] = xx [ 181 ] ; xx [
227 ] = xx [ 182 ] + xx [ 84 ] ; xx [ 228 ] = xx [ 4 ] ; xx [ 229 ] = xx [ 5
] ; xx [ 230 ] = xx [ 185 ] ; xx [ 231 ] = xx [ 186 ] ; xx [ 232 ] = xx [ 187
] ; xx [ 233 ] = xx [ 188 ] ; xx [ 234 ] = xx [ 189 ] + xx [ 87 ] ; xx [ 235
] = xx [ 7 ] ; xx [ 236 ] = xx [ 8 ] ; xx [ 237 ] = xx [ 192 ] ; xx [ 238 ] =
xx [ 193 ] ; xx [ 239 ] = xx [ 194 ] ; xx [ 240 ] = xx [ 195 ] ; xx [ 241 ] =
xx [ 196 ] + xx [ 90 ] ; xx [ 242 ] = xx [ 9 ] ; xx [ 243 ] = xx [ 11 ] ; xx
[ 244 ] = xx [ 199 ] ; xx [ 245 ] = xx [ 200 ] ; xx [ 246 ] = xx [ 201 ] ; xx
[ 247 ] = xx [ 202 ] ; xx [ 248 ] = xx [ 203 ] + xx [ 93 ] ; xx [ 249 ] = xx
[ 12 ] ; xx [ 250 ] = xx [ 13 ] ; xx [ 251 ] = xx [ 206 ] ; xx [ 252 ] = xx [
207 ] ; xx [ 253 ] = xx [ 208 ] ; xx [ 254 ] = xx [ 209 ] ; xx [ 255 ] = xx [
210 ] + xx [ 96 ] ; xx [ 256 ] = xx [ 18 ] ; xx [ 257 ] = xx [ 19 ] ; xx [
258 ] = xx [ 213 ] ; xx [ 259 ] = xx [ 214 ] ; xx [ 260 ] = xx [ 215 ] ; xx [
261 ] = xx [ 20 ] ; xx [ 262 ] = xx [ 21 ] ; xx [ 263 ] = xx [ 218 ] ; xx [
264 ] = xx [ 219 ] ; xx [ 265 ] = xx [ 220 ] ; xx [ 266 ] = xx [ 221 ] ; xx [
267 ] = xx [ 222 ] ; xx [ 268 ] = xx [ 26 ] ; xx [ 269 ] = xx [ 27 ] ; xx [
270 ] = xx [ 28 ] ; pm_math_cross3 ( xx + 26 , xx + 33 , xx + 42 ) ;
pm_math_quatXform ( xx + 22 , xx + 42 , xx + 33 ) ; xx [ 29 ] = xx [ 27 ] *
xx [ 14 ] ; xx [ 42 ] = xx [ 26 ] * xx [ 14 ] ; xx [ 14 ] = xx [ 222 ] * xx [
42 ] ; xx [ 43 ] = xx [ 222 ] * xx [ 29 ] ; xx [ 44 ] = xx [ 220 ] * xx [ 42
] + xx [ 221 ] * xx [ 29 ] ; xx [ 45 ] = xx [ 14 ] ; xx [ 46 ] = xx [ 43 ] ;
xx [ 47 ] = - xx [ 44 ] ; pm_math_cross3 ( xx + 220 , xx + 45 , xx + 48 ) ;
xx [ 45 ] = xx [ 20 ] + xx [ 29 ] + ( xx [ 219 ] * xx [ 14 ] + xx [ 48 ] ) *
xx [ 10 ] ; xx [ 14 ] = xx [ 4 ] * xx [ 6 ] ; xx [ 4 ] = xx [ 5 ] * xx [ 6 ]
; xx [ 5 ] = xx [ 180 ] * xx [ 14 ] + xx [ 181 ] * xx [ 4 ] ; xx [ 6 ] = xx [
179 ] * xx [ 14 ] ; xx [ 20 ] = xx [ 179 ] * xx [ 4 ] ; xx [ 55 ] = xx [ 5 ]
; xx [ 56 ] = - xx [ 6 ] ; xx [ 57 ] = - xx [ 20 ] ; pm_math_cross3 ( xx + 0
, xx + 55 , xx + 61 ) ; xx [ 0 ] = xx [ 10 ] * ( xx [ 61 ] - xx [ 5 ] * xx [
178 ] ) ; xx [ 1 ] = xx [ 0 ] + xx [ 0 ] ; xx [ 0 ] = xx [ 21 ] + ( xx [ 219
] * xx [ 43 ] + xx [ 49 ] ) * xx [ 10 ] - xx [ 42 ] ; xx [ 2 ] = xx [ 4 ] + (
xx [ 178 ] * xx [ 6 ] + xx [ 62 ] ) * xx [ 10 ] ; xx [ 4 ] = xx [ 2 ] + xx [
2 ] ; xx [ 2 ] = xx [ 218 ] + xx [ 10 ] * ( xx [ 50 ] - xx [ 44 ] * xx [ 219
] ) ; xx [ 5 ] = ( xx [ 178 ] * xx [ 20 ] + xx [ 63 ] ) * xx [ 10 ] - xx [ 14
] ; xx [ 6 ] = xx [ 5 ] + xx [ 5 ] ; pm_math_cross3 ( xx + 26 , xx + 36 , xx
+ 42 ) ; pm_math_quatXform ( xx + 22 , xx + 42 , xx + 36 ) ; xx [ 5 ] = xx [
9 ] * xx [ 68 ] ; xx [ 9 ] = xx [ 11 ] * xx [ 68 ] ; xx [ 11 ] = xx [ 194 ] *
xx [ 5 ] + xx [ 195 ] * xx [ 9 ] ; xx [ 14 ] = xx [ 193 ] * xx [ 5 ] ; xx [
20 ] = xx [ 193 ] * xx [ 9 ] ; xx [ 42 ] = xx [ 11 ] ; xx [ 43 ] = - xx [ 14
] ; xx [ 44 ] = - xx [ 20 ] ; pm_math_cross3 ( xx + 15 , xx + 42 , xx + 46 )
; xx [ 15 ] = xx [ 10 ] * ( xx [ 46 ] - xx [ 11 ] * xx [ 192 ] ) ; xx [ 11 ]
= xx [ 9 ] + ( xx [ 192 ] * xx [ 14 ] + xx [ 47 ] ) * xx [ 10 ] ; xx [ 9 ] =
( xx [ 192 ] * xx [ 20 ] + xx [ 48 ] ) * xx [ 10 ] - xx [ 5 ] ;
pm_math_cross3 ( xx + 26 , xx + 52 , xx + 42 ) ; pm_math_quatXform ( xx + 22
, xx + 42 , xx + 26 ) ; xx [ 5 ] = xx [ 12 ] * xx [ 108 ] ; xx [ 12 ] = xx [
13 ] * xx [ 108 ] ; xx [ 13 ] = xx [ 201 ] * xx [ 5 ] + xx [ 202 ] * xx [ 12
] ; xx [ 14 ] = xx [ 200 ] * xx [ 5 ] ; xx [ 16 ] = xx [ 200 ] * xx [ 12 ] ;
xx [ 20 ] = xx [ 13 ] ; xx [ 21 ] = - xx [ 14 ] ; xx [ 22 ] = - xx [ 16 ] ;
pm_math_cross3 ( xx + 30 , xx + 20 , xx + 23 ) ; xx [ 17 ] = xx [ 10 ] * ( xx
[ 23 ] - xx [ 13 ] * xx [ 199 ] ) ; xx [ 13 ] = xx [ 17 ] + xx [ 17 ] ; xx [
17 ] = xx [ 12 ] + ( xx [ 199 ] * xx [ 14 ] + xx [ 24 ] ) * xx [ 10 ] ; xx [
12 ] = xx [ 17 ] + xx [ 17 ] ; xx [ 14 ] = ( xx [ 199 ] * xx [ 16 ] + xx [ 25
] ) * xx [ 10 ] - xx [ 5 ] ; xx [ 5 ] = xx [ 14 ] + xx [ 14 ] ; xx [ 14 ] =
xx [ 7 ] * xx [ 145 ] ; xx [ 7 ] = xx [ 8 ] * xx [ 145 ] ; xx [ 8 ] = xx [
187 ] * xx [ 14 ] + xx [ 188 ] * xx [ 7 ] ; xx [ 16 ] = xx [ 186 ] * xx [ 14
] ; xx [ 17 ] = xx [ 186 ] * xx [ 7 ] ; xx [ 20 ] = xx [ 8 ] ; xx [ 21 ] = -
xx [ 16 ] ; xx [ 22 ] = - xx [ 17 ] ; pm_math_cross3 ( xx + 39 , xx + 20 , xx
+ 23 ) ; xx [ 20 ] = xx [ 10 ] * ( xx [ 23 ] - xx [ 8 ] * xx [ 185 ] ) ; xx [
8 ] = xx [ 7 ] + ( xx [ 185 ] * xx [ 16 ] + xx [ 24 ] ) * xx [ 10 ] ; xx [ 7
] = ( xx [ 185 ] * xx [ 17 ] + xx [ 25 ] ) * xx [ 10 ] - xx [ 14 ] ; xx [ 14
] = xx [ 18 ] * xx [ 163 ] ; xx [ 16 ] = xx [ 19 ] * xx [ 163 ] ; xx [ 17 ] =
xx [ 208 ] * xx [ 14 ] + xx [ 209 ] * xx [ 16 ] ; xx [ 18 ] = xx [ 207 ] * xx
[ 14 ] ; xx [ 19 ] = xx [ 207 ] * xx [ 16 ] ; xx [ 21 ] = xx [ 17 ] ; xx [ 22
] = - xx [ 18 ] ; xx [ 23 ] = - xx [ 19 ] ; pm_math_cross3 ( xx + 58 , xx +
21 , xx + 29 ) ; xx [ 21 ] = xx [ 10 ] * ( xx [ 29 ] - xx [ 17 ] * xx [ 206 ]
) ; xx [ 17 ] = xx [ 16 ] + ( xx [ 206 ] * xx [ 18 ] + xx [ 30 ] ) * xx [ 10
] ; xx [ 16 ] = ( xx [ 206 ] * xx [ 19 ] + xx [ 31 ] ) * xx [ 10 ] - xx [ 14
] ; xx [ 46 ] = fabs ( xx [ 33 ] + xx [ 45 ] - xx [ 1 ] ) ; xx [ 47 ] = fabs
( xx [ 34 ] + xx [ 0 ] - xx [ 4 ] ) ; xx [ 48 ] = fabs ( xx [ 35 ] + xx [ 2 ]
- xx [ 6 ] ) ; xx [ 49 ] = fabs ( xx [ 36 ] + xx [ 45 ] - ( xx [ 15 ] + xx [
15 ] ) ) ; xx [ 50 ] = fabs ( xx [ 37 ] + xx [ 0 ] - ( xx [ 11 ] + xx [ 11 ]
) ) ; xx [ 51 ] = fabs ( xx [ 38 ] + xx [ 2 ] - ( xx [ 9 ] + xx [ 9 ] ) ) ;
xx [ 52 ] = fabs ( xx [ 26 ] + xx [ 45 ] - xx [ 13 ] ) ; xx [ 53 ] = fabs (
xx [ 27 ] + xx [ 0 ] - xx [ 12 ] ) ; xx [ 54 ] = fabs ( xx [ 28 ] + xx [ 2 ]
- xx [ 5 ] ) ; xx [ 55 ] = fabs ( xx [ 1 ] - ( xx [ 20 ] + xx [ 20 ] ) ) ; xx
[ 56 ] = fabs ( xx [ 4 ] - ( xx [ 8 ] + xx [ 8 ] ) ) ; xx [ 57 ] = fabs ( xx
[ 6 ] - ( xx [ 7 ] + xx [ 7 ] ) ) ; xx [ 58 ] = fabs ( xx [ 13 ] - ( xx [ 21
] + xx [ 21 ] ) ) ; xx [ 59 ] = fabs ( xx [ 12 ] - ( xx [ 17 ] + xx [ 17 ] )
) ; xx [ 60 ] = fabs ( xx [ 5 ] - ( xx [ 16 ] + xx [ 16 ] ) ) ; ii [ 0 ] = 46
; { int ll ; for ( ll = 47 ; ll < 61 ; ++ ll ) if ( xx [ ll ] > xx [ ii [ 0 ]
] ) ii [ 0 ] = ll ; } ii [ 0 ] -= 46 ; xx [ 0 ] = xx [ 46 + ( ii [ 0 ] ) ] ;
xx [ 1 ] = xx [ 0 ] - xx [ 3 ] ; if ( xx [ 1 ] < 0.0 ) ii [ 1 ] = - 1 ; else
if ( xx [ 1 ] > 0.0 ) ii [ 1 ] = + 1 ; else ii [ 1 ] = 0 ; ii [ 2 ] = ii [ 1
] ; if ( 0 > ii [ 2 ] ) ii [ 2 ] = 0 ; if ( ii [ 2 ] != 0 ) { switch ( ii [ 0
] ) { case 0 : case 1 : case 2 : { return sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:ConstraintViolation" ,
 "'Kinematics_Model/Lower Ball Joint' kinematic constraints cannot be maintained. Check solver type and consistency tolerance in the Simscape Solver Configuration block. Check Simulink solver type and tolerances in Model Configuration Parameters. A kinematic singularity might be the source of this problem."
, neDiagMgr ) ; } case 3 : case 4 : case 5 : { return
sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:ConstraintViolation" ,
 "'Kinematics_Model/Trackrod  Outer Joint' kinematic constraints cannot be maintained. Check solver type and consistency tolerance in the Simscape Solver Configuration block. Check Simulink solver type and tolerances in Model Configuration Parameters. A kinematic singularity might be the source of this problem."
, neDiagMgr ) ; } case 6 : case 7 : case 8 : { return
sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:ConstraintViolation" ,
 "'Kinematics_Model/Upper Ball Joint' kinematic constraints cannot be maintained. Check solver type and consistency tolerance in the Simscape Solver Configuration block. Check Simulink solver type and tolerances in Model Configuration Parameters. A kinematic singularity might be the source of this problem."
, neDiagMgr ) ; } case 9 : case 10 : case 11 : { return
sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:ConstraintViolation" ,
 "'Kinematics_Model/LWB/LWB Apex Joint' kinematic constraints cannot be maintained. Check solver type and consistency tolerance in the Simscape Solver Configuration block. Check Simulink solver type and tolerances in Model Configuration Parameters. A kinematic singularity might be the source of this problem."
, neDiagMgr ) ; } case 12 : case 13 : case 14 : { return
sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:ConstraintViolation" ,
 "'Kinematics_Model/UWB/Spherical Joint' kinematic constraints cannot be maintained. Check solver type and consistency tolerance in the Simscape Solver Configuration block. Check Simulink solver type and tolerances in Model Configuration Parameters. A kinematic singularity might be the source of this problem."
, neDiagMgr ) ; } } } state [ 0 ] = xx [ 223 ] ; state [ 1 ] = xx [ 224 ] ;
state [ 2 ] = xx [ 225 ] ; state [ 3 ] = xx [ 226 ] ; state [ 4 ] = xx [ 227
] ; state [ 5 ] = xx [ 228 ] ; state [ 6 ] = xx [ 229 ] ; state [ 7 ] = xx [
230 ] ; state [ 8 ] = xx [ 231 ] ; state [ 9 ] = xx [ 232 ] ; state [ 10 ] =
xx [ 233 ] ; state [ 11 ] = xx [ 234 ] ; state [ 12 ] = xx [ 235 ] ; state [
13 ] = xx [ 236 ] ; state [ 14 ] = xx [ 237 ] ; state [ 15 ] = xx [ 238 ] ;
state [ 16 ] = xx [ 239 ] ; state [ 17 ] = xx [ 240 ] ; state [ 18 ] = xx [
241 ] ; state [ 19 ] = xx [ 242 ] ; state [ 20 ] = xx [ 243 ] ; state [ 21 ]
= xx [ 244 ] ; state [ 22 ] = xx [ 245 ] ; state [ 23 ] = xx [ 246 ] ; state
[ 24 ] = xx [ 247 ] ; state [ 25 ] = xx [ 248 ] ; state [ 26 ] = xx [ 249 ] ;
state [ 27 ] = xx [ 250 ] ; state [ 28 ] = xx [ 251 ] ; state [ 29 ] = xx [
252 ] ; state [ 30 ] = xx [ 253 ] ; state [ 31 ] = xx [ 254 ] ; state [ 32 ]
= xx [ 255 ] ; state [ 33 ] = xx [ 256 ] ; state [ 34 ] = xx [ 257 ] ; state
[ 35 ] = xx [ 258 ] ; state [ 36 ] = xx [ 259 ] ; state [ 37 ] = xx [ 260 ] ;
state [ 38 ] = xx [ 261 ] ; state [ 39 ] = xx [ 262 ] ; state [ 40 ] = xx [
263 ] ; state [ 41 ] = xx [ 264 ] ; state [ 42 ] = xx [ 265 ] ; state [ 43 ]
= xx [ 266 ] ; state [ 44 ] = xx [ 267 ] ; state [ 45 ] = xx [ 268 ] ; state
[ 46 ] = xx [ 269 ] ; state [ 47 ] = xx [ 270 ] ; return NULL ; }
