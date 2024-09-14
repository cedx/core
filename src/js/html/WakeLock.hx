package js.html;

import js.lib.Promise;

/** Prevents device screens from dimming or locking when an application needs to keep running. **/
@:native("WakeLock")
extern class WakeLock {

	/** Returns a sentinel object, which allows control over screen dimming and locking. **/
	function request(?type: WakeLockType): Promise<WakeLockSentinel>;
}

/** Provides a handle to the underlying platform wake lock. **/
@:native("WakeLockSentinel")
extern class WakeLockSentinel extends EventTarget {

	/** Value indicating whether this sentinel has been released yet. **/
	final released: Bool;

	/** The sentinel type. **/
	final type: WakeLockType;

	/** Releases this sentinel. **/
	function release(): Promise<Void>;
}

/** Indicates the type of a `WakeLockSentinel` instance. **/
enum abstract WakeLockType(String) from String to String {
	var Screen = "screen";
}
