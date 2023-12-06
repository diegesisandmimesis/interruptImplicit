#charset "us-ascii"
//
// sample.t
// Version 1.0
// Copyright 2022 Diegesis & Mimesis
//
// This is a very simple demonstration "game" for the interruptImplicit library.
//
// It can be compiled via the included makefile with
//
//	# t3make -f makefile.t3m
//
// ...or the equivalent, depending on what TADS development environment
// you're using.
//
// This "game" is distributed under the MIT License, see LICENSE.txt
// for details.
//
#include <adv3.h>
#include <en_us.h>

#include "interruptImplicit.h"

versionInfo: GameID
        name = 'interruptImplicit Library Demo Game'
        byline = 'Diegesis & Mimesis'
        desc = 'Demo game for the interruptImplicit library. '
        version = '1.0'
        IFID = '12345'
	showAbout() {
		"This is a simple test game that demonstrates the features
		of the interruptImplicit library.
		<.p>
		Consult the README.txt document distributed with the library
		source for a quick summary of how to use the library in your
		own games.
		<.p>
		The library source is also extensively commented in a way
		intended to make it as readable as possible. ";
	}
;

startRoom: Room 'Void'
	"This is a featureless void with a bed.  There's a room to the north. "
	north = otherRoom
;
+bed: OutOfReach, Bed, Heavy 'bed' 'bed'
	"It's a bed that resists implicit actions. "

	canReachSelfFromInside(obj) { return(true); }
	canObjReachContents(obj) { return(true); }
	cannotGoThatWay() {
		"You can\'t go anywhere until you get out of bed. ";
	}
	dobjFor(GetOutOf) {
		action() {
			inherited();
			_getOutOfBed();
		}
	}
	makeStandingUp() {
		inherited();
		_getOutOfBed();
	}
	_getOutOfBed() {
		//if(gAction.isImplicit) {
			//gInterruptImplicit;
		if(gInterruptImplicit == true) {
			"After you stand up you pause to reflect upon
				the interruption of implicit actions. ";
		}
	}
;

otherRoom: Room 'Other Room'
	"This room exists just so you can exit the void to the south. "
	south = startRoom
;

me: Person;

gameMain: GameMainDef
	initialPlayerChar = me
	newGame() {
		// Summarize the point of the demo
		"This demo provides a bed that interrupts implicit actions
			when trying to leave it.
		<.p>
		This means that if you try to go <b>&gt;NORTH</b> from the
		starting position (lying in bed), you will stand up but
		you will not move into the other room.
		<.p> ";

		// Put the player in bed, lying down.
		gPlayerChar.moveInto(bed);
		gPlayerChar.makePosture(bed.defaultPosture);

		// Run the game normally.
		runGame(true);
	}
;
