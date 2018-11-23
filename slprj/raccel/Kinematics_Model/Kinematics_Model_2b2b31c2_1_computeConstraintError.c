#include "__cf_Kinematics_Model.h"
#include <math.h>
#include <string.h>
#include "pm_std.h"
#include "sm_std.h"
#include "ne_std.h"
#include "ne_dae.h"
#include "sm_ssci_run_time_errors.h"
void Kinematics_Model_2b2b31c2_1_computeConstraintError ( const void * mech ,
const double * rtdv , const double * state , double * error ) { double xx [
30 ] ; ( void ) mech ; ( void ) rtdv ; xx [ 0 ] = - state [ 41 ] ; xx [ 1 ] =
- state [ 42 ] ; xx [ 2 ] = - state [ 43 ] ; xx [ 3 ] = - state [ 44 ] ; xx [
4 ] = 8.93e-3 ; xx [ 5 ] = - 0.03858000000000004 ; xx [ 6 ] = -
0.09166000000000001 ; pm_math_quatXform ( xx + 0 , xx + 4 , xx + 7 ) ; xx [ 4
] = 0.23241 ; xx [ 5 ] = xx [ 4 ] * state [ 43 ] ; xx [ 6 ] = xx [ 4 ] *
state [ 42 ] ; xx [ 10 ] = 2.0 ; xx [ 11 ] = ( xx [ 5 ] * state [ 41 ] + xx [
6 ] * state [ 44 ] ) * xx [ 10 ] + state [ 35 ] ; xx [ 12 ] =
0.1761018998335906 ; xx [ 13 ] = xx [ 12 ] * state [ 2 ] ; xx [ 14 ] = xx [
12 ] * state [ 3 ] ; xx [ 15 ] = ( xx [ 13 ] * state [ 2 ] + xx [ 14 ] *
state [ 3 ] ) * xx [ 10 ] ; xx [ 16 ] = xx [ 12 ] - xx [ 15 ] +
0.3530818998335906 - xx [ 15 ] ; xx [ 12 ] = xx [ 10 ] * ( xx [ 5 ] * state [
44 ] - xx [ 6 ] * state [ 41 ] ) + state [ 36 ] ; xx [ 15 ] = ( xx [ 14 ] *
state [ 0 ] + xx [ 13 ] * state [ 1 ] ) * xx [ 10 ] ; xx [ 17 ] = xx [ 15 ] +
0.2523 + xx [ 15 ] ; xx [ 15 ] = state [ 37 ] - ( xx [ 6 ] * state [ 42 ] +
xx [ 5 ] * state [ 43 ] ) * xx [ 10 ] + xx [ 4 ] ; xx [ 4 ] = xx [ 10 ] * (
xx [ 14 ] * state [ 1 ] - xx [ 13 ] * state [ 0 ] ) ; xx [ 5 ] = xx [ 4 ] +
0.12489 + xx [ 4 ] ; xx [ 18 ] = 0.07589 ; xx [ 19 ] = - 0.04750999999999999
; xx [ 20 ] = 8.530000000000001e-3 ; pm_math_quatXform ( xx + 0 , xx + 18 ,
xx + 21 ) ; xx [ 4 ] = 0.1624769242846504 ; xx [ 6 ] = xx [ 4 ] * state [ 16
] ; xx [ 13 ] = xx [ 4 ] * state [ 17 ] ; xx [ 4 ] = ( xx [ 6 ] * state [ 16
] + xx [ 13 ] * state [ 17 ] ) * xx [ 10 ] ; xx [ 14 ] = ( xx [ 13 ] * state
[ 14 ] + xx [ 6 ] * state [ 15 ] ) * xx [ 10 ] ; xx [ 18 ] = xx [ 10 ] * ( xx
[ 13 ] * state [ 15 ] - xx [ 6 ] * state [ 14 ] ) ; xx [ 24 ] = - 0.01565 ;
xx [ 25 ] = - 0.05489999999999998 ; xx [ 26 ] = 0.09134 ; pm_math_quatXform (
xx + 0 , xx + 24 , xx + 27 ) ; xx [ 0 ] = 0.1774935228395673 ; xx [ 1 ] = xx
[ 0 ] * state [ 23 ] ; xx [ 2 ] = xx [ 0 ] * state [ 24 ] ; xx [ 3 ] = ( xx [
1 ] * state [ 23 ] + xx [ 2 ] * state [ 24 ] ) * xx [ 10 ] ; xx [ 6 ] = xx [
0 ] - xx [ 3 ] + 0.3560035228395673 - xx [ 3 ] ; xx [ 0 ] = ( xx [ 2 ] *
state [ 21 ] + xx [ 1 ] * state [ 22 ] ) * xx [ 10 ] ; xx [ 3 ] = xx [ 0 ] +
0.25087 + xx [ 0 ] ; xx [ 0 ] = xx [ 10 ] * ( xx [ 2 ] * state [ 22 ] - xx [
1 ] * state [ 21 ] ) ; xx [ 1 ] = xx [ 0 ] + 0.28196 + xx [ 0 ] ; xx [ 0 ] =
0.1675024183407511 ; xx [ 2 ] = xx [ 0 ] * state [ 9 ] ; xx [ 13 ] = xx [ 0 ]
* state [ 10 ] ; xx [ 0 ] = ( xx [ 2 ] * state [ 9 ] + xx [ 13 ] * state [ 10
] ) * xx [ 10 ] ; xx [ 19 ] = ( xx [ 13 ] * state [ 7 ] + xx [ 2 ] * state [
8 ] ) * xx [ 10 ] ; xx [ 20 ] = xx [ 10 ] * ( xx [ 13 ] * state [ 8 ] - xx [
2 ] * state [ 7 ] ) ; xx [ 2 ] = 0.1575773583037868 ; xx [ 13 ] = xx [ 2 ] *
state [ 30 ] ; xx [ 24 ] = xx [ 2 ] * state [ 31 ] ; xx [ 2 ] = ( xx [ 13 ] *
state [ 30 ] + xx [ 24 ] * state [ 31 ] ) * xx [ 10 ] ; xx [ 25 ] = ( xx [ 24
] * state [ 28 ] + xx [ 13 ] * state [ 29 ] ) * xx [ 10 ] ; xx [ 26 ] = xx [
10 ] * ( xx [ 24 ] * state [ 29 ] - xx [ 13 ] * state [ 28 ] ) ; error [ 0 ]
= xx [ 7 ] + xx [ 11 ] - xx [ 16 ] ; error [ 1 ] = xx [ 8 ] + xx [ 12 ] - xx
[ 17 ] ; error [ 2 ] = xx [ 9 ] + xx [ 15 ] - xx [ 5 ] ; error [ 3 ] = xx [
21 ] + xx [ 11 ] + xx [ 4 ] + xx [ 4 ] - 0.4008438485693007 ; error [ 4 ] =
xx [ 22 ] + xx [ 12 ] - ( xx [ 14 ] + xx [ 14 ] ) - 0.23 ; error [ 5 ] = xx [
23 ] + xx [ 15 ] - ( xx [ 18 ] + xx [ 18 ] ) - 0.201 ; error [ 6 ] = xx [ 27
] + xx [ 11 ] - xx [ 6 ] ; error [ 7 ] = xx [ 28 ] + xx [ 12 ] - xx [ 3 ] ;
error [ 8 ] = xx [ 29 ] + xx [ 15 ] - xx [ 1 ] ; error [ 9 ] = xx [ 16 ] + xx
[ 0 ] + xx [ 0 ] - 0.1598848366815023 ; error [ 10 ] = xx [ 17 ] - ( xx [ 19
] + xx [ 19 ] ) - 0.28187 ; error [ 11 ] = xx [ 5 ] - ( xx [ 20 ] + xx [ 20 ]
) - 0.12641 ; error [ 12 ] = xx [ 6 ] + xx [ 2 ] + xx [ 2 ] -
0.1374147166075735 ; error [ 13 ] = xx [ 3 ] - ( xx [ 25 ] + xx [ 25 ] ) -
0.28138 ; error [ 14 ] = xx [ 1 ] - ( xx [ 26 ] + xx [ 26 ] ) - 0.26458 ; }
