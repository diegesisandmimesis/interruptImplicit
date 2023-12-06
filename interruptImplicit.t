#charset "us-ascii"
//
// interruptImplicit.t
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
			return;
		gAction.callAfterActionMain(self);
	}
	afterActionMain() {
		exit;
	}
;
