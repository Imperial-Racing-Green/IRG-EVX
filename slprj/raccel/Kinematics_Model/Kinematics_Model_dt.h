#include "__cf_Kinematics_Model.h"
#include "ext_types.h"
static uint_T rtDataTypeSizes [ ] = { sizeof ( real_T ) , sizeof ( real32_T )
, sizeof ( int8_T ) , sizeof ( uint8_T ) , sizeof ( int16_T ) , sizeof (
uint16_T ) , sizeof ( int32_T ) , sizeof ( uint32_T ) , sizeof ( boolean_T )
, sizeof ( fcn_call_T ) , sizeof ( int_T ) , sizeof ( pointer_T ) , sizeof (
action_T ) , 2 * sizeof ( uint32_T ) , sizeof ( struct_jnm3nKe1zCqNxz8d5g4aYD
) , sizeof ( struct_JkOmF3rp8e5kmqVxAYiL6B ) , sizeof (
struct_4ncDlrYzZI0lVcpxpUdoSE ) , sizeof ( struct_O2dp4OCq4deHLI0Nf8BMvB ) ,
sizeof ( struct_bJGB0GEx7BY895OBDtLwEH ) , sizeof (
struct_8O8gkDatb7WHrBvw8QqUhD ) , sizeof ( struct_nb2A6t1RzPfxYIfVrhHl4G ) ,
sizeof ( struct_ef4l45YSpHi317IqDHL4rB ) , sizeof (
struct_9QAbP06y5ODT3wbf3H9CMF ) } ; static const char_T * rtDataTypeNames [ ]
= { "real_T" , "real32_T" , "int8_T" , "uint8_T" , "int16_T" , "uint16_T" ,
"int32_T" , "uint32_T" , "boolean_T" , "fcn_call_T" , "int_T" , "pointer_T" ,
"action_T" , "timer_uint32_pair_T" , "struct_jnm3nKe1zCqNxz8d5g4aYD" ,
"struct_JkOmF3rp8e5kmqVxAYiL6B" , "struct_4ncDlrYzZI0lVcpxpUdoSE" ,
"struct_O2dp4OCq4deHLI0Nf8BMvB" , "struct_bJGB0GEx7BY895OBDtLwEH" ,
"struct_8O8gkDatb7WHrBvw8QqUhD" , "struct_nb2A6t1RzPfxYIfVrhHl4G" ,
"struct_ef4l45YSpHi317IqDHL4rB" , "struct_9QAbP06y5ODT3wbf3H9CMF" } ; static
DataTypeTransition rtBTransitions [ ] = { { ( char_T * ) ( & rtB . gv3giy2db5
) , 0 , 0 , 92 } , { ( char_T * ) ( & rtDW . leypwq55mm [ 0 ] ) , 0 , 0 , 2 }
, { ( char_T * ) ( & rtDW . o1x35mltkr ) , 11 , 0 , 23 } , { ( char_T * ) ( &
rtDW . kppix1b1tk ) , 10 , 0 , 1 } , { ( char_T * ) ( & rtDW . kkswumubfz ) ,
2 , 0 , 1 } , { ( char_T * ) ( & rtDW . ca50zftymv ) , 8 , 0 , 3 } } ; static
DataTypeTransitionTable rtBTransTable = { 6U , rtBTransitions } ; static
DataTypeTransition rtPTransitions [ ] = { { ( char_T * ) ( & rtP .
Ramp_InitialOutput ) , 0 , 0 , 17 } } ; static DataTypeTransitionTable
rtPTransTable = { 1U , rtPTransitions } ;
