#charset "us-ascii"
//
// interruptImplicit.t
//
//	A TADS3 module providing a convenient way to interrupt implicit
//	actions.
//
// USAGE
//
//	Use the gInterruptImplicit macro to interrupt an implicit action.
//	The return value is true on success, nil if the current action
//	is not an implicit action.
//
//		if(gInterruptImplicit == true) {
//			"Implicit action interrupted. ";
//		}
//
#include <adv3.h>
#include <en_us.h>

#include "interruptImplicit.h"

// Module ID for the library
interruptImplicitModuleID: ModuleID {
        name = 'Interrupt Implicit Library'
        byline = 'Diegesis & Mimesis'
        version = '1.0'
        listingOrder = 99
}

// Utility object for interrupting implicit actions.
interruptImplicitHandler: object
	interruptImplicitAction() {
		if(!gAction.isImplicit)
			return(nil);
		gAction.callAfterActionMain(self);
		return(true);
	}
	afterActionMain() {
		exit;
	}
;
