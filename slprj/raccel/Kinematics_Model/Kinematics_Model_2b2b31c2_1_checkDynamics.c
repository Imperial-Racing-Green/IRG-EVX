#include "__cf_Kinematics_Model.h"
#include <math.h>
#include <string.h>
#include "pm_std.h"
#include "sm_std.h"
#include "ne_std.h"
#include "ne_dae.h"
#include "sm_ssci_run_time_errors.h"
PmfMessageId Kinematics_Model_2b2b31c2_1_checkDynamics ( const double * rtdv
, const double * state , const double * input , const double * inputDot ,
const double * inputDdot , const double * discreteState , double * result ,
NeuDiagnosticManager * neDiagMgr ) { ( void ) rtdv ; ( void ) state ; ( void
) input ; ( void ) inputDot ; ( void ) inputDdot ; ( void ) discreteState ; (
void ) neDiagMgr ; result [ 0 ] = 0.0 ; return NULL ; }
