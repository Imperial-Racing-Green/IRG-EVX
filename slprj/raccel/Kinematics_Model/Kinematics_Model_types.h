#include "__cf_Kinematics_Model.h"
#ifndef RTW_HEADER_Kinematics_Model_types_h_
#define RTW_HEADER_Kinematics_Model_types_h_
#include "rtwtypes.h"
#include "builtin_typeid_types.h"
#include "multiword_types.h"
#ifndef DEFINED_TYPEDEF_FOR_struct_jnm3nKe1zCqNxz8d5g4aYD_
#define DEFINED_TYPEDEF_FOR_struct_jnm3nKe1zCqNxz8d5g4aYD_
typedef struct { real_T front [ 3 ] ; real_T rear [ 3 ] ; real_T outer [ 3 ]
; } struct_jnm3nKe1zCqNxz8d5g4aYD ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_JkOmF3rp8e5kmqVxAYiL6B_
#define DEFINED_TYPEDEF_FOR_struct_JkOmF3rp8e5kmqVxAYiL6B_
typedef struct { real_T inner [ 3 ] ; real_T outer [ 3 ] ; }
struct_JkOmF3rp8e5kmqVxAYiL6B ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_4ncDlrYzZI0lVcpxpUdoSE_
#define DEFINED_TYPEDEF_FOR_struct_4ncDlrYzZI0lVcpxpUdoSE_
typedef struct { real_T rocker_pivot [ 3 ] ; real_T rocker_to_damper [ 3 ] ;
real_T roll_damper_left [ 3 ] ; real_T damper_to_chassis [ 3 ] ; }
struct_4ncDlrYzZI0lVcpxpUdoSE ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_O2dp4OCq4deHLI0Nf8BMvB_
#define DEFINED_TYPEDEF_FOR_struct_O2dp4OCq4deHLI0Nf8BMvB_
typedef struct { real_T tyre_diameter ; real_T centre [ 3 ] ; }
struct_O2dp4OCq4deHLI0Nf8BMvB ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_bJGB0GEx7BY895OBDtLwEH_
#define DEFINED_TYPEDEF_FOR_struct_bJGB0GEx7BY895OBDtLwEH_
typedef struct { struct_jnm3nKe1zCqNxz8d5g4aYD lwb ;
struct_jnm3nKe1zCqNxz8d5g4aYD uwb ; struct_JkOmF3rp8e5kmqVxAYiL6B tr ;
struct_JkOmF3rp8e5kmqVxAYiL6B pr ; struct_4ncDlrYzZI0lVcpxpUdoSE inboard ;
struct_O2dp4OCq4deHLI0Nf8BMvB wheel ; } struct_bJGB0GEx7BY895OBDtLwEH ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_8O8gkDatb7WHrBvw8QqUhD_
#define DEFINED_TYPEDEF_FOR_struct_8O8gkDatb7WHrBvw8QqUhD_
typedef struct { real_T uwb_f [ 3 ] ; real_T uwb_f_length ; real_T uwb_r [ 3
] ; real_T uwb_r_length ; real_T uwb_initial_angle ; real_T lwb_f [ 3 ] ;
real_T lwb_f_length ; real_T lwb_r [ 3 ] ; real_T lwb_r_length ; real_T
outboard_offset_uwb [ 3 ] ; real_T outboard_offset_lwb [ 3 ] ; real_T
outboard_offset_tr [ 3 ] ; real_T tr_length ; real_T tr_inner_x [ 3 ] ;
real_T pr_length ; real_T pr_inner_x [ 3 ] ; real_T pr_outer_offset ; real_T
rocker_pivot [ 3 ] ; real_T rocker_pr_offset [ 3 ] ; real_T
rocker_damper_offset [ 3 ] ; real_T damper_to_chassis [ 3 ] ; }
struct_8O8gkDatb7WHrBvw8QqUhD ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_nb2A6t1RzPfxYIfVrhHl4G_
#define DEFINED_TYPEDEF_FOR_struct_nb2A6t1RzPfxYIfVrhHl4G_
typedef struct { real_T tyre_diameter ; real_T tyre_width ; real_T y_pos ; }
struct_nb2A6t1RzPfxYIfVrhHl4G ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_ef4l45YSpHi317IqDHL4rB_
#define DEFINED_TYPEDEF_FOR_struct_ef4l45YSpHi317IqDHL4rB_
typedef struct { real_T size [ 3 ] ; } struct_ef4l45YSpHi317IqDHL4rB ;
#endif
#ifndef DEFINED_TYPEDEF_FOR_struct_9QAbP06y5ODT3wbf3H9CMF_
#define DEFINED_TYPEDEF_FOR_struct_9QAbP06y5ODT3wbf3H9CMF_
typedef struct { struct_bJGB0GEx7BY895OBDtLwEH hardpoints_front ;
struct_8O8gkDatb7WHrBvw8QqUhD susp_geometry ; struct_nb2A6t1RzPfxYIfVrhHl4G
wheel_geometry ; struct_ef4l45YSpHi317IqDHL4rB chassis_geometry ; }
struct_9QAbP06y5ODT3wbf3H9CMF ;
#endif
typedef struct P_ P ;
#endif
