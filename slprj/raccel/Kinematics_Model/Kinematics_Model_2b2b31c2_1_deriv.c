#include "__cf_Kinematics_Model.h"
#include <math.h>
#include <string.h>
#include "pm_std.h"
#include "sm_std.h"
#include "ne_std.h"
#include "ne_dae.h"
#include "sm_ssci_run_time_errors.h"
PmfMessageId Kinematics_Model_2b2b31c2_1_deriv ( const double * rtdv , const
int * eqnEnableFlags , const double * state , const double * input , const
double * inputDot , const double * inputDdot , const double * discreteState ,
double * deriv , double * errorResult , NeuDiagnosticManager * neDiagMgr ) {
int ii [ 15 ] ; double xx [ 1166 ] ; ( void ) rtdv ; ( void ) eqnEnableFlags
; ( void ) input ; ( void ) inputDot ; ( void ) discreteState ; ( void )
neDiagMgr ; xx [ 0 ] = state [ 0 ] ; xx [ 1 ] = state [ 1 ] ; xx [ 2 ] =
state [ 2 ] ; xx [ 3 ] = state [ 3 ] ; xx [ 4 ] = state [ 4 ] ; xx [ 5 ] =
state [ 5 ] ; xx [ 6 ] = state [ 6 ] ; pm_math_quatDeriv ( xx + 0 , xx + 4 ,
xx + 7 ) ; xx [ 0 ] = 5.870063327786242e-7 ; xx [ 1 ] = 0.0 ; xx [ 2 ] =
1.456627058185635e-3 ; xx [ 11 ] = xx [ 0 ] ; xx [ 12 ] = xx [ 1 ] ; xx [ 13
] = xx [ 1 ] ; xx [ 14 ] = xx [ 1 ] ; xx [ 15 ] = xx [ 2 ] ; xx [ 16 ] = xx [
1 ] ; xx [ 17 ] = xx [ 1 ] ; xx [ 18 ] = xx [ 1 ] ; xx [ 19 ] = xx [ 2 ] ; ii
[ 0 ] = factorSymmetricPosDef ( xx + 11 , 3 , xx + 20 ) ; if ( ii [ 0 ] != 0
) { return sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:DegenerateMass" ,
 "'Kinematics_Model/LWB Front Joint' has a degenerate mass distribution on its follower side."
, neDiagMgr ) ; } xx [ 2 ] = 3.643768919212007e-4 ; xx [ 20 ] = xx [ 0 ] *
state [ 4 ] ; xx [ 21 ] = xx [ 2 ] * state [ 5 ] ; xx [ 22 ] = xx [ 2 ] *
state [ 6 ] ; pm_math_cross3 ( xx + 4 , xx + 20 , xx + 23 ) ; xx [ 3 ] = - xx
[ 23 ] ; xx [ 4 ] = 2.0 ; xx [ 5 ] = 0.1761018998335906 ; xx [ 6 ] = xx [ 5 ]
* state [ 1 ] ; xx [ 20 ] = xx [ 6 ] * state [ 0 ] ; xx [ 21 ] = xx [ 5 ] *
state [ 2 ] ; xx [ 22 ] = xx [ 4 ] * ( xx [ 20 ] - xx [ 21 ] * state [ 3 ] )
; xx [ 26 ] = xx [ 22 ] + xx [ 22 ] ; xx [ 22 ] = 0.625 ; xx [ 27 ] = state [
39 ] * state [ 39 ] ; xx [ 28 ] = 1.0 ; xx [ 29 ] = ( xx [ 27 ] + state [ 40
] * state [ 40 ] ) * xx [ 4 ] - xx [ 28 ] ; xx [ 30 ] = state [ 40 ] * state
[ 41 ] ; xx [ 31 ] = state [ 39 ] * state [ 42 ] ; xx [ 32 ] = xx [ 4 ] * (
xx [ 30 ] - xx [ 31 ] ) ; xx [ 33 ] = state [ 40 ] * state [ 42 ] ; xx [ 34 ]
= state [ 39 ] * state [ 41 ] ; xx [ 35 ] = xx [ 33 ] + xx [ 34 ] ; xx [ 36 ]
= xx [ 35 ] * xx [ 4 ] ; xx [ 37 ] = ( xx [ 30 ] + xx [ 31 ] ) * xx [ 4 ] ;
xx [ 30 ] = ( xx [ 27 ] + state [ 41 ] * state [ 41 ] ) * xx [ 4 ] - xx [ 28
] ; xx [ 38 ] = state [ 41 ] * state [ 42 ] ; xx [ 39 ] = state [ 39 ] *
state [ 40 ] ; xx [ 40 ] = xx [ 38 ] - xx [ 39 ] ; xx [ 41 ] = xx [ 4 ] * xx
[ 40 ] ; xx [ 42 ] = xx [ 4 ] * ( xx [ 33 ] - xx [ 34 ] ) ; xx [ 33 ] = ( xx
[ 38 ] + xx [ 39 ] ) * xx [ 4 ] ; xx [ 38 ] = ( xx [ 27 ] + state [ 42 ] *
state [ 42 ] ) * xx [ 4 ] - xx [ 28 ] ; xx [ 43 ] = xx [ 29 ] ; xx [ 44 ] =
xx [ 32 ] ; xx [ 45 ] = xx [ 36 ] ; xx [ 46 ] = xx [ 37 ] ; xx [ 47 ] = xx [
30 ] ; xx [ 48 ] = xx [ 41 ] ; xx [ 49 ] = xx [ 42 ] ; xx [ 50 ] = xx [ 33 ]
; xx [ 51 ] = xx [ 38 ] ; xx [ 27 ] = 32.32618649208007 ; xx [ 52 ] =
7.512929002624329 ; xx [ 53 ] = 0.5342804064869975 ; xx [ 54 ] =
2.280360235986918 ; xx [ 55 ] = xx [ 1 ] ; xx [ 56 ] = xx [ 1 ] ; xx [ 57 ] =
xx [ 1 ] ; xx [ 58 ] = 2.61911974424988 ; xx [ 59 ] = xx [ 1 ] ; xx [ 60 ] =
xx [ 1 ] ; xx [ 61 ] = xx [ 1 ] ; xx [ 62 ] = xx [ 53 ] ; ii [ 0 ] =
factorSymmetricPosDef ( xx + 54 , 3 , xx + 63 ) ; if ( ii [ 0 ] != 0 ) {
return sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:DegenerateMass" ,
 "'Kinematics_Model/Actuation and Logging/Tyre Rotation' has a degenerate mass distribution on its follower side."
, neDiagMgr ) ; } xx [ 63 ] = 0.8730399147499601 ; xx [ 64 ] = xx [ 53 ] ; xx
[ 65 ] = xx [ 1 ] ; xx [ 66 ] = xx [ 1 ] ; xx [ 67 ] = xx [ 1 ] ; xx [ 68 ] =
xx [ 63 ] ; xx [ 69 ] = xx [ 1 ] ; xx [ 70 ] = xx [ 1 ] ; xx [ 71 ] = xx [ 1
] ; xx [ 72 ] = xx [ 53 ] ; xx [ 73 ] = xx [ 1 ] ; xx [ 74 ] = xx [ 52 ] ; xx
[ 75 ] = xx [ 1 ] ; xx [ 76 ] = - xx [ 52 ] ; xx [ 77 ] = xx [ 1 ] ; xx [ 78
] = xx [ 1 ] ; xx [ 79 ] = xx [ 1 ] ; xx [ 80 ] = xx [ 1 ] ; xx [ 81 ] = xx [
1 ] ; solveSymmetricPosDef ( xx + 54 , xx + 64 , 3 , 6 , xx + 82 , xx + 100 )
; xx [ 64 ] = xx [ 27 ] - xx [ 52 ] * xx [ 92 ] ; xx [ 65 ] = xx [ 52 ] * xx
[ 91 ] ; xx [ 66 ] = xx [ 27 ] + xx [ 52 ] * xx [ 94 ] ; xx [ 67 ] =
64.65237298416014 ; xx [ 68 ] = xx [ 64 ] * xx [ 29 ] + xx [ 65 ] * xx [ 32 ]
; xx [ 69 ] = xx [ 37 ] * xx [ 64 ] + xx [ 65 ] * xx [ 30 ] ; xx [ 70 ] = xx
[ 42 ] * xx [ 64 ] + xx [ 65 ] * xx [ 33 ] ; xx [ 71 ] = xx [ 32 ] * xx [ 66
] + xx [ 65 ] * xx [ 29 ] ; xx [ 72 ] = xx [ 66 ] * xx [ 30 ] + xx [ 65 ] *
xx [ 37 ] ; xx [ 73 ] = xx [ 33 ] * xx [ 66 ] + xx [ 65 ] * xx [ 42 ] ; xx [
74 ] = xx [ 35 ] * xx [ 67 ] ; xx [ 75 ] = xx [ 67 ] * xx [ 40 ] ; xx [ 76 ]
= xx [ 27 ] * xx [ 38 ] ; pm_math_matrix3x3Compose ( xx + 43 , xx + 68 , xx +
100 ) ; xx [ 35 ] = xx [ 22 ] + xx [ 100 ] ; xx [ 40 ] = xx [ 22 ] + xx [ 104
] ; xx [ 64 ] = xx [ 35 ] ; xx [ 65 ] = xx [ 101 ] ; xx [ 66 ] = xx [ 101 ] ;
xx [ 67 ] = xx [ 40 ] ; ii [ 0 ] = factorSymmetricPosDef ( xx + 64 , 2 , xx +
68 ) ; if ( ii [ 0 ] != 0 ) { return sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:DegenerateMass" ,
 "'Kinematics_Model/Actuation and Logging/Vertical Actuation' has a degenerate mass distribution on its follower side."
, neDiagMgr ) ; } xx [ 68 ] = - state [ 40 ] ; xx [ 69 ] = - state [ 41 ] ;
xx [ 70 ] = - state [ 42 ] ; xx [ 22 ] = 0.09166000000000001 ; xx [ 71 ] = xx
[ 22 ] * state [ 42 ] ; xx [ 72 ] = 0.03858000000000004 ; xx [ 73 ] = xx [ 72
] * state [ 41 ] ; xx [ 74 ] = xx [ 71 ] + xx [ 73 ] ; xx [ 75 ] = xx [ 72 ]
* state [ 40 ] ; xx [ 76 ] = xx [ 74 ] ; xx [ 77 ] = - xx [ 75 ] ; xx [ 78 ]
= - ( xx [ 22 ] * state [ 40 ] ) ; pm_math_cross3 ( xx + 68 , xx + 76 , xx +
79 ) ; xx [ 76 ] = 0.23241 ; xx [ 77 ] = xx [ 76 ] * state [ 42 ] ; xx [ 78 ]
= xx [ 77 ] * state [ 39 ] ; xx [ 109 ] = xx [ 76 ] * state [ 40 ] ; xx [ 110
] = xx [ 4 ] * ( xx [ 78 ] - xx [ 109 ] * state [ 41 ] ) ; xx [ 111 ] = xx [
4 ] * ( xx [ 79 ] - xx [ 74 ] * state [ 39 ] ) + xx [ 110 ] ; xx [ 74 ] =
8.93e-3 ; xx [ 112 ] = xx [ 74 ] * state [ 40 ] ; xx [ 113 ] = xx [ 71 ] - xx
[ 112 ] ; xx [ 71 ] = xx [ 22 ] * state [ 41 ] ; xx [ 114 ] = xx [ 74 ] *
state [ 41 ] ; xx [ 115 ] = xx [ 113 ] ; xx [ 116 ] = - xx [ 71 ] ;
pm_math_cross3 ( xx + 68 , xx + 114 , xx + 117 ) ; xx [ 114 ] = xx [ 76 ] *
state [ 41 ] ; xx [ 115 ] = xx [ 114 ] * state [ 41 ] ; xx [ 116 ] = xx [ 77
] * state [ 42 ] ; xx [ 120 ] = xx [ 76 ] - ( xx [ 115 ] + xx [ 116 ] ) * xx
[ 4 ] ; xx [ 121 ] = ( xx [ 117 ] - xx [ 74 ] * xx [ 34 ] ) * xx [ 4 ] - xx [
22 ] + xx [ 120 ] ; xx [ 122 ] = xx [ 74 ] * state [ 42 ] ; xx [ 123 ] = xx [
73 ] - xx [ 112 ] ; xx [ 124 ] = xx [ 122 ] ; xx [ 125 ] = - ( xx [ 72 ] *
state [ 42 ] ) ; xx [ 126 ] = xx [ 123 ] ; pm_math_cross3 ( xx + 68 , xx +
124 , xx + 127 ) ; xx [ 73 ] = xx [ 72 ] + xx [ 4 ] * ( xx [ 127 ] - xx [ 122
] * state [ 39 ] ) ; xx [ 124 ] = xx [ 111 ] ; xx [ 125 ] = xx [ 121 ] ; xx [
126 ] = xx [ 73 ] ; solveSymmetricPosDef ( xx + 54 , xx + 124 , 3 , 1 , xx +
130 , xx + 133 ) ; xx [ 112 ] = xx [ 52 ] * xx [ 131 ] ; xx [ 124 ] = state [
40 ] ; xx [ 125 ] = state [ 41 ] ; xx [ 126 ] = state [ 42 ] ; xx [ 122 ] =
xx [ 52 ] * xx [ 130 ] ; xx [ 133 ] = xx [ 122 ] * state [ 42 ] ; xx [ 134 ]
= xx [ 112 ] * state [ 42 ] ; xx [ 135 ] = xx [ 133 ] ; xx [ 136 ] = xx [ 134
] ; xx [ 137 ] = - ( xx [ 122 ] * state [ 40 ] + xx [ 112 ] * state [ 41 ] )
; pm_math_cross3 ( xx + 124 , xx + 135 , xx + 138 ) ; xx [ 135 ] = xx [ 28 ]
- ( xx [ 112 ] + xx [ 4 ] * ( xx [ 138 ] + xx [ 133 ] * state [ 39 ] ) ) ; xx
[ 136 ] = - ( ( xx [ 134 ] * state [ 39 ] + xx [ 139 ] ) * xx [ 4 ] - xx [
122 ] ) ; solveSymmetricPosDef ( xx + 64 , xx + 135 , 2 , 1 , xx + 133 , xx +
137 ) ; xx [ 112 ] = xx [ 5 ] * state [ 3 ] ; xx [ 122 ] = xx [ 4 ] * ( xx [
6 ] * state [ 2 ] - xx [ 112 ] * state [ 0 ] ) ; xx [ 135 ] = xx [ 122 ] + xx
[ 122 ] ; xx [ 122 ] = ( xx [ 21 ] * state [ 0 ] + xx [ 6 ] * state [ 3 ] ) *
xx [ 4 ] ; xx [ 136 ] = xx [ 122 ] + xx [ 122 ] ; xx [ 137 ] = xx [ 1 ] ; xx
[ 138 ] = xx [ 136 ] ; xx [ 139 ] = - xx [ 135 ] ; solveSymmetricPosDef ( xx
+ 11 , xx + 137 , 3 , 1 , xx + 140 , xx + 143 ) ; xx [ 137 ] = xx [ 91 ] ; xx
[ 138 ] = xx [ 94 ] ; xx [ 139 ] = xx [ 97 ] ; xx [ 122 ] = xx [ 134 ] *
state [ 42 ] ; xx [ 140 ] = xx [ 133 ] * state [ 42 ] ; xx [ 143 ] = xx [ 134
] * state [ 40 ] - xx [ 133 ] * state [ 41 ] ; xx [ 144 ] = - xx [ 122 ] ; xx
[ 145 ] = xx [ 140 ] ; xx [ 146 ] = xx [ 143 ] ; pm_math_cross3 ( xx + 124 ,
xx + 144 , xx + 147 ) ; xx [ 144 ] = xx [ 133 ] + ( xx [ 122 ] * state [ 39 ]
+ xx [ 147 ] ) * xx [ 4 ] ; xx [ 145 ] = xx [ 134 ] + xx [ 4 ] * ( xx [ 148 ]
- xx [ 140 ] * state [ 39 ] ) ; xx [ 146 ] = xx [ 4 ] * ( xx [ 149 ] - xx [
143 ] * state [ 39 ] ) ; xx [ 147 ] = xx [ 92 ] ; xx [ 148 ] = xx [ 95 ] ; xx
[ 149 ] = xx [ 98 ] ; xx [ 82 ] = xx [ 93 ] ; xx [ 83 ] = xx [ 96 ] ; xx [ 84
] = xx [ 99 ] ; xx [ 85 ] = xx [ 109 ] * state [ 40 ] ; xx [ 86 ] = ( xx [
116 ] + xx [ 85 ] ) * xx [ 4 ] - xx [ 76 ] ; xx [ 87 ] = xx [ 22 ] + xx [ 4 ]
* ( xx [ 80 ] + xx [ 75 ] * state [ 39 ] ) + xx [ 86 ] ; xx [ 75 ] = ( xx [
78 ] + xx [ 114 ] * state [ 40 ] ) * xx [ 4 ] ; xx [ 78 ] = xx [ 4 ] * ( xx [
118 ] - xx [ 113 ] * state [ 39 ] ) + xx [ 75 ] ; xx [ 88 ] = xx [ 74 ] + (
xx [ 72 ] * xx [ 31 ] + xx [ 128 ] ) * xx [ 4 ] ; xx [ 150 ] = xx [ 87 ] ; xx
[ 151 ] = xx [ 78 ] ; xx [ 152 ] = xx [ 88 ] ; solveSymmetricPosDef ( xx + 54
, xx + 150 , 3 , 1 , xx + 153 , xx + 156 ) ; xx [ 89 ] = xx [ 52 ] * xx [ 154
] ; xx [ 90 ] = xx [ 52 ] * xx [ 153 ] ; xx [ 113 ] = xx [ 90 ] * state [ 42
] ; xx [ 116 ] = xx [ 89 ] * state [ 42 ] ; xx [ 150 ] = xx [ 113 ] ; xx [
151 ] = xx [ 116 ] ; xx [ 152 ] = - ( xx [ 90 ] * state [ 40 ] + xx [ 89 ] *
state [ 41 ] ) ; pm_math_cross3 ( xx + 124 , xx + 150 , xx + 156 ) ; xx [ 150
] = - ( xx [ 89 ] + xx [ 4 ] * ( xx [ 156 ] + xx [ 113 ] * state [ 39 ] ) ) ;
xx [ 151 ] = xx [ 28 ] - ( ( xx [ 116 ] * state [ 39 ] + xx [ 157 ] ) * xx [
4 ] - xx [ 90 ] ) ; solveSymmetricPosDef ( xx + 64 , xx + 150 , 2 , 1 , xx +
89 , xx + 156 ) ; xx [ 113 ] = 0.3522037996671813 ; xx [ 116 ] = xx [ 6 ] *
state [ 1 ] ; xx [ 6 ] = ( xx [ 112 ] * state [ 3 ] + xx [ 116 ] ) * xx [ 4 ]
; xx [ 122 ] = xx [ 113 ] - ( xx [ 6 ] + xx [ 6 ] ) ; xx [ 150 ] = xx [ 1 ] ;
xx [ 151 ] = - xx [ 26 ] ; xx [ 152 ] = - xx [ 122 ] ; solveSymmetricPosDef (
xx + 11 , xx + 150 , 3 , 1 , xx + 156 , xx + 159 ) ; xx [ 134 ] = xx [ 90 ] *
state [ 42 ] ; xx [ 140 ] = xx [ 89 ] * state [ 42 ] ; xx [ 143 ] = xx [ 90 ]
* state [ 40 ] - xx [ 89 ] * state [ 41 ] ; xx [ 150 ] = - xx [ 134 ] ; xx [
151 ] = xx [ 140 ] ; xx [ 152 ] = xx [ 143 ] ; pm_math_cross3 ( xx + 124 , xx
+ 150 , xx + 159 ) ; xx [ 150 ] = xx [ 89 ] + ( xx [ 134 ] * state [ 39 ] +
xx [ 159 ] ) * xx [ 4 ] ; xx [ 151 ] = xx [ 90 ] + xx [ 4 ] * ( xx [ 160 ] -
xx [ 140 ] * state [ 39 ] ) ; xx [ 152 ] = xx [ 4 ] * ( xx [ 161 ] - xx [ 143
] * state [ 39 ] ) ; xx [ 134 ] = xx [ 153 ] - pm_math_dot3 ( xx + 137 , xx +
150 ) ; xx [ 140 ] = xx [ 154 ] - pm_math_dot3 ( xx + 147 , xx + 150 ) ; xx [
143 ] = xx [ 155 ] - pm_math_dot3 ( xx + 82 , xx + 150 ) ; xx [ 150 ] = xx [
89 ] - ( xx [ 135 ] * xx [ 158 ] - xx [ 136 ] * xx [ 157 ] ) + xx [ 111 ] *
xx [ 134 ] + xx [ 121 ] * xx [ 140 ] + xx [ 73 ] * xx [ 143 ] ; xx [ 79 ] =
xx [ 109 ] * state [ 39 ] ; xx [ 80 ] = ( xx [ 79 ] + xx [ 77 ] * state [ 41
] ) * xx [ 4 ] ; xx [ 89 ] = ( xx [ 22 ] * xx [ 39 ] + xx [ 81 ] ) * xx [ 4 ]
- xx [ 72 ] - xx [ 80 ] ; xx [ 81 ] = xx [ 114 ] * state [ 39 ] ; xx [ 117 ]
= xx [ 4 ] * ( xx [ 77 ] * state [ 40 ] - xx [ 81 ] ) ; xx [ 77 ] = xx [ 4 ]
* ( xx [ 119 ] + xx [ 71 ] * state [ 39 ] ) - xx [ 74 ] + xx [ 117 ] ; xx [
71 ] = xx [ 4 ] * ( xx [ 129 ] - xx [ 123 ] * state [ 39 ] ) ; xx [ 127 ] =
xx [ 89 ] ; xx [ 128 ] = xx [ 77 ] ; xx [ 129 ] = xx [ 71 ] ;
solveSymmetricPosDef ( xx + 54 , xx + 127 , 3 , 1 , xx + 151 , xx + 154 ) ;
xx [ 118 ] = xx [ 52 ] * xx [ 152 ] ; xx [ 119 ] = xx [ 52 ] * xx [ 151 ] ;
xx [ 123 ] = xx [ 119 ] * state [ 42 ] ; xx [ 127 ] = xx [ 118 ] * state [ 42
] ; xx [ 154 ] = xx [ 123 ] ; xx [ 155 ] = xx [ 127 ] ; xx [ 156 ] = - ( xx [
119 ] * state [ 40 ] + xx [ 118 ] * state [ 41 ] ) ; pm_math_cross3 ( xx +
124 , xx + 154 , xx + 159 ) ; xx [ 128 ] = - ( xx [ 118 ] + xx [ 4 ] * ( xx [
159 ] + xx [ 123 ] * state [ 39 ] ) ) ; xx [ 129 ] = - ( ( xx [ 127 ] * state
[ 39 ] + xx [ 160 ] ) * xx [ 4 ] - xx [ 119 ] ) ; solveSymmetricPosDef ( xx +
64 , xx + 128 , 2 , 1 , xx + 118 , xx + 154 ) ; xx [ 123 ] = ( xx [ 116 ] +
xx [ 21 ] * state [ 2 ] ) * xx [ 4 ] ; xx [ 21 ] = xx [ 123 ] + xx [ 123 ] -
xx [ 113 ] ; xx [ 113 ] = ( xx [ 20 ] + xx [ 112 ] * state [ 2 ] ) * xx [ 4 ]
; xx [ 20 ] = xx [ 113 ] + xx [ 113 ] ; xx [ 127 ] = xx [ 1 ] ; xx [ 128 ] =
- xx [ 21 ] ; xx [ 129 ] = - xx [ 20 ] ; solveSymmetricPosDef ( xx + 11 , xx
+ 127 , 3 , 1 , xx + 154 , xx + 159 ) ; xx [ 112 ] = xx [ 119 ] * state [ 42
] ; xx [ 113 ] = xx [ 118 ] * state [ 42 ] ; xx [ 116 ] = xx [ 119 ] * state
[ 40 ] - xx [ 118 ] * state [ 41 ] ; xx [ 127 ] = - xx [ 112 ] ; xx [ 128 ] =
xx [ 113 ] ; xx [ 129 ] = xx [ 116 ] ; pm_math_cross3 ( xx + 124 , xx + 127 ,
xx + 159 ) ; xx [ 127 ] = xx [ 118 ] + ( xx [ 112 ] * state [ 39 ] + xx [ 159
] ) * xx [ 4 ] ; xx [ 128 ] = xx [ 119 ] + xx [ 4 ] * ( xx [ 160 ] - xx [ 113
] * state [ 39 ] ) ; xx [ 129 ] = xx [ 4 ] * ( xx [ 161 ] - xx [ 116 ] *
state [ 39 ] ) ; xx [ 112 ] = xx [ 151 ] - pm_math_dot3 ( xx + 137 , xx + 127
) ; xx [ 113 ] = xx [ 152 ] - pm_math_dot3 ( xx + 147 , xx + 127 ) ; xx [ 116
] = xx [ 153 ] - pm_math_dot3 ( xx + 82 , xx + 127 ) ; xx [ 127 ] = xx [ 118
] - ( xx [ 135 ] * xx [ 156 ] - xx [ 136 ] * xx [ 155 ] ) + xx [ 111 ] * xx [
112 ] + xx [ 121 ] * xx [ 113 ] + xx [ 73 ] * xx [ 116 ] ; xx [ 118 ] =
0.04750999999999999 ; xx [ 128 ] = xx [ 118 ] * state [ 41 ] ; xx [ 129 ] =
8.530000000000001e-3 ; xx [ 151 ] = xx [ 129 ] * state [ 42 ] ; xx [ 152 ] =
xx [ 128 ] - xx [ 151 ] ; xx [ 153 ] = xx [ 118 ] * state [ 40 ] ; xx [ 159 ]
= xx [ 152 ] ; xx [ 160 ] = - xx [ 153 ] ; xx [ 161 ] = xx [ 129 ] * state [
40 ] ; pm_math_cross3 ( xx + 68 , xx + 159 , xx + 162 ) ; xx [ 154 ] = xx [ 4
] * ( xx [ 162 ] - xx [ 152 ] * state [ 39 ] ) + xx [ 110 ] ; xx [ 152 ] =
0.07589 ; xx [ 159 ] = xx [ 152 ] * state [ 40 ] ; xx [ 160 ] = xx [ 159 ] +
xx [ 151 ] ; xx [ 151 ] = xx [ 129 ] * state [ 41 ] ; xx [ 165 ] = xx [ 152 ]
* state [ 41 ] ; xx [ 166 ] = - xx [ 160 ] ; xx [ 167 ] = xx [ 151 ] ;
pm_math_cross3 ( xx + 68 , xx + 165 , xx + 168 ) ; xx [ 161 ] = xx [ 129 ] +
( xx [ 168 ] - xx [ 152 ] * xx [ 34 ] ) * xx [ 4 ] + xx [ 120 ] ; xx [ 165 ]
= xx [ 152 ] * state [ 42 ] ; xx [ 166 ] = xx [ 128 ] - xx [ 159 ] ; xx [ 171
] = xx [ 165 ] ; xx [ 172 ] = - ( xx [ 118 ] * state [ 42 ] ) ; xx [ 173 ] =
xx [ 166 ] ; pm_math_cross3 ( xx + 68 , xx + 171 , xx + 174 ) ; xx [ 128 ] =
xx [ 118 ] + xx [ 4 ] * ( xx [ 174 ] - xx [ 165 ] * state [ 39 ] ) ; xx [ 171
] = xx [ 154 ] ; xx [ 172 ] = xx [ 161 ] ; xx [ 173 ] = xx [ 128 ] ;
solveSymmetricPosDef ( xx + 54 , xx + 171 , 3 , 1 , xx + 177 , xx + 180 ) ;
xx [ 159 ] = xx [ 52 ] * xx [ 178 ] ; xx [ 165 ] = xx [ 52 ] * xx [ 177 ] ;
xx [ 167 ] = xx [ 165 ] * state [ 42 ] ; xx [ 171 ] = xx [ 159 ] * state [ 42
] ; xx [ 180 ] = xx [ 167 ] ; xx [ 181 ] = xx [ 171 ] ; xx [ 182 ] = - ( xx [
165 ] * state [ 40 ] + xx [ 159 ] * state [ 41 ] ) ; pm_math_cross3 ( xx +
124 , xx + 180 , xx + 183 ) ; xx [ 172 ] = xx [ 28 ] - ( xx [ 159 ] + xx [ 4
] * ( xx [ 183 ] + xx [ 167 ] * state [ 39 ] ) ) ; xx [ 173 ] = - ( ( xx [
171 ] * state [ 39 ] + xx [ 184 ] ) * xx [ 4 ] - xx [ 165 ] ) ;
solveSymmetricPosDef ( xx + 64 , xx + 172 , 2 , 1 , xx + 180 , xx + 182 ) ;
xx [ 159 ] = xx [ 181 ] * state [ 42 ] ; xx [ 165 ] = xx [ 180 ] * state [ 42
] ; xx [ 167 ] = xx [ 181 ] * state [ 40 ] - xx [ 180 ] * state [ 41 ] ; xx [
171 ] = - xx [ 159 ] ; xx [ 172 ] = xx [ 165 ] ; xx [ 173 ] = xx [ 167 ] ;
pm_math_cross3 ( xx + 124 , xx + 171 , xx + 182 ) ; xx [ 171 ] = xx [ 180 ] +
( xx [ 159 ] * state [ 39 ] + xx [ 182 ] ) * xx [ 4 ] ; xx [ 172 ] = xx [ 181
] + xx [ 4 ] * ( xx [ 183 ] - xx [ 165 ] * state [ 39 ] ) ; xx [ 173 ] = xx [
4 ] * ( xx [ 184 ] - xx [ 167 ] * state [ 39 ] ) ; xx [ 159 ] = xx [ 177 ] -
pm_math_dot3 ( xx + 137 , xx + 171 ) ; xx [ 165 ] = xx [ 178 ] - pm_math_dot3
( xx + 147 , xx + 171 ) ; xx [ 167 ] = xx [ 179 ] - pm_math_dot3 ( xx + 82 ,
xx + 171 ) ; xx [ 171 ] = xx [ 180 ] + xx [ 111 ] * xx [ 159 ] + xx [ 121 ] *
xx [ 165 ] + xx [ 73 ] * xx [ 167 ] ; xx [ 172 ] = xx [ 4 ] * ( xx [ 163 ] +
xx [ 153 ] * state [ 39 ] ) - xx [ 129 ] + xx [ 86 ] ; xx [ 153 ] = xx [ 4 ]
* ( xx [ 169 ] + xx [ 160 ] * state [ 39 ] ) + xx [ 75 ] ; xx [ 160 ] = xx [
152 ] + ( xx [ 118 ] * xx [ 31 ] + xx [ 175 ] ) * xx [ 4 ] ; xx [ 177 ] = xx
[ 172 ] ; xx [ 178 ] = xx [ 153 ] ; xx [ 179 ] = xx [ 160 ] ;
solveSymmetricPosDef ( xx + 54 , xx + 177 , 3 , 1 , xx + 182 , xx + 185 ) ;
xx [ 173 ] = xx [ 52 ] * xx [ 183 ] ; xx [ 177 ] = xx [ 52 ] * xx [ 182 ] ;
xx [ 178 ] = xx [ 177 ] * state [ 42 ] ; xx [ 179 ] = xx [ 173 ] * state [ 42
] ; xx [ 185 ] = xx [ 178 ] ; xx [ 186 ] = xx [ 179 ] ; xx [ 187 ] = - ( xx [
177 ] * state [ 40 ] + xx [ 173 ] * state [ 41 ] ) ; pm_math_cross3 ( xx +
124 , xx + 185 , xx + 188 ) ; xx [ 185 ] = - ( xx [ 173 ] + xx [ 4 ] * ( xx [
188 ] + xx [ 178 ] * state [ 39 ] ) ) ; xx [ 186 ] = xx [ 28 ] - ( ( xx [ 179
] * state [ 39 ] + xx [ 189 ] ) * xx [ 4 ] - xx [ 177 ] ) ;
solveSymmetricPosDef ( xx + 64 , xx + 185 , 2 , 1 , xx + 177 , xx + 187 ) ;
xx [ 173 ] = xx [ 178 ] * state [ 42 ] ; xx [ 179 ] = xx [ 177 ] * state [ 42
] ; xx [ 185 ] = xx [ 178 ] * state [ 40 ] - xx [ 177 ] * state [ 41 ] ; xx [
186 ] = - xx [ 173 ] ; xx [ 187 ] = xx [ 179 ] ; xx [ 188 ] = xx [ 185 ] ;
pm_math_cross3 ( xx + 124 , xx + 186 , xx + 189 ) ; xx [ 186 ] = xx [ 177 ] +
( xx [ 173 ] * state [ 39 ] + xx [ 189 ] ) * xx [ 4 ] ; xx [ 187 ] = xx [ 178
] + xx [ 4 ] * ( xx [ 190 ] - xx [ 179 ] * state [ 39 ] ) ; xx [ 188 ] = xx [
4 ] * ( xx [ 191 ] - xx [ 185 ] * state [ 39 ] ) ; xx [ 173 ] = xx [ 182 ] -
pm_math_dot3 ( xx + 137 , xx + 186 ) ; xx [ 179 ] = xx [ 183 ] - pm_math_dot3
( xx + 147 , xx + 186 ) ; xx [ 182 ] = xx [ 184 ] - pm_math_dot3 ( xx + 82 ,
xx + 186 ) ; xx [ 183 ] = xx [ 177 ] + xx [ 111 ] * xx [ 173 ] + xx [ 121 ] *
xx [ 179 ] + xx [ 73 ] * xx [ 182 ] ; xx [ 162 ] = ( xx [ 164 ] - xx [ 129 ]
* xx [ 39 ] ) * xx [ 4 ] - xx [ 118 ] - xx [ 80 ] ; xx [ 163 ] = xx [ 4 ] * (
xx [ 170 ] - xx [ 151 ] * state [ 39 ] ) - xx [ 152 ] + xx [ 117 ] ; xx [ 151
] = xx [ 4 ] * ( xx [ 176 ] - xx [ 166 ] * state [ 39 ] ) ; xx [ 168 ] = xx [
162 ] ; xx [ 169 ] = xx [ 163 ] ; xx [ 170 ] = xx [ 151 ] ;
solveSymmetricPosDef ( xx + 54 , xx + 168 , 3 , 1 , xx + 174 , xx + 184 ) ;
xx [ 164 ] = xx [ 52 ] * xx [ 175 ] ; xx [ 166 ] = xx [ 52 ] * xx [ 174 ] ;
xx [ 168 ] = xx [ 166 ] * state [ 42 ] ; xx [ 169 ] = xx [ 164 ] * state [ 42
] ; xx [ 184 ] = xx [ 168 ] ; xx [ 185 ] = xx [ 169 ] ; xx [ 186 ] = - ( xx [
166 ] * state [ 40 ] + xx [ 164 ] * state [ 41 ] ) ; pm_math_cross3 ( xx +
124 , xx + 184 , xx + 187 ) ; xx [ 184 ] = - ( xx [ 164 ] + xx [ 4 ] * ( xx [
187 ] + xx [ 168 ] * state [ 39 ] ) ) ; xx [ 185 ] = - ( ( xx [ 169 ] * state
[ 39 ] + xx [ 188 ] ) * xx [ 4 ] - xx [ 166 ] ) ; solveSymmetricPosDef ( xx +
64 , xx + 184 , 2 , 1 , xx + 168 , xx + 186 ) ; xx [ 164 ] = xx [ 169 ] *
state [ 42 ] ; xx [ 166 ] = xx [ 168 ] * state [ 42 ] ; xx [ 170 ] = xx [ 169
] * state [ 40 ] - xx [ 168 ] * state [ 41 ] ; xx [ 184 ] = - xx [ 164 ] ; xx
[ 185 ] = xx [ 166 ] ; xx [ 186 ] = xx [ 170 ] ; pm_math_cross3 ( xx + 124 ,
xx + 184 , xx + 187 ) ; xx [ 184 ] = xx [ 168 ] + ( xx [ 164 ] * state [ 39 ]
+ xx [ 187 ] ) * xx [ 4 ] ; xx [ 185 ] = xx [ 169 ] + xx [ 4 ] * ( xx [ 188 ]
- xx [ 166 ] * state [ 39 ] ) ; xx [ 186 ] = xx [ 4 ] * ( xx [ 189 ] - xx [
170 ] * state [ 39 ] ) ; xx [ 164 ] = xx [ 174 ] - pm_math_dot3 ( xx + 137 ,
xx + 184 ) ; xx [ 166 ] = xx [ 175 ] - pm_math_dot3 ( xx + 147 , xx + 184 ) ;
xx [ 170 ] = xx [ 176 ] - pm_math_dot3 ( xx + 82 , xx + 184 ) ; xx [ 174 ] =
xx [ 168 ] + xx [ 111 ] * xx [ 164 ] + xx [ 121 ] * xx [ 166 ] + xx [ 73 ] *
xx [ 170 ] ; xx [ 175 ] = 0.05489999999999998 ; xx [ 176 ] = xx [ 175 ] *
state [ 41 ] ; xx [ 184 ] = 0.09134 ; xx [ 185 ] = xx [ 184 ] * state [ 42 ]
; xx [ 186 ] = xx [ 176 ] - xx [ 185 ] ; xx [ 187 ] = xx [ 175 ] * state [ 40
] ; xx [ 188 ] = xx [ 186 ] ; xx [ 189 ] = - xx [ 187 ] ; xx [ 190 ] = xx [
184 ] * state [ 40 ] ; pm_math_cross3 ( xx + 68 , xx + 188 , xx + 191 ) ; xx
[ 188 ] = xx [ 4 ] * ( xx [ 191 ] - xx [ 186 ] * state [ 39 ] ) + xx [ 110 ]
; xx [ 110 ] = 0.01565 ; xx [ 186 ] = xx [ 110 ] * state [ 40 ] ; xx [ 189 ]
= xx [ 186 ] - xx [ 185 ] ; xx [ 185 ] = xx [ 184 ] * state [ 41 ] ; xx [ 194
] = - ( xx [ 110 ] * state [ 41 ] ) ; xx [ 195 ] = xx [ 189 ] ; xx [ 196 ] =
xx [ 185 ] ; pm_math_cross3 ( xx + 68 , xx + 194 , xx + 197 ) ; xx [ 190 ] =
xx [ 184 ] + ( xx [ 110 ] * xx [ 34 ] + xx [ 197 ] ) * xx [ 4 ] + xx [ 120 ]
; xx [ 34 ] = xx [ 110 ] * state [ 42 ] ; xx [ 120 ] = xx [ 176 ] + xx [ 186
] ; xx [ 194 ] = - xx [ 34 ] ; xx [ 195 ] = - ( xx [ 175 ] * state [ 42 ] ) ;
xx [ 196 ] = xx [ 120 ] ; pm_math_cross3 ( xx + 68 , xx + 194 , xx + 200 ) ;
xx [ 68 ] = xx [ 175 ] + xx [ 4 ] * ( xx [ 200 ] + xx [ 34 ] * state [ 39 ] )
; xx [ 194 ] = xx [ 188 ] ; xx [ 195 ] = xx [ 190 ] ; xx [ 196 ] = xx [ 68 ]
; solveSymmetricPosDef ( xx + 54 , xx + 194 , 3 , 1 , xx + 203 , xx + 206 ) ;
xx [ 34 ] = xx [ 52 ] * xx [ 204 ] ; xx [ 69 ] = xx [ 52 ] * xx [ 203 ] ; xx
[ 70 ] = xx [ 69 ] * state [ 42 ] ; xx [ 176 ] = xx [ 34 ] * state [ 42 ] ;
xx [ 194 ] = xx [ 70 ] ; xx [ 195 ] = xx [ 176 ] ; xx [ 196 ] = - ( xx [ 69 ]
* state [ 40 ] + xx [ 34 ] * state [ 41 ] ) ; pm_math_cross3 ( xx + 124 , xx
+ 194 , xx + 206 ) ; xx [ 194 ] = xx [ 28 ] - ( xx [ 34 ] + xx [ 4 ] * ( xx [
206 ] + xx [ 70 ] * state [ 39 ] ) ) ; xx [ 195 ] = - ( ( xx [ 176 ] * state
[ 39 ] + xx [ 207 ] ) * xx [ 4 ] - xx [ 69 ] ) ; solveSymmetricPosDef ( xx +
64 , xx + 194 , 2 , 1 , xx + 69 , xx + 206 ) ; xx [ 34 ] = xx [ 70 ] * state
[ 42 ] ; xx [ 176 ] = xx [ 69 ] * state [ 42 ] ; xx [ 186 ] = xx [ 70 ] *
state [ 40 ] - xx [ 69 ] * state [ 41 ] ; xx [ 194 ] = - xx [ 34 ] ; xx [ 195
] = xx [ 176 ] ; xx [ 196 ] = xx [ 186 ] ; pm_math_cross3 ( xx + 124 , xx +
194 , xx + 206 ) ; xx [ 194 ] = xx [ 69 ] + ( xx [ 34 ] * state [ 39 ] + xx [
206 ] ) * xx [ 4 ] ; xx [ 195 ] = xx [ 70 ] + xx [ 4 ] * ( xx [ 207 ] - xx [
176 ] * state [ 39 ] ) ; xx [ 196 ] = xx [ 4 ] * ( xx [ 208 ] - xx [ 186 ] *
state [ 39 ] ) ; xx [ 34 ] = xx [ 203 ] - pm_math_dot3 ( xx + 137 , xx + 194
) ; xx [ 176 ] = xx [ 204 ] - pm_math_dot3 ( xx + 147 , xx + 194 ) ; xx [ 186
] = xx [ 205 ] - pm_math_dot3 ( xx + 82 , xx + 194 ) ; xx [ 194 ] = xx [ 69 ]
+ xx [ 111 ] * xx [ 34 ] + xx [ 121 ] * xx [ 176 ] + xx [ 73 ] * xx [ 186 ] ;
xx [ 195 ] = xx [ 4 ] * ( xx [ 192 ] + xx [ 187 ] * state [ 39 ] ) - xx [ 184
] + xx [ 86 ] ; xx [ 86 ] = xx [ 4 ] * ( xx [ 198 ] - xx [ 189 ] * state [ 39
] ) + xx [ 75 ] ; xx [ 75 ] = ( xx [ 175 ] * xx [ 31 ] + xx [ 201 ] ) * xx [
4 ] - xx [ 110 ] ; xx [ 203 ] = xx [ 195 ] ; xx [ 204 ] = xx [ 86 ] ; xx [
205 ] = xx [ 75 ] ; solveSymmetricPosDef ( xx + 54 , xx + 203 , 3 , 1 , xx +
206 , xx + 209 ) ; xx [ 31 ] = xx [ 52 ] * xx [ 207 ] ; xx [ 187 ] = xx [ 52
] * xx [ 206 ] ; xx [ 189 ] = xx [ 187 ] * state [ 42 ] ; xx [ 196 ] = xx [
31 ] * state [ 42 ] ; xx [ 203 ] = xx [ 189 ] ; xx [ 204 ] = xx [ 196 ] ; xx
[ 205 ] = - ( xx [ 187 ] * state [ 40 ] + xx [ 31 ] * state [ 41 ] ) ;
pm_math_cross3 ( xx + 124 , xx + 203 , xx + 209 ) ; xx [ 203 ] = - ( xx [ 31
] + xx [ 4 ] * ( xx [ 209 ] + xx [ 189 ] * state [ 39 ] ) ) ; xx [ 204 ] = xx
[ 28 ] - ( ( xx [ 196 ] * state [ 39 ] + xx [ 210 ] ) * xx [ 4 ] - xx [ 187 ]
) ; solveSymmetricPosDef ( xx + 64 , xx + 203 , 2 , 1 , xx + 209 , xx + 211 )
; xx [ 31 ] = xx [ 210 ] * state [ 42 ] ; xx [ 187 ] = xx [ 209 ] * state [
42 ] ; xx [ 189 ] = xx [ 210 ] * state [ 40 ] - xx [ 209 ] * state [ 41 ] ;
xx [ 203 ] = - xx [ 31 ] ; xx [ 204 ] = xx [ 187 ] ; xx [ 205 ] = xx [ 189 ]
; pm_math_cross3 ( xx + 124 , xx + 203 , xx + 211 ) ; xx [ 203 ] = xx [ 209 ]
+ ( xx [ 31 ] * state [ 39 ] + xx [ 211 ] ) * xx [ 4 ] ; xx [ 204 ] = xx [
210 ] + xx [ 4 ] * ( xx [ 212 ] - xx [ 187 ] * state [ 39 ] ) ; xx [ 205 ] =
xx [ 4 ] * ( xx [ 213 ] - xx [ 189 ] * state [ 39 ] ) ; xx [ 31 ] = xx [ 206
] - pm_math_dot3 ( xx + 137 , xx + 203 ) ; xx [ 187 ] = xx [ 207 ] -
pm_math_dot3 ( xx + 147 , xx + 203 ) ; xx [ 189 ] = xx [ 208 ] - pm_math_dot3
( xx + 82 , xx + 203 ) ; xx [ 196 ] = xx [ 209 ] + xx [ 111 ] * xx [ 31 ] +
xx [ 121 ] * xx [ 187 ] + xx [ 73 ] * xx [ 189 ] ; xx [ 191 ] = ( xx [ 193 ]
- xx [ 184 ] * xx [ 39 ] ) * xx [ 4 ] - xx [ 175 ] - xx [ 80 ] ; xx [ 39 ] =
xx [ 110 ] + xx [ 4 ] * ( xx [ 199 ] - xx [ 185 ] * state [ 39 ] ) + xx [ 117
] ; xx [ 80 ] = xx [ 4 ] * ( xx [ 202 ] - xx [ 120 ] * state [ 39 ] ) ; xx [
197 ] = xx [ 191 ] ; xx [ 198 ] = xx [ 39 ] ; xx [ 199 ] = xx [ 80 ] ;
solveSymmetricPosDef ( xx + 54 , xx + 197 , 3 , 1 , xx + 200 , xx + 203 ) ;
xx [ 117 ] = xx [ 52 ] * xx [ 201 ] ; xx [ 120 ] = xx [ 52 ] * xx [ 200 ] ;
xx [ 185 ] = xx [ 120 ] * state [ 42 ] ; xx [ 192 ] = xx [ 117 ] * state [ 42
] ; xx [ 197 ] = xx [ 185 ] ; xx [ 198 ] = xx [ 192 ] ; xx [ 199 ] = - ( xx [
120 ] * state [ 40 ] + xx [ 117 ] * state [ 41 ] ) ; pm_math_cross3 ( xx +
124 , xx + 197 , xx + 203 ) ; xx [ 197 ] = - ( xx [ 117 ] + xx [ 4 ] * ( xx [
203 ] + xx [ 185 ] * state [ 39 ] ) ) ; xx [ 198 ] = - ( ( xx [ 192 ] * state
[ 39 ] + xx [ 204 ] ) * xx [ 4 ] - xx [ 120 ] ) ; solveSymmetricPosDef ( xx +
64 , xx + 197 , 2 , 1 , xx + 192 , xx + 203 ) ; xx [ 117 ] = xx [ 193 ] *
state [ 42 ] ; xx [ 120 ] = xx [ 192 ] * state [ 42 ] ; xx [ 185 ] = xx [ 193
] * state [ 40 ] - xx [ 192 ] * state [ 41 ] ; xx [ 197 ] = - xx [ 117 ] ; xx
[ 198 ] = xx [ 120 ] ; xx [ 199 ] = xx [ 185 ] ; pm_math_cross3 ( xx + 124 ,
xx + 197 , xx + 203 ) ; xx [ 124 ] = xx [ 192 ] + ( xx [ 117 ] * state [ 39 ]
+ xx [ 203 ] ) * xx [ 4 ] ; xx [ 125 ] = xx [ 193 ] + xx [ 4 ] * ( xx [ 204 ]
- xx [ 120 ] * state [ 39 ] ) ; xx [ 126 ] = xx [ 4 ] * ( xx [ 205 ] - xx [
185 ] * state [ 39 ] ) ; xx [ 117 ] = xx [ 200 ] - pm_math_dot3 ( xx + 137 ,
xx + 124 ) ; xx [ 120 ] = xx [ 201 ] - pm_math_dot3 ( xx + 147 , xx + 124 ) ;
xx [ 185 ] = xx [ 202 ] - pm_math_dot3 ( xx + 82 , xx + 124 ) ; xx [ 124 ] =
xx [ 192 ] + xx [ 111 ] * xx [ 117 ] + xx [ 121 ] * xx [ 120 ] + xx [ 73 ] *
xx [ 185 ] ; xx [ 197 ] = xx [ 1 ] ; xx [ 198 ] = - xx [ 136 ] ; xx [ 199 ] =
xx [ 135 ] ; solveSymmetricPosDef ( xx + 11 , xx + 197 , 3 , 1 , xx + 200 ,
xx + 203 ) ; xx [ 125 ] = xx [ 135 ] * xx [ 202 ] - xx [ 136 ] * xx [ 201 ] ;
xx [ 126 ] = - xx [ 125 ] ; xx [ 197 ] = xx [ 5 ] - xx [ 6 ] ; xx [ 6 ] = xx
[ 197 ] + xx [ 197 ] ; xx [ 197 ] = xx [ 1 ] ; xx [ 198 ] = xx [ 26 ] ; xx [
199 ] = xx [ 6 ] ; solveSymmetricPosDef ( xx + 11 , xx + 197 , 3 , 1 , xx +
203 , xx + 206 ) ; xx [ 197 ] = xx [ 135 ] * xx [ 205 ] - xx [ 136 ] * xx [
204 ] ; xx [ 198 ] = - xx [ 197 ] ; xx [ 199 ] = xx [ 123 ] - xx [ 5 ] ; xx [
123 ] = xx [ 199 ] + xx [ 199 ] ; xx [ 206 ] = xx [ 1 ] ; xx [ 207 ] = xx [
123 ] ; xx [ 208 ] = xx [ 20 ] ; solveSymmetricPosDef ( xx + 11 , xx + 206 ,
3 , 1 , xx + 211 , xx + 214 ) ; xx [ 199 ] = xx [ 135 ] * xx [ 213 ] - xx [
136 ] * xx [ 212 ] ; xx [ 200 ] = - xx [ 199 ] ; xx [ 203 ] = xx [ 119 ] - (
xx [ 26 ] * xx [ 155 ] + xx [ 156 ] * xx [ 122 ] ) + xx [ 87 ] * xx [ 112 ] +
xx [ 78 ] * xx [ 113 ] + xx [ 88 ] * xx [ 116 ] ; xx [ 119 ] = xx [ 181 ] +
xx [ 87 ] * xx [ 159 ] + xx [ 78 ] * xx [ 165 ] + xx [ 88 ] * xx [ 167 ] ; xx
[ 181 ] = xx [ 178 ] + xx [ 87 ] * xx [ 173 ] + xx [ 78 ] * xx [ 179 ] + xx [
88 ] * xx [ 182 ] ; xx [ 206 ] = xx [ 169 ] + xx [ 87 ] * xx [ 164 ] + xx [
78 ] * xx [ 166 ] + xx [ 88 ] * xx [ 170 ] ; xx [ 207 ] = xx [ 70 ] + xx [ 87
] * xx [ 34 ] + xx [ 78 ] * xx [ 176 ] + xx [ 88 ] * xx [ 186 ] ; xx [ 208 ]
= xx [ 210 ] + xx [ 87 ] * xx [ 31 ] + xx [ 78 ] * xx [ 187 ] + xx [ 88 ] *
xx [ 189 ] ; xx [ 211 ] = xx [ 193 ] + xx [ 87 ] * xx [ 117 ] + xx [ 78 ] *
xx [ 120 ] + xx [ 88 ] * xx [ 185 ] ; xx [ 214 ] = - ( xx [ 26 ] * xx [ 201 ]
+ xx [ 202 ] * xx [ 122 ] ) ; xx [ 215 ] = xx [ 26 ] * xx [ 204 ] ; xx [ 216
] = - ( xx [ 215 ] + xx [ 205 ] * xx [ 122 ] ) ; xx [ 217 ] = xx [ 26 ] * xx
[ 212 ] ; xx [ 218 ] = - ( xx [ 217 ] + xx [ 213 ] * xx [ 122 ] ) ; xx [ 219
] = xx [ 89 ] * xx [ 159 ] + xx [ 77 ] * xx [ 165 ] + xx [ 71 ] * xx [ 167 ]
; xx [ 220 ] = xx [ 89 ] * xx [ 173 ] + xx [ 77 ] * xx [ 179 ] + xx [ 71 ] *
xx [ 182 ] ; xx [ 221 ] = xx [ 89 ] * xx [ 164 ] + xx [ 77 ] * xx [ 166 ] +
xx [ 71 ] * xx [ 170 ] ; xx [ 222 ] = xx [ 89 ] * xx [ 34 ] + xx [ 77 ] * xx
[ 176 ] + xx [ 71 ] * xx [ 186 ] ; xx [ 223 ] = xx [ 89 ] * xx [ 31 ] + xx [
77 ] * xx [ 187 ] + xx [ 71 ] * xx [ 189 ] ; xx [ 224 ] = xx [ 89 ] * xx [
117 ] + xx [ 77 ] * xx [ 120 ] + xx [ 71 ] * xx [ 185 ] ; xx [ 225 ] = - ( xx
[ 201 ] * xx [ 21 ] + xx [ 20 ] * xx [ 202 ] ) ; xx [ 201 ] = - ( xx [ 204 ]
* xx [ 21 ] + xx [ 20 ] * xx [ 205 ] ) ; xx [ 202 ] = xx [ 20 ] * xx [ 213 ]
; xx [ 204 ] = - ( xx [ 212 ] * xx [ 21 ] + xx [ 202 ] ) ; xx [ 226 ] =
0.1624769242846504 ; xx [ 227 ] = xx [ 226 ] * state [ 15 ] ; xx [ 228 ] = xx
[ 226 ] * state [ 17 ] ; xx [ 229 ] = xx [ 4 ] * ( xx [ 227 ] * state [ 16 ]
- xx [ 228 ] * state [ 14 ] ) ; xx [ 230 ] = xx [ 229 ] + xx [ 229 ] ; xx [
229 ] = 5.415897476154963e-7 ; xx [ 231 ] = 1.144054222940626e-3 ; xx [ 232 ]
= xx [ 229 ] ; xx [ 233 ] = xx [ 1 ] ; xx [ 234 ] = xx [ 1 ] ; xx [ 235 ] =
xx [ 1 ] ; xx [ 236 ] = xx [ 231 ] ; xx [ 237 ] = xx [ 1 ] ; xx [ 238 ] = xx
[ 1 ] ; xx [ 239 ] = xx [ 1 ] ; xx [ 240 ] = xx [ 231 ] ; ii [ 0 ] =
factorSymmetricPosDef ( xx + 232 , 3 , xx + 241 ) ; if ( ii [ 0 ] != 0 ) {
return sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:DegenerateMass" ,
 "'Kinematics_Model/Trackrod  Inner Joint' has a degenerate mass distribution on its follower side."
, neDiagMgr ) ; } xx [ 231 ] = xx [ 226 ] * state [ 16 ] ; xx [ 241 ] = ( xx
[ 231 ] * state [ 14 ] + xx [ 227 ] * state [ 17 ] ) * xx [ 4 ] ; xx [ 242 ]
= xx [ 241 ] + xx [ 241 ] ; xx [ 243 ] = xx [ 1 ] ; xx [ 244 ] = xx [ 242 ] ;
xx [ 245 ] = - xx [ 230 ] ; solveSymmetricPosDef ( xx + 232 , xx + 243 , 3 ,
1 , xx + 246 , xx + 249 ) ; xx [ 241 ] = xx [ 227 ] * state [ 14 ] ; xx [ 243
] = xx [ 4 ] * ( xx [ 241 ] - xx [ 231 ] * state [ 17 ] ) ; xx [ 244 ] = xx [
243 ] + xx [ 243 ] ; xx [ 243 ] = 0.3249538485693007 ; xx [ 245 ] = xx [ 227
] * state [ 15 ] ; xx [ 227 ] = ( xx [ 228 ] * state [ 17 ] + xx [ 245 ] ) *
xx [ 4 ] ; xx [ 246 ] = xx [ 243 ] - ( xx [ 227 ] + xx [ 227 ] ) ; xx [ 249 ]
= xx [ 1 ] ; xx [ 250 ] = - xx [ 244 ] ; xx [ 251 ] = - xx [ 246 ] ;
solveSymmetricPosDef ( xx + 232 , xx + 249 , 3 , 1 , xx + 252 , xx + 255 ) ;
xx [ 227 ] = xx [ 177 ] - ( xx [ 230 ] * xx [ 254 ] - xx [ 242 ] * xx [ 253 ]
) + xx [ 154 ] * xx [ 173 ] + xx [ 161 ] * xx [ 179 ] + xx [ 128 ] * xx [ 182
] ; xx [ 177 ] = ( xx [ 245 ] + xx [ 231 ] * state [ 16 ] ) * xx [ 4 ] ; xx [
231 ] = xx [ 177 ] + xx [ 177 ] - xx [ 243 ] ; xx [ 177 ] = ( xx [ 241 ] + xx
[ 228 ] * state [ 16 ] ) * xx [ 4 ] ; xx [ 228 ] = xx [ 177 ] + xx [ 177 ] ;
xx [ 249 ] = xx [ 1 ] ; xx [ 250 ] = - xx [ 231 ] ; xx [ 251 ] = - xx [ 228 ]
; solveSymmetricPosDef ( xx + 232 , xx + 249 , 3 , 1 , xx + 255 , xx + 258 )
; xx [ 177 ] = xx [ 168 ] - ( xx [ 230 ] * xx [ 257 ] - xx [ 242 ] * xx [ 256
] ) + xx [ 154 ] * xx [ 164 ] + xx [ 161 ] * xx [ 166 ] + xx [ 128 ] * xx [
170 ] ; xx [ 168 ] = xx [ 69 ] + xx [ 154 ] * xx [ 34 ] + xx [ 161 ] * xx [
176 ] + xx [ 128 ] * xx [ 186 ] ; xx [ 241 ] = xx [ 209 ] + xx [ 154 ] * xx [
31 ] + xx [ 161 ] * xx [ 187 ] + xx [ 128 ] * xx [ 189 ] ; xx [ 243 ] = xx [
192 ] + xx [ 154 ] * xx [ 117 ] + xx [ 161 ] * xx [ 120 ] + xx [ 128 ] * xx [
185 ] ; xx [ 245 ] = xx [ 169 ] - ( xx [ 244 ] * xx [ 256 ] + xx [ 257 ] * xx
[ 246 ] ) + xx [ 172 ] * xx [ 164 ] + xx [ 153 ] * xx [ 166 ] + xx [ 160 ] *
xx [ 170 ] ; xx [ 169 ] = xx [ 70 ] + xx [ 172 ] * xx [ 34 ] + xx [ 153 ] *
xx [ 176 ] + xx [ 160 ] * xx [ 186 ] ; xx [ 70 ] = xx [ 210 ] + xx [ 172 ] *
xx [ 31 ] + xx [ 153 ] * xx [ 187 ] + xx [ 160 ] * xx [ 189 ] ; xx [ 249 ] =
xx [ 193 ] + xx [ 172 ] * xx [ 117 ] + xx [ 153 ] * xx [ 120 ] + xx [ 160 ] *
xx [ 185 ] ; xx [ 250 ] = xx [ 162 ] * xx [ 34 ] + xx [ 163 ] * xx [ 176 ] +
xx [ 151 ] * xx [ 186 ] ; xx [ 251 ] = xx [ 162 ] * xx [ 31 ] + xx [ 163 ] *
xx [ 187 ] + xx [ 151 ] * xx [ 189 ] ; xx [ 252 ] = xx [ 162 ] * xx [ 117 ] +
xx [ 163 ] * xx [ 120 ] + xx [ 151 ] * xx [ 185 ] ; xx [ 255 ] =
0.1774935228395673 ; xx [ 258 ] = xx [ 255 ] * state [ 22 ] ; xx [ 259 ] = xx
[ 255 ] * state [ 24 ] ; xx [ 260 ] = xx [ 4 ] * ( xx [ 258 ] * state [ 23 ]
- xx [ 259 ] * state [ 21 ] ) ; xx [ 261 ] = xx [ 260 ] + xx [ 260 ] ; xx [
260 ] = 5.916450761318695e-7 ; xx [ 262 ] = 1.491428405000033e-3 ; xx [ 263 ]
= xx [ 260 ] ; xx [ 264 ] = xx [ 1 ] ; xx [ 265 ] = xx [ 1 ] ; xx [ 266 ] =
xx [ 1 ] ; xx [ 267 ] = xx [ 262 ] ; xx [ 268 ] = xx [ 1 ] ; xx [ 269 ] = xx
[ 1 ] ; xx [ 270 ] = xx [ 1 ] ; xx [ 271 ] = xx [ 262 ] ; ii [ 0 ] =
factorSymmetricPosDef ( xx + 263 , 3 , xx + 272 ) ; if ( ii [ 0 ] != 0 ) {
return sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:DegenerateMass" ,
 "'Kinematics_Model/UWB Front Joint' has a degenerate mass distribution on its follower side."
, neDiagMgr ) ; } xx [ 262 ] = xx [ 255 ] * state [ 23 ] ; xx [ 272 ] = ( xx
[ 262 ] * state [ 21 ] + xx [ 258 ] * state [ 24 ] ) * xx [ 4 ] ; xx [ 273 ]
= xx [ 272 ] + xx [ 272 ] ; xx [ 274 ] = xx [ 1 ] ; xx [ 275 ] = xx [ 273 ] ;
xx [ 276 ] = - xx [ 261 ] ; solveSymmetricPosDef ( xx + 263 , xx + 274 , 3 ,
1 , xx + 277 , xx + 280 ) ; xx [ 272 ] = xx [ 258 ] * state [ 21 ] ; xx [ 274
] = xx [ 4 ] * ( xx [ 272 ] - xx [ 262 ] * state [ 24 ] ) ; xx [ 275 ] = xx [
274 ] + xx [ 274 ] ; xx [ 274 ] = 0.3549870456791346 ; xx [ 276 ] = xx [ 258
] * state [ 22 ] ; xx [ 258 ] = ( xx [ 259 ] * state [ 24 ] + xx [ 276 ] ) *
xx [ 4 ] ; xx [ 277 ] = xx [ 274 ] - ( xx [ 258 ] + xx [ 258 ] ) ; xx [ 280 ]
= xx [ 1 ] ; xx [ 281 ] = - xx [ 275 ] ; xx [ 282 ] = - xx [ 277 ] ;
solveSymmetricPosDef ( xx + 263 , xx + 280 , 3 , 1 , xx + 283 , xx + 286 ) ;
xx [ 280 ] = xx [ 209 ] - ( xx [ 261 ] * xx [ 285 ] - xx [ 273 ] * xx [ 284 ]
) + xx [ 188 ] * xx [ 31 ] + xx [ 190 ] * xx [ 187 ] + xx [ 68 ] * xx [ 189 ]
; xx [ 209 ] = ( xx [ 276 ] + xx [ 262 ] * state [ 23 ] ) * xx [ 4 ] ; xx [
262 ] = xx [ 209 ] + xx [ 209 ] - xx [ 274 ] ; xx [ 274 ] = ( xx [ 272 ] + xx
[ 259 ] * state [ 23 ] ) * xx [ 4 ] ; xx [ 259 ] = xx [ 274 ] + xx [ 274 ] ;
xx [ 281 ] = xx [ 1 ] ; xx [ 282 ] = - xx [ 262 ] ; xx [ 283 ] = - xx [ 259 ]
; solveSymmetricPosDef ( xx + 263 , xx + 281 , 3 , 1 , xx + 286 , xx + 289 )
; xx [ 272 ] = xx [ 192 ] - ( xx [ 261 ] * xx [ 288 ] - xx [ 273 ] * xx [ 287
] ) + xx [ 188 ] * xx [ 117 ] + xx [ 190 ] * xx [ 120 ] + xx [ 68 ] * xx [
185 ] ; xx [ 281 ] = xx [ 1 ] ; xx [ 282 ] = - xx [ 273 ] ; xx [ 283 ] = xx [
261 ] ; solveSymmetricPosDef ( xx + 263 , xx + 281 , 3 , 1 , xx + 289 , xx +
292 ) ; xx [ 192 ] = xx [ 261 ] * xx [ 291 ] - xx [ 273 ] * xx [ 290 ] ; xx [
274 ] = - xx [ 192 ] ; xx [ 276 ] = xx [ 255 ] - xx [ 258 ] ; xx [ 258 ] = xx
[ 276 ] + xx [ 276 ] ; xx [ 281 ] = xx [ 1 ] ; xx [ 282 ] = xx [ 275 ] ; xx [
283 ] = xx [ 258 ] ; solveSymmetricPosDef ( xx + 263 , xx + 281 , 3 , 1 , xx
+ 292 , xx + 295 ) ; xx [ 276 ] = xx [ 261 ] * xx [ 294 ] - xx [ 273 ] * xx [
293 ] ; xx [ 281 ] = - xx [ 276 ] ; xx [ 282 ] = xx [ 209 ] - xx [ 255 ] ; xx
[ 209 ] = xx [ 282 ] + xx [ 282 ] ; xx [ 295 ] = xx [ 1 ] ; xx [ 296 ] = xx [
209 ] ; xx [ 297 ] = xx [ 259 ] ; solveSymmetricPosDef ( xx + 263 , xx + 295
, 3 , 1 , xx + 298 , xx + 301 ) ; xx [ 282 ] = xx [ 261 ] * xx [ 300 ] - xx [
273 ] * xx [ 299 ] ; xx [ 283 ] = - xx [ 282 ] ; xx [ 286 ] = xx [ 193 ] - (
xx [ 275 ] * xx [ 287 ] + xx [ 288 ] * xx [ 277 ] ) + xx [ 195 ] * xx [ 117 ]
+ xx [ 86 ] * xx [ 120 ] + xx [ 75 ] * xx [ 185 ] ; xx [ 193 ] = - ( xx [ 275
] * xx [ 290 ] + xx [ 291 ] * xx [ 277 ] ) ; xx [ 289 ] = xx [ 275 ] * xx [
293 ] ; xx [ 292 ] = - ( xx [ 289 ] + xx [ 294 ] * xx [ 277 ] ) ; xx [ 295 ]
= xx [ 275 ] * xx [ 299 ] ; xx [ 296 ] = - ( xx [ 295 ] + xx [ 300 ] * xx [
277 ] ) ; xx [ 297 ] = - ( xx [ 290 ] * xx [ 262 ] + xx [ 259 ] * xx [ 291 ]
) ; xx [ 290 ] = - ( xx [ 293 ] * xx [ 262 ] + xx [ 259 ] * xx [ 294 ] ) ; xx
[ 291 ] = xx [ 259 ] * xx [ 300 ] ; xx [ 293 ] = - ( xx [ 299 ] * xx [ 262 ]
+ xx [ 291 ] ) ; xx [ 298 ] = 0.1675024183407511 ; xx [ 301 ] = xx [ 298 ] *
state [ 9 ] ; xx [ 302 ] = xx [ 298 ] * state [ 8 ] ; xx [ 303 ] = ( xx [ 301
] * state [ 7 ] + xx [ 302 ] * state [ 10 ] ) * xx [ 4 ] ; xx [ 304 ] = xx [
303 ] + xx [ 303 ] ; xx [ 303 ] = 5.583413944691896e-7 ; xx [ 305 ] =
1.253512617805746e-3 ; xx [ 306 ] = xx [ 303 ] ; xx [ 307 ] = xx [ 1 ] ; xx [
308 ] = xx [ 1 ] ; xx [ 309 ] = xx [ 1 ] ; xx [ 310 ] = xx [ 305 ] ; xx [ 311
] = xx [ 1 ] ; xx [ 312 ] = xx [ 1 ] ; xx [ 313 ] = xx [ 1 ] ; xx [ 314 ] =
xx [ 305 ] ; ii [ 0 ] = factorSymmetricPosDef ( xx + 306 , 3 , xx + 315 ) ;
if ( ii [ 0 ] != 0 ) { return sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:DegenerateMass" ,
 "'Kinematics_Model/LWB Rear Joint' has a degenerate mass distribution on its follower side."
, neDiagMgr ) ; } xx [ 305 ] = xx [ 298 ] * state [ 10 ] ; xx [ 315 ] = xx [
4 ] * ( xx [ 302 ] * state [ 9 ] - xx [ 305 ] * state [ 7 ] ) ; xx [ 316 ] =
xx [ 315 ] + xx [ 315 ] ; xx [ 317 ] = xx [ 1 ] ; xx [ 318 ] = xx [ 304 ] ;
xx [ 319 ] = - xx [ 316 ] ; solveSymmetricPosDef ( xx + 306 , xx + 317 , 3 ,
1 , xx + 320 , xx + 323 ) ; xx [ 315 ] = xx [ 302 ] * state [ 7 ] ; xx [ 317
] = xx [ 4 ] * ( xx [ 315 ] - xx [ 301 ] * state [ 10 ] ) ; xx [ 318 ] = xx [
317 ] + xx [ 317 ] ; xx [ 317 ] = 0.3350048366815023 ; xx [ 319 ] = xx [ 302
] * state [ 8 ] ; xx [ 302 ] = ( xx [ 305 ] * state [ 10 ] + xx [ 319 ] ) *
xx [ 4 ] ; xx [ 320 ] = xx [ 317 ] - ( xx [ 302 ] + xx [ 302 ] ) ; xx [ 323 ]
= xx [ 1 ] ; xx [ 324 ] = - xx [ 318 ] ; xx [ 325 ] = - xx [ 320 ] ;
solveSymmetricPosDef ( xx + 306 , xx + 323 , 3 , 1 , xx + 326 , xx + 329 ) ;
xx [ 302 ] = xx [ 197 ] + xx [ 304 ] * xx [ 327 ] - xx [ 316 ] * xx [ 328 ] ;
xx [ 197 ] = ( xx [ 319 ] + xx [ 301 ] * state [ 9 ] ) * xx [ 4 ] ; xx [ 301
] = xx [ 197 ] + xx [ 197 ] - xx [ 317 ] ; xx [ 197 ] = ( xx [ 315 ] + xx [
305 ] * state [ 9 ] ) * xx [ 4 ] ; xx [ 305 ] = xx [ 197 ] + xx [ 197 ] ; xx
[ 323 ] = xx [ 1 ] ; xx [ 324 ] = - xx [ 301 ] ; xx [ 325 ] = - xx [ 305 ] ;
solveSymmetricPosDef ( xx + 306 , xx + 323 , 3 , 1 , xx + 329 , xx + 332 ) ;
xx [ 197 ] = xx [ 199 ] + xx [ 304 ] * xx [ 330 ] - xx [ 316 ] * xx [ 331 ] ;
xx [ 199 ] = xx [ 217 ] + xx [ 6 ] * xx [ 213 ] - xx [ 318 ] * xx [ 330 ] -
xx [ 331 ] * xx [ 320 ] ; xx [ 213 ] = 0.1575773583037868 ; xx [ 217 ] = xx [
213 ] * state [ 30 ] ; xx [ 315 ] = xx [ 213 ] * state [ 29 ] ; xx [ 317 ] =
( xx [ 217 ] * state [ 28 ] + xx [ 315 ] * state [ 31 ] ) * xx [ 4 ] ; xx [
319 ] = xx [ 317 ] + xx [ 317 ] ; xx [ 317 ] = 5.252578610126096e-7 ; xx [
323 ] = 1.043661058615307e-3 ; xx [ 332 ] = xx [ 317 ] ; xx [ 333 ] = xx [ 1
] ; xx [ 334 ] = xx [ 1 ] ; xx [ 335 ] = xx [ 1 ] ; xx [ 336 ] = xx [ 323 ] ;
xx [ 337 ] = xx [ 1 ] ; xx [ 338 ] = xx [ 1 ] ; xx [ 339 ] = xx [ 1 ] ; xx [
340 ] = xx [ 323 ] ; ii [ 0 ] = factorSymmetricPosDef ( xx + 332 , 3 , xx +
323 ) ; if ( ii [ 0 ] != 0 ) { return sm_ssci_recordRunTimeError (
"sm:compiler:messages:simulationErrors:DegenerateMass" ,
 "'Kinematics_Model/UWB Rear Joint1' has a degenerate mass distribution on its follower side."
, neDiagMgr ) ; } xx [ 323 ] = xx [ 213 ] * state [ 31 ] ; xx [ 324 ] = xx [
4 ] * ( xx [ 315 ] * state [ 30 ] - xx [ 323 ] * state [ 28 ] ) ; xx [ 325 ]
= xx [ 324 ] + xx [ 324 ] ; xx [ 341 ] = xx [ 1 ] ; xx [ 342 ] = xx [ 319 ] ;
xx [ 343 ] = - xx [ 325 ] ; solveSymmetricPosDef ( xx + 332 , xx + 341 , 3 ,
1 , xx + 344 , xx + 347 ) ; xx [ 324 ] = xx [ 315 ] * state [ 28 ] ; xx [ 326
] = xx [ 4 ] * ( xx [ 324 ] - xx [ 217 ] * state [ 31 ] ) ; xx [ 329 ] = xx [
326 ] + xx [ 326 ] ; xx [ 326 ] = 0.3151547166075735 ; xx [ 341 ] = xx [ 315
] * state [ 29 ] ; xx [ 315 ] = ( xx [ 323 ] * state [ 31 ] + xx [ 341 ] ) *
xx [ 4 ] ; xx [ 342 ] = xx [ 326 ] - ( xx [ 315 ] + xx [ 315 ] ) ; xx [ 347 ]
= xx [ 1 ] ; xx [ 348 ] = - xx [ 329 ] ; xx [ 349 ] = - xx [ 342 ] ;
solveSymmetricPosDef ( xx + 332 , xx + 347 , 3 , 1 , xx + 350 , xx + 353 ) ;
xx [ 315 ] = xx [ 276 ] + xx [ 319 ] * xx [ 351 ] - xx [ 325 ] * xx [ 352 ] ;
xx [ 276 ] = ( xx [ 341 ] + xx [ 217 ] * state [ 30 ] ) * xx [ 4 ] ; xx [ 217
] = xx [ 276 ] + xx [ 276 ] - xx [ 326 ] ; xx [ 276 ] = ( xx [ 324 ] + xx [
323 ] * state [ 30 ] ) * xx [ 4 ] ; xx [ 323 ] = xx [ 276 ] + xx [ 276 ] ; xx
[ 347 ] = xx [ 1 ] ; xx [ 348 ] = - xx [ 217 ] ; xx [ 349 ] = - xx [ 323 ] ;
solveSymmetricPosDef ( xx + 332 , xx + 347 , 3 , 1 , xx + 353 , xx + 356 ) ;
xx [ 276 ] = xx [ 282 ] + xx [ 319 ] * xx [ 354 ] - xx [ 325 ] * xx [ 355 ] ;
xx [ 282 ] = xx [ 295 ] + xx [ 258 ] * xx [ 300 ] - xx [ 329 ] * xx [ 354 ] -
xx [ 355 ] * xx [ 342 ] ; xx [ 356 ] = xx [ 133 ] - ( xx [ 135 ] * xx [ 142 ]
- xx [ 136 ] * xx [ 141 ] ) + xx [ 111 ] * ( xx [ 130 ] - pm_math_dot3 ( xx +
137 , xx + 144 ) ) + xx [ 121 ] * ( xx [ 131 ] - pm_math_dot3 ( xx + 147 , xx
+ 144 ) ) + xx [ 73 ] * ( xx [ 132 ] - pm_math_dot3 ( xx + 82 , xx + 144 ) )
; xx [ 357 ] = xx [ 150 ] ; xx [ 358 ] = xx [ 127 ] ; xx [ 359 ] = xx [ 171 ]
; xx [ 360 ] = xx [ 183 ] ; xx [ 361 ] = xx [ 174 ] ; xx [ 362 ] = xx [ 194 ]
; xx [ 363 ] = xx [ 196 ] ; xx [ 364 ] = xx [ 124 ] ; xx [ 365 ] = xx [ 126 ]
; xx [ 366 ] = xx [ 198 ] ; xx [ 367 ] = xx [ 200 ] ; xx [ 368 ] = xx [ 1 ] ;
xx [ 369 ] = xx [ 1 ] ; xx [ 370 ] = xx [ 1 ] ; xx [ 371 ] = xx [ 150 ] ; xx
[ 372 ] = xx [ 90 ] - ( xx [ 26 ] * xx [ 157 ] + xx [ 158 ] * xx [ 122 ] ) +
xx [ 87 ] * xx [ 134 ] + xx [ 78 ] * xx [ 140 ] + xx [ 88 ] * xx [ 143 ] ; xx
[ 373 ] = xx [ 203 ] ; xx [ 374 ] = xx [ 119 ] ; xx [ 375 ] = xx [ 181 ] ; xx
[ 376 ] = xx [ 206 ] ; xx [ 377 ] = xx [ 207 ] ; xx [ 378 ] = xx [ 208 ] ; xx
[ 379 ] = xx [ 211 ] ; xx [ 380 ] = xx [ 214 ] ; xx [ 381 ] = xx [ 216 ] ; xx
[ 382 ] = xx [ 218 ] ; xx [ 383 ] = xx [ 1 ] ; xx [ 384 ] = xx [ 1 ] ; xx [
385 ] = xx [ 1 ] ; xx [ 386 ] = xx [ 127 ] ; xx [ 387 ] = xx [ 203 ] ; xx [
388 ] = xx [ 89 ] * xx [ 112 ] - ( xx [ 155 ] * xx [ 21 ] + xx [ 20 ] * xx [
156 ] ) + xx [ 77 ] * xx [ 113 ] + xx [ 71 ] * xx [ 116 ] ; xx [ 389 ] = xx [
219 ] ; xx [ 390 ] = xx [ 220 ] ; xx [ 391 ] = xx [ 221 ] ; xx [ 392 ] = xx [
222 ] ; xx [ 393 ] = xx [ 223 ] ; xx [ 394 ] = xx [ 224 ] ; xx [ 395 ] = xx [
225 ] ; xx [ 396 ] = xx [ 201 ] ; xx [ 397 ] = xx [ 204 ] ; xx [ 398 ] = xx [
1 ] ; xx [ 399 ] = xx [ 1 ] ; xx [ 400 ] = xx [ 1 ] ; xx [ 401 ] = xx [ 171 ]
; xx [ 402 ] = xx [ 119 ] ; xx [ 403 ] = xx [ 219 ] ; xx [ 404 ] = xx [ 180 ]
- ( xx [ 230 ] * xx [ 248 ] - xx [ 242 ] * xx [ 247 ] ) + xx [ 154 ] * xx [
159 ] + xx [ 161 ] * xx [ 165 ] + xx [ 128 ] * xx [ 167 ] ; xx [ 405 ] = xx [
227 ] ; xx [ 406 ] = xx [ 177 ] ; xx [ 407 ] = xx [ 168 ] ; xx [ 408 ] = xx [
241 ] ; xx [ 409 ] = xx [ 243 ] ; xx [ 410 ] = xx [ 1 ] ; xx [ 411 ] = xx [ 1
] ; xx [ 412 ] = xx [ 1 ] ; xx [ 413 ] = xx [ 1 ] ; xx [ 414 ] = xx [ 1 ] ;
xx [ 415 ] = xx [ 1 ] ; xx [ 416 ] = xx [ 183 ] ; xx [ 417 ] = xx [ 181 ] ;
xx [ 418 ] = xx [ 220 ] ; xx [ 419 ] = xx [ 227 ] ; xx [ 420 ] = xx [ 178 ] -
( xx [ 244 ] * xx [ 253 ] + xx [ 254 ] * xx [ 246 ] ) + xx [ 172 ] * xx [ 173
] + xx [ 153 ] * xx [ 179 ] + xx [ 160 ] * xx [ 182 ] ; xx [ 421 ] = xx [ 245
] ; xx [ 422 ] = xx [ 169 ] ; xx [ 423 ] = xx [ 70 ] ; xx [ 424 ] = xx [ 249
] ; xx [ 425 ] = xx [ 1 ] ; xx [ 426 ] = xx [ 1 ] ; xx [ 427 ] = xx [ 1 ] ;
xx [ 428 ] = xx [ 1 ] ; xx [ 429 ] = xx [ 1 ] ; xx [ 430 ] = xx [ 1 ] ; xx [
431 ] = xx [ 174 ] ; xx [ 432 ] = xx [ 206 ] ; xx [ 433 ] = xx [ 221 ] ; xx [
434 ] = xx [ 177 ] ; xx [ 435 ] = xx [ 245 ] ; xx [ 436 ] = xx [ 162 ] * xx [
164 ] - ( xx [ 256 ] * xx [ 231 ] + xx [ 228 ] * xx [ 257 ] ) + xx [ 163 ] *
xx [ 166 ] + xx [ 151 ] * xx [ 170 ] ; xx [ 437 ] = xx [ 250 ] ; xx [ 438 ] =
xx [ 251 ] ; xx [ 439 ] = xx [ 252 ] ; xx [ 440 ] = xx [ 1 ] ; xx [ 441 ] =
xx [ 1 ] ; xx [ 442 ] = xx [ 1 ] ; xx [ 443 ] = xx [ 1 ] ; xx [ 444 ] = xx [
1 ] ; xx [ 445 ] = xx [ 1 ] ; xx [ 446 ] = xx [ 194 ] ; xx [ 447 ] = xx [ 207
] ; xx [ 448 ] = xx [ 222 ] ; xx [ 449 ] = xx [ 168 ] ; xx [ 450 ] = xx [ 169
] ; xx [ 451 ] = xx [ 250 ] ; xx [ 452 ] = xx [ 69 ] - ( xx [ 261 ] * xx [
279 ] - xx [ 273 ] * xx [ 278 ] ) + xx [ 188 ] * xx [ 34 ] + xx [ 190 ] * xx
[ 176 ] + xx [ 68 ] * xx [ 186 ] ; xx [ 453 ] = xx [ 280 ] ; xx [ 454 ] = xx
[ 272 ] ; xx [ 455 ] = xx [ 1 ] ; xx [ 456 ] = xx [ 1 ] ; xx [ 457 ] = xx [ 1
] ; xx [ 458 ] = xx [ 274 ] ; xx [ 459 ] = xx [ 281 ] ; xx [ 460 ] = xx [ 283
] ; xx [ 461 ] = xx [ 196 ] ; xx [ 462 ] = xx [ 208 ] ; xx [ 463 ] = xx [ 223
] ; xx [ 464 ] = xx [ 241 ] ; xx [ 465 ] = xx [ 70 ] ; xx [ 466 ] = xx [ 251
] ; xx [ 467 ] = xx [ 280 ] ; xx [ 468 ] = xx [ 210 ] - ( xx [ 275 ] * xx [
284 ] + xx [ 285 ] * xx [ 277 ] ) + xx [ 195 ] * xx [ 31 ] + xx [ 86 ] * xx [
187 ] + xx [ 75 ] * xx [ 189 ] ; xx [ 469 ] = xx [ 286 ] ; xx [ 470 ] = xx [
1 ] ; xx [ 471 ] = xx [ 1 ] ; xx [ 472 ] = xx [ 1 ] ; xx [ 473 ] = xx [ 193 ]
; xx [ 474 ] = xx [ 292 ] ; xx [ 475 ] = xx [ 296 ] ; xx [ 476 ] = xx [ 124 ]
; xx [ 477 ] = xx [ 211 ] ; xx [ 478 ] = xx [ 224 ] ; xx [ 479 ] = xx [ 243 ]
; xx [ 480 ] = xx [ 249 ] ; xx [ 481 ] = xx [ 252 ] ; xx [ 482 ] = xx [ 272 ]
; xx [ 483 ] = xx [ 286 ] ; xx [ 484 ] = xx [ 191 ] * xx [ 117 ] - ( xx [ 287
] * xx [ 262 ] + xx [ 259 ] * xx [ 288 ] ) + xx [ 39 ] * xx [ 120 ] + xx [ 80
] * xx [ 185 ] ; xx [ 485 ] = xx [ 1 ] ; xx [ 486 ] = xx [ 1 ] ; xx [ 487 ] =
xx [ 1 ] ; xx [ 488 ] = xx [ 297 ] ; xx [ 489 ] = xx [ 290 ] ; xx [ 490 ] =
xx [ 293 ] ; xx [ 491 ] = xx [ 126 ] ; xx [ 492 ] = xx [ 214 ] ; xx [ 493 ] =
xx [ 225 ] ; xx [ 494 ] = xx [ 1 ] ; xx [ 495 ] = xx [ 1 ] ; xx [ 496 ] = xx
[ 1 ] ; xx [ 497 ] = xx [ 1 ] ; xx [ 498 ] = xx [ 1 ] ; xx [ 499 ] = xx [ 1 ]
; xx [ 500 ] = xx [ 125 ] + xx [ 304 ] * xx [ 321 ] - xx [ 316 ] * xx [ 322 ]
; xx [ 501 ] = xx [ 302 ] ; xx [ 502 ] = xx [ 197 ] ; xx [ 503 ] = xx [ 1 ] ;
xx [ 504 ] = xx [ 1 ] ; xx [ 505 ] = xx [ 1 ] ; xx [ 506 ] = xx [ 198 ] ; xx
[ 507 ] = xx [ 216 ] ; xx [ 508 ] = xx [ 201 ] ; xx [ 509 ] = xx [ 1 ] ; xx [
510 ] = xx [ 1 ] ; xx [ 511 ] = xx [ 1 ] ; xx [ 512 ] = xx [ 1 ] ; xx [ 513 ]
= xx [ 1 ] ; xx [ 514 ] = xx [ 1 ] ; xx [ 515 ] = xx [ 302 ] ; xx [ 516 ] =
xx [ 215 ] + xx [ 6 ] * xx [ 205 ] - xx [ 318 ] * xx [ 327 ] - xx [ 328 ] *
xx [ 320 ] ; xx [ 517 ] = xx [ 199 ] ; xx [ 518 ] = xx [ 1 ] ; xx [ 519 ] =
xx [ 1 ] ; xx [ 520 ] = xx [ 1 ] ; xx [ 521 ] = xx [ 200 ] ; xx [ 522 ] = xx
[ 218 ] ; xx [ 523 ] = xx [ 204 ] ; xx [ 524 ] = xx [ 1 ] ; xx [ 525 ] = xx [
1 ] ; xx [ 526 ] = xx [ 1 ] ; xx [ 527 ] = xx [ 1 ] ; xx [ 528 ] = xx [ 1 ] ;
xx [ 529 ] = xx [ 1 ] ; xx [ 530 ] = xx [ 197 ] ; xx [ 531 ] = xx [ 199 ] ;
xx [ 532 ] = xx [ 123 ] * xx [ 212 ] + xx [ 202 ] - xx [ 330 ] * xx [ 301 ] -
xx [ 305 ] * xx [ 331 ] ; xx [ 533 ] = xx [ 1 ] ; xx [ 534 ] = xx [ 1 ] ; xx
[ 535 ] = xx [ 1 ] ; xx [ 536 ] = xx [ 1 ] ; xx [ 537 ] = xx [ 1 ] ; xx [ 538
] = xx [ 1 ] ; xx [ 539 ] = xx [ 1 ] ; xx [ 540 ] = xx [ 1 ] ; xx [ 541 ] =
xx [ 1 ] ; xx [ 542 ] = xx [ 274 ] ; xx [ 543 ] = xx [ 193 ] ; xx [ 544 ] =
xx [ 297 ] ; xx [ 545 ] = xx [ 1 ] ; xx [ 546 ] = xx [ 1 ] ; xx [ 547 ] = xx
[ 1 ] ; xx [ 548 ] = xx [ 192 ] + xx [ 319 ] * xx [ 345 ] - xx [ 325 ] * xx [
346 ] ; xx [ 549 ] = xx [ 315 ] ; xx [ 550 ] = xx [ 276 ] ; xx [ 551 ] = xx [
1 ] ; xx [ 552 ] = xx [ 1 ] ; xx [ 553 ] = xx [ 1 ] ; xx [ 554 ] = xx [ 1 ] ;
xx [ 555 ] = xx [ 1 ] ; xx [ 556 ] = xx [ 1 ] ; xx [ 557 ] = xx [ 281 ] ; xx
[ 558 ] = xx [ 292 ] ; xx [ 559 ] = xx [ 290 ] ; xx [ 560 ] = xx [ 1 ] ; xx [
561 ] = xx [ 1 ] ; xx [ 562 ] = xx [ 1 ] ; xx [ 563 ] = xx [ 315 ] ; xx [ 564
] = xx [ 289 ] + xx [ 258 ] * xx [ 294 ] - xx [ 329 ] * xx [ 351 ] - xx [ 352
] * xx [ 342 ] ; xx [ 565 ] = xx [ 282 ] ; xx [ 566 ] = xx [ 1 ] ; xx [ 567 ]
= xx [ 1 ] ; xx [ 568 ] = xx [ 1 ] ; xx [ 569 ] = xx [ 1 ] ; xx [ 570 ] = xx
[ 1 ] ; xx [ 571 ] = xx [ 1 ] ; xx [ 572 ] = xx [ 283 ] ; xx [ 573 ] = xx [
296 ] ; xx [ 574 ] = xx [ 293 ] ; xx [ 575 ] = xx [ 1 ] ; xx [ 576 ] = xx [ 1
] ; xx [ 577 ] = xx [ 1 ] ; xx [ 578 ] = xx [ 276 ] ; xx [ 579 ] = xx [ 282 ]
; xx [ 580 ] = xx [ 209 ] * xx [ 299 ] + xx [ 291 ] - xx [ 354 ] * xx [ 217 ]
- xx [ 323 ] * xx [ 355 ] ; xx [ 31 ] = 6.202375824999999e-3 ; xx [ 34 ] = xx
[ 24 ] - xx [ 31 ] * xx [ 5 ] * state [ 4 ] * state [ 6 ] ; xx [ 23 ] = xx [
25 ] + xx [ 31 ] * xx [ 5 ] * state [ 4 ] * state [ 5 ] ; xx [ 124 ] = xx [ 3
] ; xx [ 125 ] = - xx [ 34 ] ; xx [ 126 ] = - xx [ 23 ] ;
solveSymmetricPosDef ( xx + 11 , xx + 124 , 3 , 1 , xx + 130 , xx + 140 ) ;
xx [ 278 ] = xx [ 0 ] ; xx [ 279 ] = xx [ 1 ] ; xx [ 280 ] = xx [ 1 ] ; xx [
281 ] = xx [ 1 ] ; xx [ 282 ] = xx [ 2 ] ; xx [ 283 ] = xx [ 1 ] ; xx [ 284 ]
= xx [ 1 ] ; xx [ 285 ] = xx [ 1 ] ; xx [ 286 ] = xx [ 2 ] ; xx [ 287 ] = xx
[ 1 ] ; xx [ 288 ] = xx [ 1 ] ; xx [ 289 ] = xx [ 1 ] ; xx [ 290 ] = xx [ 1 ]
; xx [ 291 ] = xx [ 1 ] ; xx [ 292 ] = xx [ 31 ] ; xx [ 293 ] = xx [ 1 ] ; xx
[ 294 ] = - xx [ 31 ] ; xx [ 295 ] = xx [ 1 ] ; solveSymmetricPosDef ( xx +
11 , xx + 278 , 3 , 6 , xx + 581 , xx + 124 ) ; xx [ 124 ] = xx [ 592 ] ; xx
[ 125 ] = xx [ 595 ] ; xx [ 126 ] = xx [ 598 ] ; xx [ 0 ] = 9.806649999999999
; xx [ 2 ] = xx [ 0 ] * state [ 1 ] ; xx [ 24 ] = xx [ 0 ] * state [ 2 ] ; xx
[ 140 ] = xx [ 4 ] * ( xx [ 2 ] * state [ 3 ] - xx [ 24 ] * state [ 0 ] ) ;
xx [ 141 ] = ( xx [ 2 ] * state [ 0 ] + xx [ 24 ] * state [ 3 ] ) * xx [ 4 ]
; xx [ 142 ] = xx [ 0 ] - ( xx [ 2 ] * state [ 1 ] + xx [ 24 ] * state [ 2 ]
) * xx [ 4 ] ; xx [ 2 ] = pm_math_dot3 ( xx + 124 , xx + 140 ) ; xx [ 24 ] =
xx [ 132 ] - xx [ 2 ] ; xx [ 25 ] = xx [ 135 ] * xx [ 24 ] ; xx [ 124 ] = xx
[ 591 ] ; xx [ 125 ] = xx [ 594 ] ; xx [ 126 ] = xx [ 597 ] ; xx [ 31 ] =
pm_math_dot3 ( xx + 124 , xx + 140 ) ; xx [ 69 ] = xx [ 131 ] - xx [ 31 ] ;
xx [ 70 ] = xx [ 136 ] * xx [ 69 ] ; xx [ 90 ] = xx [ 36 ] * state [ 43 ] -
xx [ 29 ] * state [ 45 ] ; xx [ 112 ] = xx [ 29 ] * state [ 44 ] - xx [ 32 ]
* state [ 43 ] ; xx [ 29 ] = xx [ 32 ] * state [ 45 ] - xx [ 36 ] * state [
44 ] ; xx [ 32 ] = xx [ 29 ] * state [ 44 ] - xx [ 90 ] * state [ 43 ] ; xx [
36 ] = xx [ 41 ] * state [ 43 ] - xx [ 37 ] * state [ 45 ] ; xx [ 113 ] = xx
[ 37 ] * state [ 44 ] - xx [ 30 ] * state [ 43 ] ; xx [ 37 ] = xx [ 30 ] *
state [ 45 ] - xx [ 41 ] * state [ 44 ] ; xx [ 30 ] = xx [ 37 ] * state [ 44
] - xx [ 36 ] * state [ 43 ] ; xx [ 41 ] = xx [ 38 ] * state [ 43 ] - xx [ 42
] * state [ 45 ] ; xx [ 116 ] = xx [ 42 ] * state [ 44 ] - xx [ 33 ] * state
[ 43 ] ; xx [ 42 ] = xx [ 33 ] * state [ 45 ] - xx [ 38 ] * state [ 44 ] ; xx
[ 33 ] = xx [ 42 ] * state [ 44 ] - xx [ 41 ] * state [ 43 ] ; xx [ 196 ] =
xx [ 90 ] * state [ 45 ] - xx [ 112 ] * state [ 44 ] ; xx [ 197 ] = xx [ 112
] * state [ 43 ] - xx [ 29 ] * state [ 45 ] ; xx [ 198 ] = xx [ 32 ] ; xx [
199 ] = xx [ 36 ] * state [ 45 ] - xx [ 113 ] * state [ 44 ] ; xx [ 200 ] =
xx [ 113 ] * state [ 43 ] - xx [ 37 ] * state [ 45 ] ; xx [ 201 ] = xx [ 30 ]
; xx [ 202 ] = xx [ 41 ] * state [ 45 ] - xx [ 116 ] * state [ 44 ] ; xx [
203 ] = xx [ 116 ] * state [ 43 ] - xx [ 42 ] * state [ 45 ] ; xx [ 204 ] =
xx [ 33 ] ; xx [ 36 ] = xx [ 74 ] ; xx [ 37 ] = - xx [ 72 ] ; xx [ 38 ] = -
xx [ 22 ] ; pm_math_matrix3x3Xform ( xx + 196 , xx + 36 , xx + 124 ) ; xx [
22 ] = xx [ 76 ] * xx [ 32 ] ; xx [ 29 ] = state [ 1 ] * state [ 3 ] ; xx [
32 ] = state [ 0 ] * state [ 2 ] ; xx [ 36 ] = state [ 0 ] * state [ 0 ] ; xx
[ 37 ] = ( xx [ 36 ] + state [ 1 ] * state [ 1 ] ) * xx [ 4 ] - xx [ 28 ] ;
xx [ 38 ] = state [ 1 ] * state [ 2 ] ; xx [ 41 ] = state [ 0 ] * state [ 3 ]
; xx [ 42 ] = xx [ 5 ] * ( ( xx [ 4 ] * ( xx [ 29 ] + xx [ 32 ] ) * state [ 4
] - xx [ 37 ] * state [ 6 ] ) * state [ 6 ] - ( xx [ 37 ] * state [ 5 ] - xx
[ 4 ] * ( xx [ 38 ] - xx [ 41 ] ) * state [ 4 ] ) * state [ 5 ] ) ; xx [ 37 ]
= xx [ 42 ] + xx [ 42 ] ; xx [ 130 ] = state [ 39 ] ; xx [ 131 ] = state [ 40
] ; xx [ 132 ] = state [ 41 ] ; xx [ 133 ] = state [ 42 ] ; xx [ 42 ] = xx [
76 ] * state [ 43 ] ; xx [ 72 ] = xx [ 27 ] * xx [ 42 ] * state [ 45 ] ; xx [
143 ] = state [ 43 ] ; xx [ 144 ] = state [ 44 ] ; xx [ 145 ] = state [ 45 ]
; xx [ 155 ] = xx [ 53 ] * state [ 43 ] ; xx [ 156 ] = xx [ 63 ] * state [ 44
] ; xx [ 157 ] = xx [ 53 ] * state [ 45 ] ; pm_math_cross3 ( xx + 143 , xx +
155 , xx + 164 ) ; xx [ 74 ] = xx [ 76 ] * state [ 44 ] ; xx [ 90 ] = xx [ 27
] * xx [ 74 ] * state [ 45 ] ; xx [ 112 ] = xx [ 164 ] - xx [ 76 ] * xx [ 90
] ; xx [ 113 ] = xx [ 165 ] + xx [ 76 ] * xx [ 72 ] ; xx [ 155 ] = - xx [ 112
] ; xx [ 156 ] = - xx [ 113 ] ; xx [ 157 ] = - xx [ 166 ] ;
solveSymmetricPosDef ( xx + 54 , xx + 155 , 3 , 1 , xx + 167 , xx + 176 ) ;
xx [ 116 ] = - ( ( xx [ 42 ] * state [ 43 ] + xx [ 74 ] * state [ 44 ] ) * xx
[ 27 ] ) ; xx [ 155 ] = xx [ 72 ] + xx [ 52 ] * xx [ 168 ] ; xx [ 156 ] = xx
[ 90 ] - xx [ 52 ] * xx [ 167 ] ; xx [ 157 ] = xx [ 116 ] ; pm_math_quatXform
( xx + 130 , xx + 155 , xx + 176 ) ; xx [ 27 ] = xx [ 102 ] * inputDdot [ 0 ]
; xx [ 42 ] = xx [ 105 ] * inputDdot [ 0 ] ; xx [ 119 ] = - ( xx [ 176 ] + xx
[ 27 ] ) ; xx [ 120 ] = - ( xx [ 177 ] + xx [ 42 ] ) ; solveSymmetricPosDef (
xx + 64 , xx + 119 , 2 , 1 , xx + 155 , xx + 157 ) ; xx [ 278 ] = - ( xx [ 53
] * xx [ 91 ] ) ; xx [ 279 ] = - ( xx [ 53 ] * xx [ 94 ] ) ; xx [ 280 ] = - (
xx [ 53 ] * xx [ 97 ] ) ; xx [ 281 ] = - ( xx [ 63 ] * xx [ 92 ] ) ; xx [ 282
] = - ( xx [ 63 ] * xx [ 95 ] ) ; xx [ 283 ] = - ( xx [ 63 ] * xx [ 98 ] ) ;
xx [ 284 ] = - ( xx [ 53 ] * xx [ 93 ] ) ; xx [ 285 ] = - ( xx [ 53 ] * xx [
96 ] ) ; xx [ 286 ] = - ( xx [ 53 ] * xx [ 99 ] ) ;
pm_math_matrix3x3ComposeTranspose ( xx + 278 , xx + 43 , xx + 91 ) ;
pm_math_matrix3x3Compose ( xx + 43 , xx + 91 , xx + 278 ) ; xx [ 43 ] = ( xx
[ 81 ] + xx [ 109 ] * state [ 42 ] ) * xx [ 4 ] ; xx [ 44 ] = xx [ 4 ] * ( xx
[ 114 ] * state [ 42 ] - xx [ 79 ] ) ; xx [ 45 ] = xx [ 76 ] - ( xx [ 85 ] +
xx [ 115 ] ) * xx [ 4 ] ; pm_math_matrix3x3PostCross ( xx + 100 , xx + 43 ,
xx + 91 ) ; xx [ 286 ] = xx [ 278 ] - xx [ 91 ] ; xx [ 287 ] = xx [ 279 ] -
xx [ 94 ] ; xx [ 288 ] = xx [ 281 ] - xx [ 92 ] ; xx [ 289 ] = xx [ 282 ] -
xx [ 95 ] ; xx [ 290 ] = xx [ 284 ] - xx [ 93 ] ; xx [ 291 ] = xx [ 285 ] -
xx [ 96 ] ; xx [ 292 ] = xx [ 35 ] ; xx [ 293 ] = xx [ 101 ] ; xx [ 294 ] =
xx [ 103 ] ; xx [ 295 ] = xx [ 40 ] ; xx [ 296 ] = xx [ 106 ] ; xx [ 297 ] =
xx [ 107 ] ; solveSymmetricPosDef ( xx + 64 , xx + 286 , 2 , 6 , xx + 91 , xx
+ 43 ) ; xx [ 35 ] = xx [ 0 ] * xx [ 101 ] ; xx [ 40 ] = xx [ 155 ] - xx [ 35
] ; xx [ 43 ] = xx [ 0 ] * xx [ 102 ] ; xx [ 44 ] = xx [ 156 ] - xx [ 43 ] ;
xx [ 45 ] = xx [ 0 ] + inputDdot [ 0 ] ; xx [ 46 ] = xx [ 40 ] ; xx [ 47 ] =
xx [ 44 ] ; xx [ 48 ] = xx [ 45 ] ; pm_math_quatInverseXform ( xx + 130 , xx
+ 46 , xx + 49 ) ; xx [ 46 ] = xx [ 167 ] - pm_math_dot3 ( xx + 137 , xx + 49
) ; xx [ 47 ] = xx [ 168 ] - pm_math_dot3 ( xx + 147 , xx + 49 ) ; xx [ 48 ]
= xx [ 169 ] - pm_math_dot3 ( xx + 82 , xx + 49 ) ; xx [ 49 ] = xx [ 26 ] *
xx [ 69 ] ; xx [ 50 ] = xx [ 76 ] * xx [ 30 ] ; xx [ 30 ] = state [ 2 ] *
state [ 3 ] ; xx [ 51 ] = state [ 0 ] * state [ 1 ] ; xx [ 53 ] = ( xx [ 38 ]
+ xx [ 41 ] ) * xx [ 4 ] ; xx [ 38 ] = xx [ 5 ] * ( ( xx [ 4 ] * ( xx [ 30 ]
- xx [ 51 ] ) * state [ 4 ] - xx [ 53 ] * state [ 6 ] ) * state [ 6 ] - ( xx
[ 53 ] * state [ 5 ] - ( ( xx [ 36 ] + state [ 2 ] * state [ 2 ] ) * xx [ 4 ]
- xx [ 28 ] ) * state [ 4 ] ) * state [ 5 ] ) ; xx [ 41 ] = xx [ 38 ] + xx [
38 ] ; xx [ 38 ] = xx [ 76 ] * xx [ 33 ] ; xx [ 33 ] = xx [ 4 ] * ( xx [ 29 ]
- xx [ 32 ] ) ; xx [ 29 ] = xx [ 5 ] * ( ( ( ( xx [ 36 ] + state [ 3 ] *
state [ 3 ] ) * xx [ 4 ] - xx [ 28 ] ) * state [ 4 ] - xx [ 33 ] * state [ 6
] ) * state [ 6 ] - ( xx [ 33 ] * state [ 5 ] - xx [ 4 ] * ( xx [ 30 ] + xx [
51 ] ) * state [ 4 ] ) * state [ 5 ] ) ; xx [ 5 ] = xx [ 29 ] + xx [ 29 ] ;
xx [ 29 ] = xx [ 20 ] * xx [ 24 ] ; xx [ 91 ] = state [ 18 ] ; xx [ 92 ] =
state [ 19 ] ; xx [ 93 ] = state [ 20 ] ; xx [ 30 ] = 2.862166518905123e-4 ;
xx [ 94 ] = xx [ 229 ] * state [ 18 ] ; xx [ 95 ] = xx [ 30 ] * state [ 19 ]
; xx [ 96 ] = xx [ 30 ] * state [ 20 ] ; pm_math_cross3 ( xx + 91 , xx + 94 ,
xx + 97 ) ; xx [ 32 ] = - xx [ 97 ] ; xx [ 33 ] = 5.279750185000001e-3 ; xx [
36 ] = xx [ 98 ] - xx [ 33 ] * xx [ 226 ] * state [ 18 ] * state [ 20 ] ; xx
[ 51 ] = xx [ 99 ] + xx [ 33 ] * xx [ 226 ] * state [ 18 ] * state [ 19 ] ;
xx [ 94 ] = xx [ 32 ] ; xx [ 95 ] = - xx [ 36 ] ; xx [ 96 ] = - xx [ 51 ] ;
solveSymmetricPosDef ( xx + 232 , xx + 94 , 3 , 1 , xx + 97 , xx + 100 ) ; xx
[ 278 ] = xx [ 229 ] ; xx [ 279 ] = xx [ 1 ] ; xx [ 280 ] = xx [ 1 ] ; xx [
281 ] = xx [ 1 ] ; xx [ 282 ] = xx [ 30 ] ; xx [ 283 ] = xx [ 1 ] ; xx [ 284
] = xx [ 1 ] ; xx [ 285 ] = xx [ 1 ] ; xx [ 286 ] = xx [ 30 ] ; xx [ 287 ] =
xx [ 1 ] ; xx [ 288 ] = xx [ 1 ] ; xx [ 289 ] = xx [ 1 ] ; xx [ 290 ] = xx [
1 ] ; xx [ 291 ] = xx [ 1 ] ; xx [ 292 ] = xx [ 33 ] ; xx [ 293 ] = xx [ 1 ]
; xx [ 294 ] = - xx [ 33 ] ; xx [ 295 ] = xx [ 1 ] ; solveSymmetricPosDef (
xx + 232 , xx + 278 , 3 , 6 , xx + 599 , xx + 94 ) ; xx [ 94 ] = xx [ 610 ] ;
xx [ 95 ] = xx [ 613 ] ; xx [ 96 ] = xx [ 616 ] ; xx [ 30 ] = xx [ 0 ] *
state [ 15 ] ; xx [ 33 ] = xx [ 0 ] * state [ 16 ] ; xx [ 100 ] = xx [ 4 ] *
( xx [ 30 ] * state [ 17 ] - xx [ 33 ] * state [ 14 ] ) ; xx [ 101 ] = ( xx [
30 ] * state [ 14 ] + xx [ 33 ] * state [ 17 ] ) * xx [ 4 ] ; xx [ 102 ] = xx
[ 0 ] - ( xx [ 30 ] * state [ 15 ] + xx [ 33 ] * state [ 16 ] ) * xx [ 4 ] ;
xx [ 30 ] = pm_math_dot3 ( xx + 94 , xx + 100 ) ; xx [ 33 ] = xx [ 99 ] - xx
[ 30 ] ; xx [ 94 ] = xx [ 609 ] ; xx [ 95 ] = xx [ 612 ] ; xx [ 96 ] = xx [
615 ] ; xx [ 53 ] = pm_math_dot3 ( xx + 94 , xx + 100 ) ; xx [ 63 ] = xx [ 98
] - xx [ 53 ] ; xx [ 94 ] = xx [ 152 ] ; xx [ 95 ] = - xx [ 118 ] ; xx [ 96 ]
= xx [ 129 ] ; pm_math_matrix3x3Xform ( xx + 196 , xx + 94 , xx + 97 ) ; xx [
74 ] = state [ 15 ] * state [ 17 ] ; xx [ 76 ] = state [ 14 ] * state [ 16 ]
; xx [ 79 ] = state [ 14 ] * state [ 14 ] ; xx [ 81 ] = ( xx [ 79 ] + state [
15 ] * state [ 15 ] ) * xx [ 4 ] - xx [ 28 ] ; xx [ 85 ] = state [ 15 ] *
state [ 16 ] ; xx [ 94 ] = state [ 14 ] * state [ 17 ] ; xx [ 95 ] = xx [ 226
] * ( ( xx [ 4 ] * ( xx [ 74 ] + xx [ 76 ] ) * state [ 18 ] - xx [ 81 ] *
state [ 20 ] ) * state [ 20 ] - ( xx [ 81 ] * state [ 19 ] - xx [ 4 ] * ( xx
[ 85 ] - xx [ 94 ] ) * state [ 18 ] ) * state [ 19 ] ) ; xx [ 81 ] = state [
16 ] * state [ 17 ] ; xx [ 96 ] = state [ 14 ] * state [ 15 ] ; xx [ 103 ] =
( xx [ 85 ] + xx [ 94 ] ) * xx [ 4 ] ; xx [ 85 ] = xx [ 226 ] * ( ( xx [ 4 ]
* ( xx [ 81 ] - xx [ 96 ] ) * state [ 18 ] - xx [ 103 ] * state [ 20 ] ) *
state [ 20 ] - ( xx [ 103 ] * state [ 19 ] - ( ( xx [ 79 ] + state [ 16 ] *
state [ 16 ] ) * xx [ 4 ] - xx [ 28 ] ) * state [ 18 ] ) * state [ 19 ] ) ;
xx [ 94 ] = xx [ 4 ] * ( xx [ 74 ] - xx [ 76 ] ) ; xx [ 74 ] = xx [ 226 ] * (
( ( ( xx [ 79 ] + state [ 17 ] * state [ 17 ] ) * xx [ 4 ] - xx [ 28 ] ) *
state [ 18 ] - xx [ 94 ] * state [ 20 ] ) * state [ 20 ] - ( xx [ 94 ] *
state [ 19 ] - xx [ 4 ] * ( xx [ 81 ] + xx [ 96 ] ) * state [ 18 ] ) * state
[ 19 ] ) ; xx [ 103 ] = state [ 25 ] ; xx [ 104 ] = state [ 26 ] ; xx [ 105 ]
= state [ 27 ] ; xx [ 76 ] = 3.730789681535579e-4 ; xx [ 106 ] = xx [ 260 ] *
state [ 25 ] ; xx [ 107 ] = xx [ 76 ] * state [ 26 ] ; xx [ 108 ] = xx [ 76 ]
* state [ 27 ] ; pm_math_cross3 ( xx + 103 , xx + 106 , xx + 117 ) ; xx [ 79
] = - xx [ 117 ] ; xx [ 81 ] = 6.300790130000002e-3 ; xx [ 94 ] = xx [ 118 ]
- xx [ 81 ] * xx [ 255 ] * state [ 25 ] * state [ 27 ] ; xx [ 96 ] = xx [ 119
] + xx [ 81 ] * xx [ 255 ] * state [ 25 ] * state [ 26 ] ; xx [ 106 ] = xx [
79 ] ; xx [ 107 ] = - xx [ 94 ] ; xx [ 108 ] = - xx [ 96 ] ;
solveSymmetricPosDef ( xx + 263 , xx + 106 , 3 , 1 , xx + 117 , xx + 155 ) ;
xx [ 278 ] = xx [ 260 ] ; xx [ 279 ] = xx [ 1 ] ; xx [ 280 ] = xx [ 1 ] ; xx
[ 281 ] = xx [ 1 ] ; xx [ 282 ] = xx [ 76 ] ; xx [ 283 ] = xx [ 1 ] ; xx [
284 ] = xx [ 1 ] ; xx [ 285 ] = xx [ 1 ] ; xx [ 286 ] = xx [ 76 ] ; xx [ 287
] = xx [ 1 ] ; xx [ 288 ] = xx [ 1 ] ; xx [ 289 ] = xx [ 1 ] ; xx [ 290 ] =
xx [ 1 ] ; xx [ 291 ] = xx [ 1 ] ; xx [ 292 ] = xx [ 81 ] ; xx [ 293 ] = xx [
1 ] ; xx [ 294 ] = - xx [ 81 ] ; xx [ 295 ] = xx [ 1 ] ; solveSymmetricPosDef
( xx + 263 , xx + 278 , 3 , 6 , xx + 617 , xx + 106 ) ; xx [ 106 ] = xx [ 628
] ; xx [ 107 ] = xx [ 631 ] ; xx [ 108 ] = xx [ 634 ] ; xx [ 76 ] = xx [ 0 ]
* state [ 22 ] ; xx [ 81 ] = xx [ 0 ] * state [ 23 ] ; xx [ 155 ] = xx [ 4 ]
* ( xx [ 76 ] * state [ 24 ] - xx [ 81 ] * state [ 21 ] ) ; xx [ 156 ] = ( xx
[ 76 ] * state [ 21 ] + xx [ 81 ] * state [ 24 ] ) * xx [ 4 ] ; xx [ 157 ] =
xx [ 0 ] - ( xx [ 76 ] * state [ 22 ] + xx [ 81 ] * state [ 23 ] ) * xx [ 4 ]
; xx [ 76 ] = pm_math_dot3 ( xx + 106 , xx + 155 ) ; xx [ 81 ] = xx [ 119 ] -
xx [ 76 ] ; xx [ 106 ] = xx [ 261 ] * xx [ 81 ] ; xx [ 107 ] = xx [ 627 ] ;
xx [ 108 ] = xx [ 630 ] ; xx [ 109 ] = xx [ 633 ] ; xx [ 114 ] = pm_math_dot3
( xx + 107 , xx + 155 ) ; xx [ 107 ] = xx [ 118 ] - xx [ 114 ] ; xx [ 108 ] =
xx [ 273 ] * xx [ 107 ] ; xx [ 117 ] = - xx [ 110 ] ; xx [ 118 ] = - xx [ 175
] ; xx [ 119 ] = xx [ 184 ] ; pm_math_matrix3x3Xform ( xx + 196 , xx + 117 ,
xx + 167 ) ; xx [ 109 ] = state [ 22 ] * state [ 24 ] ; xx [ 110 ] = state [
21 ] * state [ 23 ] ; xx [ 115 ] = state [ 21 ] * state [ 21 ] ; xx [ 117 ] =
( xx [ 115 ] + state [ 22 ] * state [ 22 ] ) * xx [ 4 ] - xx [ 28 ] ; xx [
118 ] = state [ 22 ] * state [ 23 ] ; xx [ 119 ] = state [ 21 ] * state [ 24
] ; xx [ 120 ] = xx [ 255 ] * ( ( xx [ 4 ] * ( xx [ 109 ] + xx [ 110 ] ) *
state [ 25 ] - xx [ 117 ] * state [ 27 ] ) * state [ 27 ] - ( xx [ 117 ] *
state [ 26 ] - xx [ 4 ] * ( xx [ 118 ] - xx [ 119 ] ) * state [ 25 ] ) *
state [ 26 ] ) ; xx [ 117 ] = xx [ 120 ] + xx [ 120 ] ; xx [ 120 ] = xx [ 275
] * xx [ 107 ] ; xx [ 127 ] = state [ 23 ] * state [ 24 ] ; xx [ 129 ] =
state [ 21 ] * state [ 22 ] ; xx [ 134 ] = ( xx [ 118 ] + xx [ 119 ] ) * xx [
4 ] ; xx [ 118 ] = xx [ 255 ] * ( ( xx [ 4 ] * ( xx [ 127 ] - xx [ 129 ] ) *
state [ 25 ] - xx [ 134 ] * state [ 27 ] ) * state [ 27 ] - ( xx [ 134 ] *
state [ 26 ] - ( ( xx [ 115 ] + state [ 23 ] * state [ 23 ] ) * xx [ 4 ] - xx
[ 28 ] ) * state [ 25 ] ) * state [ 26 ] ) ; xx [ 119 ] = xx [ 118 ] + xx [
118 ] ; xx [ 118 ] = xx [ 4 ] * ( xx [ 109 ] - xx [ 110 ] ) ; xx [ 109 ] = xx
[ 255 ] * ( ( ( ( xx [ 115 ] + state [ 24 ] * state [ 24 ] ) * xx [ 4 ] - xx
[ 28 ] ) * state [ 25 ] - xx [ 118 ] * state [ 27 ] ) * state [ 27 ] - ( xx [
118 ] * state [ 26 ] - xx [ 4 ] * ( xx [ 127 ] + xx [ 129 ] ) * state [ 25 ]
) * state [ 26 ] ) ; xx [ 110 ] = xx [ 109 ] + xx [ 109 ] ; xx [ 109 ] = xx [
259 ] * xx [ 81 ] ; xx [ 173 ] = state [ 11 ] ; xx [ 174 ] = state [ 12 ] ;
xx [ 175 ] = state [ 13 ] ; xx [ 115 ] = 3.135875324743626e-4 ; xx [ 176 ] =
xx [ 303 ] * state [ 11 ] ; xx [ 177 ] = xx [ 115 ] * state [ 12 ] ; xx [ 178
] = xx [ 115 ] * state [ 13 ] ; pm_math_cross3 ( xx + 173 , xx + 176 , xx +
179 ) ; xx [ 118 ] = - xx [ 179 ] ; xx [ 127 ] = 5.61141203e-3 ; xx [ 129 ] =
xx [ 180 ] - xx [ 127 ] * xx [ 298 ] * state [ 11 ] * state [ 13 ] ; xx [ 134
] = xx [ 181 ] + xx [ 127 ] * xx [ 298 ] * state [ 11 ] * state [ 12 ] ; xx [
176 ] = xx [ 118 ] ; xx [ 177 ] = - xx [ 129 ] ; xx [ 178 ] = - xx [ 134 ] ;
solveSymmetricPosDef ( xx + 306 , xx + 176 , 3 , 1 , xx + 179 , xx + 182 ) ;
xx [ 278 ] = xx [ 303 ] ; xx [ 279 ] = xx [ 1 ] ; xx [ 280 ] = xx [ 1 ] ; xx
[ 281 ] = xx [ 1 ] ; xx [ 282 ] = xx [ 115 ] ; xx [ 283 ] = xx [ 1 ] ; xx [
284 ] = xx [ 1 ] ; xx [ 285 ] = xx [ 1 ] ; xx [ 286 ] = xx [ 115 ] ; xx [ 287
] = xx [ 1 ] ; xx [ 288 ] = xx [ 1 ] ; xx [ 289 ] = xx [ 1 ] ; xx [ 290 ] =
xx [ 1 ] ; xx [ 291 ] = xx [ 1 ] ; xx [ 292 ] = xx [ 127 ] ; xx [ 293 ] = xx
[ 1 ] ; xx [ 294 ] = - xx [ 127 ] ; xx [ 295 ] = xx [ 1 ] ;
solveSymmetricPosDef ( xx + 306 , xx + 278 , 3 , 6 , xx + 635 , xx + 176 ) ;
xx [ 176 ] = xx [ 646 ] ; xx [ 177 ] = xx [ 649 ] ; xx [ 178 ] = xx [ 652 ] ;
xx [ 115 ] = xx [ 0 ] * state [ 8 ] ; xx [ 127 ] = xx [ 0 ] * state [ 9 ] ;
xx [ 182 ] = xx [ 4 ] * ( xx [ 115 ] * state [ 10 ] - xx [ 127 ] * state [ 7
] ) ; xx [ 183 ] = ( xx [ 115 ] * state [ 7 ] + xx [ 127 ] * state [ 10 ] ) *
xx [ 4 ] ; xx [ 184 ] = xx [ 0 ] - ( xx [ 115 ] * state [ 8 ] + xx [ 127 ] *
state [ 9 ] ) * xx [ 4 ] ; xx [ 115 ] = pm_math_dot3 ( xx + 176 , xx + 182 )
; xx [ 127 ] = xx [ 181 ] - xx [ 115 ] ; xx [ 176 ] = xx [ 645 ] ; xx [ 177 ]
= xx [ 648 ] ; xx [ 178 ] = xx [ 651 ] ; xx [ 146 ] = pm_math_dot3 ( xx + 176
, xx + 182 ) ; xx [ 150 ] = xx [ 180 ] - xx [ 146 ] ; xx [ 152 ] = state [ 8
] * state [ 10 ] ; xx [ 158 ] = state [ 7 ] * state [ 9 ] ; xx [ 159 ] =
state [ 7 ] * state [ 7 ] ; xx [ 164 ] = ( xx [ 159 ] + state [ 8 ] * state [
8 ] ) * xx [ 4 ] - xx [ 28 ] ; xx [ 165 ] = state [ 8 ] * state [ 9 ] ; xx [
170 ] = state [ 7 ] * state [ 10 ] ; xx [ 171 ] = xx [ 298 ] * ( ( xx [ 4 ] *
( xx [ 152 ] + xx [ 158 ] ) * state [ 11 ] - xx [ 164 ] * state [ 13 ] ) *
state [ 13 ] - ( xx [ 164 ] * state [ 12 ] - xx [ 4 ] * ( xx [ 165 ] - xx [
170 ] ) * state [ 11 ] ) * state [ 12 ] ) ; xx [ 164 ] = state [ 9 ] * state
[ 10 ] ; xx [ 176 ] = state [ 7 ] * state [ 8 ] ; xx [ 177 ] = ( xx [ 165 ] +
xx [ 170 ] ) * xx [ 4 ] ; xx [ 165 ] = xx [ 298 ] * ( ( xx [ 4 ] * ( xx [ 164
] - xx [ 176 ] ) * state [ 11 ] - xx [ 177 ] * state [ 13 ] ) * state [ 13 ]
- ( xx [ 177 ] * state [ 12 ] - ( ( xx [ 159 ] + state [ 9 ] * state [ 9 ] )
* xx [ 4 ] - xx [ 28 ] ) * state [ 11 ] ) * state [ 12 ] ) ; xx [ 170 ] = xx
[ 4 ] * ( xx [ 152 ] - xx [ 158 ] ) ; xx [ 152 ] = xx [ 298 ] * ( ( ( ( xx [
159 ] + state [ 10 ] * state [ 10 ] ) * xx [ 4 ] - xx [ 28 ] ) * state [ 11 ]
- xx [ 170 ] * state [ 13 ] ) * state [ 13 ] - ( xx [ 170 ] * state [ 12 ] -
xx [ 4 ] * ( xx [ 164 ] + xx [ 176 ] ) * state [ 11 ] ) * state [ 12 ] ) ; xx
[ 176 ] = state [ 32 ] ; xx [ 177 ] = state [ 33 ] ; xx [ 178 ] = state [ 34
] ; xx [ 158 ] = 2.611122363517065e-4 ; xx [ 179 ] = xx [ 317 ] * state [ 32
] ; xx [ 180 ] = xx [ 158 ] * state [ 33 ] ; xx [ 181 ] = xx [ 158 ] * state
[ 34 ] ; pm_math_cross3 ( xx + 176 , xx + 179 , xx + 185 ) ; xx [ 159 ] = -
xx [ 185 ] ; xx [ 164 ] = 4.96612477e-3 ; xx [ 170 ] = xx [ 186 ] - xx [ 164
] * xx [ 213 ] * state [ 32 ] * state [ 34 ] ; xx [ 179 ] = xx [ 187 ] + xx [
164 ] * xx [ 213 ] * state [ 32 ] * state [ 33 ] ; xx [ 185 ] = xx [ 159 ] ;
xx [ 186 ] = - xx [ 170 ] ; xx [ 187 ] = - xx [ 179 ] ; solveSymmetricPosDef
( xx + 332 , xx + 185 , 3 , 1 , xx + 192 , xx + 196 ) ; xx [ 278 ] = xx [ 317
] ; xx [ 279 ] = xx [ 1 ] ; xx [ 280 ] = xx [ 1 ] ; xx [ 281 ] = xx [ 1 ] ;
xx [ 282 ] = xx [ 158 ] ; xx [ 283 ] = xx [ 1 ] ; xx [ 284 ] = xx [ 1 ] ; xx
[ 285 ] = xx [ 1 ] ; xx [ 286 ] = xx [ 158 ] ; xx [ 287 ] = xx [ 1 ] ; xx [
288 ] = xx [ 1 ] ; xx [ 289 ] = xx [ 1 ] ; xx [ 290 ] = xx [ 1 ] ; xx [ 291 ]
= xx [ 1 ] ; xx [ 292 ] = xx [ 164 ] ; xx [ 293 ] = xx [ 1 ] ; xx [ 294 ] = -
xx [ 164 ] ; xx [ 295 ] = xx [ 1 ] ; solveSymmetricPosDef ( xx + 332 , xx +
278 , 3 , 6 , xx + 653 , xx + 185 ) ; xx [ 185 ] = xx [ 664 ] ; xx [ 186 ] =
xx [ 667 ] ; xx [ 187 ] = xx [ 670 ] ; xx [ 158 ] = xx [ 0 ] * state [ 29 ] ;
xx [ 164 ] = xx [ 0 ] * state [ 30 ] ; xx [ 196 ] = xx [ 4 ] * ( xx [ 158 ] *
state [ 31 ] - xx [ 164 ] * state [ 28 ] ) ; xx [ 197 ] = ( xx [ 158 ] *
state [ 28 ] + xx [ 164 ] * state [ 31 ] ) * xx [ 4 ] ; xx [ 198 ] = xx [ 0 ]
- ( xx [ 158 ] * state [ 29 ] + xx [ 164 ] * state [ 30 ] ) * xx [ 4 ] ; xx [
0 ] = pm_math_dot3 ( xx + 185 , xx + 196 ) ; xx [ 158 ] = xx [ 194 ] - xx [ 0
] ; xx [ 185 ] = xx [ 663 ] ; xx [ 186 ] = xx [ 666 ] ; xx [ 187 ] = xx [ 669
] ; xx [ 164 ] = pm_math_dot3 ( xx + 185 , xx + 196 ) ; xx [ 180 ] = xx [ 193
] - xx [ 164 ] ; xx [ 181 ] = state [ 29 ] * state [ 31 ] ; xx [ 185 ] =
state [ 28 ] * state [ 30 ] ; xx [ 186 ] = state [ 28 ] * state [ 28 ] ; xx [
187 ] = ( xx [ 186 ] + state [ 29 ] * state [ 29 ] ) * xx [ 4 ] - xx [ 28 ] ;
xx [ 189 ] = state [ 29 ] * state [ 30 ] ; xx [ 192 ] = state [ 28 ] * state
[ 31 ] ; xx [ 193 ] = xx [ 213 ] * ( ( xx [ 4 ] * ( xx [ 181 ] + xx [ 185 ] )
* state [ 32 ] - xx [ 187 ] * state [ 34 ] ) * state [ 34 ] - ( xx [ 187 ] *
state [ 33 ] - xx [ 4 ] * ( xx [ 189 ] - xx [ 192 ] ) * state [ 32 ] ) *
state [ 33 ] ) ; xx [ 187 ] = state [ 30 ] * state [ 31 ] ; xx [ 194 ] =
state [ 28 ] * state [ 29 ] ; xx [ 199 ] = ( xx [ 189 ] + xx [ 192 ] ) * xx [
4 ] ; xx [ 189 ] = xx [ 213 ] * ( ( xx [ 4 ] * ( xx [ 187 ] - xx [ 194 ] ) *
state [ 32 ] - xx [ 199 ] * state [ 34 ] ) * state [ 34 ] - ( xx [ 199 ] *
state [ 33 ] - ( ( xx [ 186 ] + state [ 30 ] * state [ 30 ] ) * xx [ 4 ] - xx
[ 28 ] ) * state [ 32 ] ) * state [ 33 ] ) ; xx [ 192 ] = xx [ 4 ] * ( xx [
181 ] - xx [ 185 ] ) ; xx [ 181 ] = xx [ 213 ] * ( ( ( ( xx [ 186 ] + state [
31 ] * state [ 31 ] ) * xx [ 4 ] - xx [ 28 ] ) * state [ 32 ] - xx [ 192 ] *
state [ 34 ] ) * state [ 34 ] - ( xx [ 192 ] * state [ 33 ] - xx [ 4 ] * ( xx
[ 187 ] + xx [ 194 ] ) * state [ 32 ] ) * state [ 33 ] ) ; xx [ 278 ] = xx [
25 ] - ( xx [ 70 ] + xx [ 124 ] + xx [ 22 ] - xx [ 37 ] ) - xx [ 40 ] - xx [
111 ] * xx [ 46 ] - xx [ 121 ] * xx [ 47 ] - xx [ 73 ] * xx [ 48 ] ; xx [ 279
] = xx [ 49 ] - ( xx [ 125 ] + xx [ 50 ] - xx [ 41 ] ) + xx [ 122 ] * xx [ 24
] - xx [ 44 ] - xx [ 87 ] * xx [ 46 ] - xx [ 78 ] * xx [ 47 ] - xx [ 88 ] *
xx [ 48 ] ; xx [ 280 ] = xx [ 21 ] * xx [ 69 ] - ( xx [ 126 ] + xx [ 38 ] -
xx [ 5 ] ) + xx [ 29 ] - inputDdot [ 0 ] - xx [ 89 ] * xx [ 46 ] - xx [ 77 ]
* xx [ 47 ] - xx [ 71 ] * xx [ 48 ] ; xx [ 281 ] = xx [ 230 ] * xx [ 33 ] - (
xx [ 242 ] * xx [ 63 ] + xx [ 97 ] + xx [ 22 ] - ( xx [ 95 ] + xx [ 95 ] ) )
- xx [ 40 ] - xx [ 154 ] * xx [ 46 ] - xx [ 161 ] * xx [ 47 ] - xx [ 128 ] *
xx [ 48 ] ; xx [ 282 ] = xx [ 244 ] * xx [ 63 ] - ( xx [ 98 ] + xx [ 50 ] - (
xx [ 85 ] + xx [ 85 ] ) ) + xx [ 246 ] * xx [ 33 ] - xx [ 44 ] - xx [ 172 ] *
xx [ 46 ] - xx [ 153 ] * xx [ 47 ] - xx [ 160 ] * xx [ 48 ] ; xx [ 283 ] = xx
[ 231 ] * xx [ 63 ] - ( xx [ 99 ] + xx [ 38 ] - ( xx [ 74 ] + xx [ 74 ] ) ) +
xx [ 228 ] * xx [ 33 ] - inputDdot [ 0 ] - xx [ 162 ] * xx [ 46 ] - xx [ 163
] * xx [ 47 ] - xx [ 151 ] * xx [ 48 ] ; xx [ 284 ] = xx [ 106 ] - ( xx [ 108
] + xx [ 167 ] + xx [ 22 ] - xx [ 117 ] ) - xx [ 40 ] - xx [ 188 ] * xx [ 46
] - xx [ 190 ] * xx [ 47 ] - xx [ 68 ] * xx [ 48 ] ; xx [ 285 ] = xx [ 120 ]
- ( xx [ 168 ] + xx [ 50 ] - xx [ 119 ] ) + xx [ 277 ] * xx [ 81 ] - xx [ 44
] - xx [ 195 ] * xx [ 46 ] - xx [ 86 ] * xx [ 47 ] - xx [ 75 ] * xx [ 48 ] ;
xx [ 286 ] = xx [ 262 ] * xx [ 107 ] - ( xx [ 169 ] + xx [ 38 ] - xx [ 110 ]
) + xx [ 109 ] - inputDdot [ 0 ] - xx [ 191 ] * xx [ 46 ] - xx [ 39 ] * xx [
47 ] - xx [ 80 ] * xx [ 48 ] ; xx [ 287 ] = xx [ 316 ] * xx [ 127 ] - ( xx [
304 ] * xx [ 150 ] + xx [ 37 ] - ( xx [ 171 ] + xx [ 171 ] ) - xx [ 70 ] + xx
[ 25 ] ) ; xx [ 288 ] = xx [ 318 ] * xx [ 150 ] - ( xx [ 41 ] - ( xx [ 165 ]
+ xx [ 165 ] ) + xx [ 49 ] + xx [ 6 ] * xx [ 24 ] ) + xx [ 320 ] * xx [ 127 ]
; xx [ 289 ] = xx [ 301 ] * xx [ 150 ] - ( xx [ 5 ] - ( xx [ 152 ] + xx [ 152
] ) + xx [ 123 ] * xx [ 69 ] + xx [ 29 ] ) + xx [ 305 ] * xx [ 127 ] ; xx [
290 ] = xx [ 325 ] * xx [ 158 ] - ( xx [ 319 ] * xx [ 180 ] + xx [ 117 ] - (
xx [ 193 ] + xx [ 193 ] ) - xx [ 108 ] + xx [ 106 ] ) ; xx [ 291 ] = xx [ 329
] * xx [ 180 ] - ( xx [ 119 ] - ( xx [ 189 ] + xx [ 189 ] ) + xx [ 120 ] + xx
[ 258 ] * xx [ 81 ] ) + xx [ 342 ] * xx [ 158 ] ; xx [ 292 ] = xx [ 217 ] *
xx [ 180 ] - ( xx [ 110 ] - ( xx [ 181 ] + xx [ 181 ] ) + xx [ 209 ] * xx [
107 ] + xx [ 109 ] ) + xx [ 323 ] * xx [ 158 ] ; memcpy ( xx + 686 , xx + 356
, 225 * sizeof ( double ) ) ; factorAndSolveSymmetric ( xx + 686 , 15 , xx +
911 , ii + 0 , xx + 278 , xx + 671 , xx + 926 ) ; xx [ 46 ] = xx [ 3 ] ; xx [
47 ] = xx [ 26 ] * xx [ 681 ] - ( xx [ 136 ] * xx [ 680 ] + xx [ 26 ] * xx [
672 ] - xx [ 136 ] * xx [ 671 ] + xx [ 673 ] * xx [ 21 ] ) + xx [ 123 ] * xx
[ 682 ] - xx [ 34 ] ; xx [ 48 ] = xx [ 135 ] * xx [ 680 ] - ( xx [ 135 ] * xx
[ 671 ] + xx [ 672 ] * xx [ 122 ] + xx [ 20 ] * xx [ 673 ] ) + xx [ 6 ] * xx
[ 681 ] + xx [ 20 ] * xx [ 682 ] - xx [ 23 ] ; solveSymmetricPosDef ( xx + 11
, xx + 46 , 3 , 1 , xx + 3 , xx + 20 ) ; xx [ 11 ] = xx [ 590 ] ; xx [ 12 ] =
xx [ 593 ] ; xx [ 13 ] = xx [ 596 ] ; xx [ 14 ] = state [ 7 ] ; xx [ 15 ] =
state [ 8 ] ; xx [ 16 ] = state [ 9 ] ; xx [ 17 ] = state [ 10 ] ;
pm_math_quatDeriv ( xx + 14 , xx + 173 , xx + 18 ) ; xx [ 14 ] = xx [ 118 ] ;
xx [ 15 ] = - ( xx [ 129 ] + xx [ 318 ] * xx [ 681 ] - xx [ 304 ] * xx [ 680
] + xx [ 682 ] * xx [ 301 ] ) ; xx [ 16 ] = - ( xx [ 134 ] + xx [ 316 ] * xx
[ 680 ] + xx [ 681 ] * xx [ 320 ] + xx [ 305 ] * xx [ 682 ] ) ;
solveSymmetricPosDef ( xx + 306 , xx + 14 , 3 , 1 , xx + 22 , xx + 46 ) ; xx
[ 14 ] = xx [ 644 ] ; xx [ 15 ] = xx [ 647 ] ; xx [ 16 ] = xx [ 650 ] ; xx [
46 ] = state [ 14 ] ; xx [ 47 ] = state [ 15 ] ; xx [ 48 ] = state [ 16 ] ;
xx [ 49 ] = state [ 17 ] ; pm_math_quatDeriv ( xx + 46 , xx + 91 , xx + 106 )
; xx [ 46 ] = xx [ 32 ] ; xx [ 47 ] = - ( xx [ 36 ] + xx [ 244 ] * xx [ 675 ]
- xx [ 242 ] * xx [ 674 ] + xx [ 676 ] * xx [ 231 ] ) ; xx [ 48 ] = - ( xx [
51 ] + xx [ 230 ] * xx [ 674 ] + xx [ 675 ] * xx [ 246 ] + xx [ 228 ] * xx [
676 ] ) ; solveSymmetricPosDef ( xx + 232 , xx + 46 , 3 , 1 , xx + 32 , xx +
36 ) ; xx [ 36 ] = xx [ 608 ] ; xx [ 37 ] = xx [ 611 ] ; xx [ 38 ] = xx [ 614
] ; xx [ 46 ] = state [ 21 ] ; xx [ 47 ] = state [ 22 ] ; xx [ 48 ] = state [
23 ] ; xx [ 49 ] = state [ 24 ] ; pm_math_quatDeriv ( xx + 46 , xx + 103 , xx
+ 117 ) ; xx [ 46 ] = xx [ 79 ] ; xx [ 47 ] = xx [ 275 ] * xx [ 684 ] - ( xx
[ 273 ] * xx [ 683 ] + xx [ 275 ] * xx [ 678 ] - xx [ 273 ] * xx [ 677 ] + xx
[ 679 ] * xx [ 262 ] ) + xx [ 209 ] * xx [ 685 ] - xx [ 94 ] ; xx [ 48 ] = xx
[ 261 ] * xx [ 683 ] - ( xx [ 261 ] * xx [ 677 ] + xx [ 678 ] * xx [ 277 ] +
xx [ 259 ] * xx [ 679 ] ) + xx [ 258 ] * xx [ 684 ] + xx [ 259 ] * xx [ 685 ]
- xx [ 96 ] ; solveSymmetricPosDef ( xx + 263 , xx + 46 , 3 , 1 , xx + 49 ,
xx + 91 ) ; xx [ 46 ] = xx [ 626 ] ; xx [ 47 ] = xx [ 629 ] ; xx [ 48 ] = xx
[ 632 ] ; xx [ 91 ] = state [ 28 ] ; xx [ 92 ] = state [ 29 ] ; xx [ 93 ] =
state [ 30 ] ; xx [ 94 ] = state [ 31 ] ; pm_math_quatDeriv ( xx + 91 , xx +
176 , xx + 95 ) ; xx [ 91 ] = xx [ 159 ] ; xx [ 92 ] = - ( xx [ 170 ] + xx [
329 ] * xx [ 684 ] - xx [ 319 ] * xx [ 683 ] + xx [ 685 ] * xx [ 217 ] ) ; xx
[ 93 ] = - ( xx [ 179 ] + xx [ 325 ] * xx [ 683 ] + xx [ 684 ] * xx [ 342 ] +
xx [ 323 ] * xx [ 685 ] ) ; solveSymmetricPosDef ( xx + 332 , xx + 91 , 3 , 1
, xx + 103 , xx + 122 ) ; xx [ 91 ] = xx [ 662 ] ; xx [ 92 ] = xx [ 665 ] ;
xx [ 93 ] = xx [ 668 ] ; xx [ 122 ] = xx [ 111 ] * xx [ 671 ] + xx [ 87 ] *
xx [ 672 ] + xx [ 89 ] * xx [ 673 ] + xx [ 154 ] * xx [ 674 ] + xx [ 172 ] *
xx [ 675 ] + xx [ 162 ] * xx [ 676 ] + xx [ 188 ] * xx [ 677 ] + xx [ 195 ] *
xx [ 678 ] + xx [ 191 ] * xx [ 679 ] - xx [ 112 ] ; xx [ 123 ] = xx [ 121 ] *
xx [ 671 ] + xx [ 78 ] * xx [ 672 ] + xx [ 77 ] * xx [ 673 ] + xx [ 161 ] *
xx [ 674 ] + xx [ 153 ] * xx [ 675 ] + xx [ 163 ] * xx [ 676 ] + xx [ 190 ] *
xx [ 677 ] + xx [ 86 ] * xx [ 678 ] + xx [ 39 ] * xx [ 679 ] - xx [ 113 ] ;
xx [ 124 ] = xx [ 73 ] * xx [ 671 ] + xx [ 88 ] * xx [ 672 ] + xx [ 673 ] *
xx [ 71 ] + xx [ 128 ] * xx [ 674 ] + xx [ 160 ] * xx [ 675 ] + xx [ 676 ] *
xx [ 151 ] + xx [ 68 ] * xx [ 677 ] + xx [ 75 ] * xx [ 678 ] + xx [ 679 ] *
xx [ 80 ] - xx [ 166 ] ; solveSymmetricPosDef ( xx + 54 , xx + 122 , 3 , 1 ,
xx + 39 , xx + 68 ) ; xx [ 54 ] = xx [ 72 ] + xx [ 52 ] * xx [ 40 ] ; xx [ 55
] = xx [ 90 ] - xx [ 52 ] * xx [ 39 ] ; xx [ 56 ] = xx [ 116 ] ;
pm_math_quatXform ( xx + 130 , xx + 54 , xx + 57 ) ; xx [ 25 ] = xx [ 671 ] +
xx [ 674 ] + xx [ 677 ] - ( xx [ 57 ] + xx [ 27 ] ) ; xx [ 26 ] = xx [ 672 ]
+ xx [ 675 ] + xx [ 678 ] - ( xx [ 58 ] + xx [ 42 ] ) ; solveSymmetricPosDef
( xx + 64 , xx + 25 , 2 , 1 , xx + 27 , xx + 54 ) ; xx [ 6 ] = xx [ 27 ] - xx
[ 35 ] ; xx [ 17 ] = xx [ 28 ] - xx [ 43 ] ; pm_math_quatDeriv ( xx + 130 ,
xx + 143 , xx + 25 ) ; xx [ 42 ] = xx [ 6 ] ; xx [ 43 ] = xx [ 17 ] ; xx [ 44
] = xx [ 45 ] ; pm_math_quatInverseXform ( xx + 130 , xx + 42 , xx + 54 ) ;
deriv [ 0 ] = xx [ 7 ] ; deriv [ 1 ] = xx [ 8 ] ; deriv [ 2 ] = xx [ 9 ] ;
deriv [ 3 ] = xx [ 10 ] ; deriv [ 4 ] = xx [ 3 ] - pm_math_dot3 ( xx + 11 ,
xx + 140 ) ; deriv [ 5 ] = xx [ 4 ] - xx [ 31 ] ; deriv [ 6 ] = xx [ 5 ] - xx
[ 2 ] ; deriv [ 7 ] = xx [ 18 ] ; deriv [ 8 ] = xx [ 19 ] ; deriv [ 9 ] = xx
[ 20 ] ; deriv [ 10 ] = xx [ 21 ] ; deriv [ 11 ] = xx [ 22 ] - pm_math_dot3 (
xx + 14 , xx + 182 ) ; deriv [ 12 ] = xx [ 23 ] - xx [ 146 ] ; deriv [ 13 ] =
xx [ 24 ] - xx [ 115 ] ; deriv [ 14 ] = xx [ 106 ] ; deriv [ 15 ] = xx [ 107
] ; deriv [ 16 ] = xx [ 108 ] ; deriv [ 17 ] = xx [ 109 ] ; deriv [ 18 ] = xx
[ 32 ] - pm_math_dot3 ( xx + 36 , xx + 100 ) ; deriv [ 19 ] = xx [ 33 ] - xx
[ 53 ] ; deriv [ 20 ] = xx [ 34 ] - xx [ 30 ] ; deriv [ 21 ] = xx [ 117 ] ;
deriv [ 22 ] = xx [ 118 ] ; deriv [ 23 ] = xx [ 119 ] ; deriv [ 24 ] = xx [
120 ] ; deriv [ 25 ] = xx [ 49 ] - pm_math_dot3 ( xx + 46 , xx + 155 ) ;
deriv [ 26 ] = xx [ 50 ] - xx [ 114 ] ; deriv [ 27 ] = xx [ 51 ] - xx [ 76 ]
; deriv [ 28 ] = xx [ 95 ] ; deriv [ 29 ] = xx [ 96 ] ; deriv [ 30 ] = xx [
97 ] ; deriv [ 31 ] = xx [ 98 ] ; deriv [ 32 ] = xx [ 103 ] - pm_math_dot3 (
xx + 91 , xx + 196 ) ; deriv [ 33 ] = xx [ 104 ] - xx [ 164 ] ; deriv [ 34 ]
= xx [ 105 ] - xx [ 0 ] ; deriv [ 35 ] = state [ 37 ] ; deriv [ 36 ] = state
[ 38 ] ; deriv [ 37 ] = xx [ 6 ] ; deriv [ 38 ] = xx [ 17 ] ; deriv [ 39 ] =
xx [ 25 ] ; deriv [ 40 ] = xx [ 26 ] ; deriv [ 41 ] = xx [ 27 ] ; deriv [ 42
] = xx [ 28 ] ; deriv [ 43 ] = xx [ 39 ] - pm_math_dot3 ( xx + 137 , xx + 54
) ; deriv [ 44 ] = xx [ 40 ] - pm_math_dot3 ( xx + 147 , xx + 54 ) ; deriv [
45 ] = xx [ 41 ] - pm_math_dot3 ( xx + 82 , xx + 54 ) ; errorResult [ 0 ] =
xx [ 1 ] ; return NULL ; }
