#include "__cf_Kinematics_Model.h"
#include "rtw_capi.h"
#ifdef HOST_CAPI_BUILD
#include "Kinematics_Model_capi_host.h"
#define sizeof(s) ((size_t)(0xFFFF))
#undef rt_offsetof
#define rt_offsetof(s,el) ((uint16_T)(0xFFFF))
#define TARGET_CONST
#define TARGET_STRING(s) (s)    
#else
#include "builtin_typeid_types.h"
#include "Kinematics_Model.h"
#include "Kinematics_Model_capi.h"
#include "Kinematics_Model_private.h"
#ifdef LIGHT_WEIGHT_CAPI
#define TARGET_CONST                  
#define TARGET_STRING(s)               (NULL)                    
#else
#define TARGET_CONST                   const
#define TARGET_STRING(s)               (s)
#endif
#endif
static const rtwCAPI_Signals rtBlockSignals [ ] = { { 0 , 1 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/Steering_properties" ) ,
TARGET_STRING ( "Caster" ) , 0 , 0 , 0 , 0 , 0 } , { 1 , 1 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/Steering_properties" ) ,
TARGET_STRING ( "Mechanical Trail" ) , 1 , 0 , 0 , 0 , 0 } , { 2 , 1 ,
TARGET_STRING ( "Kinematics_Model/Actuation and Logging/Steering_properties"
) , TARGET_STRING ( "Kingpin Inclination" ) , 2 , 0 , 0 , 0 , 0 } , { 3 , 1 ,
TARGET_STRING ( "Kinematics_Model/Actuation and Logging/Steering_properties"
) , TARGET_STRING ( "Scrub Radius" ) , 3 , 0 , 0 , 0 , 0 } , { 4 , 0 ,
TARGET_STRING ( "Kinematics_Model/Actuation and Logging/Rad to Deg1" ) ,
TARGET_STRING ( "Tyre Rotation Angles" ) , 0 , 0 , 1 , 0 , 0 } , { 5 , 0 ,
TARGET_STRING ( "Kinematics_Model/Ramp/Product" ) , TARGET_STRING ( "" ) , 0
, 0 , 0 , 0 , 0 } , { 6 , 0 , TARGET_STRING ( "Kinematics_Model/Ramp/Step" )
, TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 1 } , { 7 , 0 , TARGET_STRING (
"Kinematics_Model/Ramp/Output" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 }
, { 8 , 0 , TARGET_STRING ( "Kinematics_Model/Ramp/Sum" ) , TARGET_STRING (
"" ) , 0 , 0 , 0 , 0 , 0 } , { 9 , 0 , TARGET_STRING (
"Kinematics_Model/Solver Configuration/EVAL_KEY/INPUT_1_1_1" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 2 , 0 , 0 } , { 10 , 0 , TARGET_STRING (
"Kinematics_Model/Solver Configuration/EVAL_KEY/OUTPUT_1_0" ) , TARGET_STRING
( "" ) , 0 , 0 , 3 , 0 , 0 } , { 11 , 0 , TARGET_STRING (
"Kinematics_Model/Solver Configuration/EVAL_KEY/STATE_1" ) , TARGET_STRING (
"" ) , 0 , 0 , 4 , 0 , 0 } , { 12 , 0 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/contact_patch_x/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 13 , 0 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/contact_patch_y/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 14 , 0 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/contact_patch_z/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 15 , 0 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/lwb_x/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 16 , 0 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/lwb_y/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 17 , 0 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/lwb_z/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 18 , 0 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/tr_x/EVAL_KEY/GAIN" ) , TARGET_STRING
( "" ) , 0 , 0 , 0 , 0 , 0 } , { 19 , 0 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/tr_y/EVAL_KEY/GAIN" ) , TARGET_STRING
( "" ) , 0 , 0 , 0 , 0 , 0 } , { 20 , 0 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/tr_z/EVAL_KEY/GAIN" ) , TARGET_STRING
( "" ) , 0 , 0 , 0 , 0 , 0 } , { 21 , 0 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/uwb_x/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 22 , 0 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/uwb_y/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 23 , 0 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/uwb_z/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 0 , 0 , ( NULL ) , ( NULL ) ,
0 , 0 , 0 , 0 , 0 } } ; static const rtwCAPI_BlockParameters
rtBlockParameters [ ] = { { 24 , TARGET_STRING ( "Kinematics_Model/Ramp" ) ,
TARGET_STRING ( "slope" ) , 0 , 0 , 0 } , { 25 , TARGET_STRING (
"Kinematics_Model/Ramp" ) , TARGET_STRING ( "start" ) , 0 , 0 , 0 } , { 26 ,
TARGET_STRING ( "Kinematics_Model/Ramp" ) , TARGET_STRING ( "InitialOutput" )
, 0 , 0 , 0 } , { 27 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/Rad to Deg1" ) , TARGET_STRING (
"Gain" ) , 0 , 0 , 0 } , { 28 , TARGET_STRING ( "Kinematics_Model/Ramp/Step"
) , TARGET_STRING ( "Before" ) , 0 , 0 , 0 } , { 29 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/contact_patch_x/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 30 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/contact_patch_y/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 31 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/contact_patch_z/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 32 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/lwb_x/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 33 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/lwb_y/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 34 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/lwb_z/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 35 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/tr_x/EVAL_KEY/GAIN" ) , TARGET_STRING
( "Gain" ) , 0 , 0 , 0 } , { 36 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/tr_y/EVAL_KEY/GAIN" ) , TARGET_STRING
( "Gain" ) , 0 , 0 , 0 } , { 37 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/tr_z/EVAL_KEY/GAIN" ) , TARGET_STRING
( "Gain" ) , 0 , 0 , 0 } , { 38 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/uwb_x/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 39 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/uwb_y/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 40 , TARGET_STRING (
"Kinematics_Model/Actuation and Logging/uwb_z/EVAL_KEY/GAIN" ) ,
TARGET_STRING ( "Gain" ) , 0 , 0 , 0 } , { 0 , ( NULL ) , ( NULL ) , 0 , 0 ,
0 } } ; static const rtwCAPI_ModelParameters rtModelParameters [ ] = { { 0 ,
( NULL ) , 0 , 0 , 0 } } ;
#ifndef HOST_CAPI_BUILD
static void * rtDataAddrMap [ ] = { & rtB . mlyhvtju52 , & rtB . nbxx2m2i4y ,
& rtB . l1y0dfbwhu , & rtB . jhd0dnnqdb , & rtB . lm30xe5jws [ 0 ] , & rtB .
j4ni2uuhra , & rtB . gv3giy2db5 , & rtB . eiuokjsxp3 , & rtB . obltvipdot , &
rtB . iddoisgbzq [ 0 ] , & rtB . fu5va5q0fk [ 0 ] , & rtB . i2vms01m1k [ 0 ]
, & rtB . dhnxzb0mjy , & rtB . hfor1olrf3 , & rtB . mx4i5itgxl , & rtB .
b5eq3qyadt , & rtB . a3n000o3dc , & rtB . nemcj5dj2s , & rtB . esthmbhcld , &
rtB . n3xnawh3kp , & rtB . gbcq0debgs , & rtB . lwjktixzcr , & rtB .
dhtriljxim , & rtB . fwm0oglrrd , & rtP . Ramp_slope , & rtP . Ramp_start , &
rtP . Ramp_InitialOutput , & rtP . RadtoDeg1_Gain , & rtP . Step_Y0 , & rtP .
GAIN_Gain , & rtP . GAIN_Gain_pbdfkn5gz3 , & rtP . GAIN_Gain_lywuarbb30 , &
rtP . GAIN_Gain_bsdtfq1oje , & rtP . GAIN_Gain_m2vt0o0ref , & rtP .
GAIN_Gain_oyqy0mqpvg , & rtP . GAIN_Gain_ej1b40oukw , & rtP .
GAIN_Gain_dntmztrkvr , & rtP . GAIN_Gain_lfuqkyc0tg , & rtP .
GAIN_Gain_gxcz5voktz , & rtP . GAIN_Gain_jvq3gsrwwi , & rtP .
GAIN_Gain_ctvvappo4m , } ; static int32_T * rtVarDimsAddrMap [ ] = { ( NULL )
} ;
#endif
static TARGET_CONST rtwCAPI_DataTypeMap rtDataTypeMap [ ] = { { "double" ,
"real_T" , 0 , 0 , sizeof ( real_T ) , SS_DOUBLE , 0 , 0 } } ;
#ifdef HOST_CAPI_BUILD
#undef sizeof
#endif
static TARGET_CONST rtwCAPI_ElementMap rtElementMap [ ] = { { ( NULL ) , 0 ,
0 , 0 , 0 } , } ; static const rtwCAPI_DimensionMap rtDimensionMap [ ] = { {
rtwCAPI_SCALAR , 0 , 2 , 0 } , { rtwCAPI_VECTOR , 2 , 2 , 0 } , {
rtwCAPI_VECTOR , 4 , 2 , 0 } , { rtwCAPI_VECTOR , 6 , 2 , 0 } , {
rtwCAPI_VECTOR , 8 , 2 , 0 } } ; static const uint_T rtDimensionArray [ ] = {
1 , 1 , 3 , 1 , 4 , 1 , 19 , 1 , 46 , 1 } ; static const real_T
rtcapiStoredFloats [ ] = { 0.0 , 1.0 } ; static const rtwCAPI_FixPtMap
rtFixPtMap [ ] = { { ( NULL ) , ( NULL ) , rtwCAPI_FIX_RESERVED , 0 , 0 , 0 }
, } ; static const rtwCAPI_SampleTimeMap rtSampleTimeMap [ ] = { { ( const
void * ) & rtcapiStoredFloats [ 0 ] , ( const void * ) & rtcapiStoredFloats [
0 ] , 0 , 0 } , { ( const void * ) & rtcapiStoredFloats [ 0 ] , ( const void
* ) & rtcapiStoredFloats [ 1 ] , 1 , 0 } } ; static
rtwCAPI_ModelMappingStaticInfo mmiStatic = { { rtBlockSignals , 24 , ( NULL )
, 0 , ( NULL ) , 0 } , { rtBlockParameters , 17 , rtModelParameters , 0 } , {
( NULL ) , 0 } , { rtDataTypeMap , rtDimensionMap , rtFixPtMap , rtElementMap
, rtSampleTimeMap , rtDimensionArray } , "float" , { 3167744575U ,
4044152898U , 1789352682U , 1305306456U } , ( NULL ) , 0 , 0 } ; const
rtwCAPI_ModelMappingStaticInfo * Kinematics_Model_GetCAPIStaticMap ( void ) {
return & mmiStatic ; }
#ifndef HOST_CAPI_BUILD
void Kinematics_Model_InitializeDataMapInfo ( void ) { rtwCAPI_SetVersion ( (
* rt_dataMapInfoPtr ) . mmi , 1 ) ; rtwCAPI_SetStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , & mmiStatic ) ; rtwCAPI_SetLoggingStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ; rtwCAPI_SetDataAddressMap ( ( *
rt_dataMapInfoPtr ) . mmi , rtDataAddrMap ) ; rtwCAPI_SetVarDimsAddressMap (
( * rt_dataMapInfoPtr ) . mmi , rtVarDimsAddrMap ) ;
rtwCAPI_SetInstanceLoggingInfo ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArray ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( ( * rt_dataMapInfoPtr ) . mmi , 0 ) ; }
#else
#ifdef __cplusplus
extern "C" {
#endif
void Kinematics_Model_host_InitializeDataMapInfo (
Kinematics_Model_host_DataMapInfo_T * dataMap , const char * path ) {
rtwCAPI_SetVersion ( dataMap -> mmi , 1 ) ; rtwCAPI_SetStaticMap ( dataMap ->
mmi , & mmiStatic ) ; rtwCAPI_SetDataAddressMap ( dataMap -> mmi , NULL ) ;
rtwCAPI_SetVarDimsAddressMap ( dataMap -> mmi , NULL ) ; rtwCAPI_SetPath (
dataMap -> mmi , path ) ; rtwCAPI_SetFullPath ( dataMap -> mmi , NULL ) ;
rtwCAPI_SetChildMMIArray ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( dataMap -> mmi , 0 ) ; }
#ifdef __cplusplus
}
#endif
#endif
