#include "__cf_Kinematics_Model.h"
#ifndef RTW_HEADER_Kinematics_Model_h_
#define RTW_HEADER_Kinematics_Model_h_
#include <stddef.h>
#include <string.h>
#include "rtw_modelmap.h"
#ifndef Kinematics_Model_COMMON_INCLUDES_
#define Kinematics_Model_COMMON_INCLUDES_
#include <stdlib.h>
#include "rtwtypes.h"
#include "simtarget/slSimTgtSigstreamRTW.h"
#include "simtarget/slSimTgtSlioCoreRTW.h"
#include "simtarget/slSimTgtSlioClientsRTW.h"
#include "simtarget/slSimTgtSlioSdiRTW.h"
#include "sigstream_rtw.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "raccel.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "rt_logging.h"
#include "dt_info.h"
#include "ext_work.h"
#include "nesl_rtw.h"
#include "Kinematics_Model_2b2b31c2_1_gateway.h"
#endif
#include "Kinematics_Model_types.h"
#include "multiword_types.h"
#include "mwmathutil.h"
#include "rt_defines.h"
#include "rtGetInf.h"
#include "rt_nonfinite.h"
#define MODEL_NAME Kinematics_Model
#define NSAMPLE_TIMES (3) 
#define NINPUTS (0)       
#define NOUTPUTS (0)     
#define NBLOCKIO (24) 
#define NUM_ZC_EVENTS (0) 
#ifndef NCSTATES
#define NCSTATES (46)   
#elif NCSTATES != 46
#error Invalid specification of NCSTATES defined in compiler command
#endif
#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm) (*rt_dataMapInfoPtr)
#endif
#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val) (rt_dataMapInfoPtr = &val)
#endif
#ifndef IN_RACCEL_MAIN
#endif
typedef struct { real_T gv3giy2db5 ; real_T obltvipdot ; real_T j4ni2uuhra ;
real_T eiuokjsxp3 ; real_T iddoisgbzq [ 4 ] ; real_T i2vms01m1k [ 46 ] ;
real_T fu5va5q0fk [ 19 ] ; real_T lm30xe5jws [ 3 ] ; real_T dhnxzb0mjy ;
real_T hfor1olrf3 ; real_T mx4i5itgxl ; real_T lwjktixzcr ; real_T dhtriljxim
; real_T fwm0oglrrd ; real_T b5eq3qyadt ; real_T a3n000o3dc ; real_T
nemcj5dj2s ; real_T esthmbhcld ; real_T n3xnawh3kp ; real_T gbcq0debgs ;
real_T mlyhvtju52 ; real_T nbxx2m2i4y ; real_T l1y0dfbwhu ; real_T jhd0dnnqdb
; } B ; typedef struct { real_T leypwq55mm [ 2 ] ; void * o1x35mltkr ; void *
cj1ktnc3lk ; void * cqqyhb1oov ; void * mz1plpr24i ; void * a2bgirorsb ; void
* kcpierl52s ; void * kkuw4oox5d ; void * la5twx144j ; void * bedbs44pc1 ;
void * dllu231oho ; void * fbf1qtaa52 ; void * k1hko11ult ; struct { void *
LoggedData [ 5 ] ; } ai2nswjotc ; void * czk3aux3gc ; void * dg4jyzaqke ;
void * c5qcnswpih ; void * fh2bdrygks ; void * lqchjcnzw3 ; void * f1xhgl3hd5
; int_T kppix1b1tk ; int8_T kkswumubfz ; boolean_T ca50zftymv ; boolean_T
dn3uhriwly ; boolean_T jamvm1i2v5 ; } DW ; typedef struct { real_T jydnphmpzk
[ 46 ] ; } X ; typedef struct { real_T jydnphmpzk [ 46 ] ; } XDot ; typedef
struct { boolean_T jydnphmpzk [ 46 ] ; } XDis ; typedef struct { real_T
jydnphmpzk [ 46 ] ; } CStateAbsTol ; typedef struct { real_T ms1pj0u25v ; }
ZCV ; typedef struct { rtwCAPI_ModelMappingInfo mmi ; } DataMapInfo ; struct
P_ { real_T Ramp_InitialOutput ; real_T Ramp_slope ; real_T Ramp_start ;
real_T Step_Y0 ; real_T RadtoDeg1_Gain ; real_T GAIN_Gain ; real_T
GAIN_Gain_pbdfkn5gz3 ; real_T GAIN_Gain_lywuarbb30 ; real_T
GAIN_Gain_gxcz5voktz ; real_T GAIN_Gain_jvq3gsrwwi ; real_T
GAIN_Gain_ctvvappo4m ; real_T GAIN_Gain_bsdtfq1oje ; real_T
GAIN_Gain_m2vt0o0ref ; real_T GAIN_Gain_oyqy0mqpvg ; real_T
GAIN_Gain_ej1b40oukw ; real_T GAIN_Gain_dntmztrkvr ; real_T
GAIN_Gain_lfuqkyc0tg ; } ; extern const char * RT_MEMORY_ALLOCATION_ERROR ;
extern B rtB ; extern X rtX ; extern DW rtDW ; extern P rtP ; extern const
rtwCAPI_ModelMappingStaticInfo * Kinematics_Model_GetCAPIStaticMap ( void ) ;
extern SimStruct * const rtS ; extern const int_T gblNumToFiles ; extern
const int_T gblNumFrFiles ; extern const int_T gblNumFrWksBlocks ; extern
rtInportTUtable * gblInportTUtables ; extern const char * gblInportFileName ;
extern const int_T gblNumRootInportBlks ; extern const int_T
gblNumModelInputs ; extern const int_T gblInportDataTypeIdx [ ] ; extern
const int_T gblInportDims [ ] ; extern const int_T gblInportComplex [ ] ;
extern const int_T gblInportInterpoFlag [ ] ; extern const int_T
gblInportContinuous [ ] ; extern const int_T gblParameterTuningTid ; extern
DataMapInfo * rt_dataMapInfoPtr ; extern rtwCAPI_ModelMappingInfo *
rt_modelMapInfoPtr ; void MdlOutputs ( int_T tid ) ; void
MdlOutputsParameterSampleTime ( int_T tid ) ; void MdlUpdate ( int_T tid ) ;
void MdlTerminate ( void ) ; void MdlInitializeSizes ( void ) ; void
MdlInitializeSampleTimes ( void ) ; SimStruct * raccel_register_model ( void
) ;
#endif
