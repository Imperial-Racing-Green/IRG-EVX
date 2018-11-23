#include "__cf_Kinematics_Model.h"
#include <math.h>
#include <string.h>
#include "pm_std.h"
#include "sm_std.h"
#include "ne_std.h"
#include "ne_dae.h"
#include "sm_ssci_run_time_errors.h"
PmfMessageId Kinematics_Model_2b2b31c2_1_output ( const double * rtdv , const
double * state , const double * input , const double * inputDot , const
double * inputDdot , const double * discreteState , double * output ,
NeuDiagnosticManager * neDiagMgr ) { double xx [ 29 ] ; ( void ) rtdv ; (
void ) inputDot ; ( void ) inputDdot ; ( void ) discreteState ; ( void )
neDiagMgr ; xx [ 0 ] = - state [ 39 ] ; xx [ 1 ] = sqrt ( state [ 40 ] *
state [ 40 ] + state [ 41 ] * state [ 41 ] + state [ 42 ] * state [ 42 ] ) ;
xx [ 1 ] = xx [ 1 ] == 0.0 ? 0.0 : 1.0 / xx [ 1 ] ; xx [ 2 ] = ( xx [ 0 ] <
0.0 ? - 1.0 : + 1.0 ) * xx [ 1 ] ; xx [ 1 ] = 0.23241 ; xx [ 3 ] = xx [ 1 ] *
state [ 41 ] ; xx [ 4 ] = xx [ 3 ] * state [ 39 ] ; xx [ 5 ] = xx [ 1 ] *
state [ 40 ] ; xx [ 6 ] = xx [ 5 ] * state [ 42 ] ; xx [ 7 ] = 2.0 ; xx [ 8 ]
= ( xx [ 4 ] + xx [ 6 ] ) * xx [ 7 ] + state [ 35 ] ; xx [ 9 ] = xx [ 5 ] *
state [ 39 ] ; xx [ 10 ] = xx [ 3 ] * state [ 42 ] ; xx [ 11 ] = xx [ 7 ] * (
xx [ 10 ] - xx [ 9 ] ) + state [ 36 ] ; xx [ 12 ] = xx [ 5 ] * state [ 40 ] ;
xx [ 5 ] = xx [ 3 ] * state [ 41 ] ; xx [ 3 ] = input [ 0 ] - ( xx [ 12 ] +
xx [ 5 ] ) * xx [ 7 ] + xx [ 1 ] ; xx [ 13 ] = xx [ 0 ] ; xx [ 14 ] = - state
[ 40 ] ; xx [ 15 ] = - state [ 41 ] ; xx [ 16 ] = - state [ 42 ] ; xx [ 17 ]
= 8.93e-3 ; xx [ 18 ] = - 0.03858000000000004 ; xx [ 19 ] = -
0.09166000000000001 ; pm_math_quatXform ( xx + 13 , xx + 17 , xx + 20 ) ; xx
[ 17 ] = 0.07589 ; xx [ 18 ] = - 0.04750999999999999 ; xx [ 19 ] =
8.530000000000001e-3 ; pm_math_quatXform ( xx + 13 , xx + 17 , xx + 23 ) ; xx
[ 17 ] = - 0.01565 ; xx [ 18 ] = - 0.05489999999999998 ; xx [ 19 ] = 0.09134
; pm_math_quatXform ( xx + 13 , xx + 17 , xx + 26 ) ; output [ 0 ] = state [
39 ] ; output [ 1 ] = state [ 40 ] ; output [ 2 ] = state [ 41 ] ; output [ 3
] = state [ 42 ] ; output [ 4 ] = - ( xx [ 2 ] * state [ 40 ] ) ; output [ 5
] = - ( xx [ 2 ] * state [ 41 ] ) ; output [ 6 ] = - ( xx [ 2 ] * state [ 42
] ) ; output [ 7 ] = xx [ 8 ] - ( xx [ 4 ] + xx [ 6 ] ) * xx [ 7 ] ; output [
8 ] = xx [ 7 ] * ( xx [ 9 ] - xx [ 10 ] ) + xx [ 11 ] ; output [ 9 ] = ( xx [
12 ] + xx [ 5 ] ) * xx [ 7 ] - xx [ 1 ] + xx [ 3 ] ; output [ 10 ] = xx [ 20
] + xx [ 8 ] ; output [ 11 ] = xx [ 21 ] + xx [ 11 ] ; output [ 12 ] = xx [
22 ] + xx [ 3 ] ; output [ 13 ] = xx [ 23 ] + xx [ 8 ] ; output [ 14 ] = xx [
24 ] + xx [ 11 ] ; output [ 15 ] = xx [ 25 ] + xx [ 3 ] ; output [ 16 ] = xx
[ 26 ] + xx [ 8 ] ; output [ 17 ] = xx [ 27 ] + xx [ 11 ] ; output [ 18 ] =
xx [ 28 ] + xx [ 3 ] ; return NULL ; }
