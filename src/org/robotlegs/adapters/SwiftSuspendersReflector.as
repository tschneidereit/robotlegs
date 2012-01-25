/*
 * Copyright (c) 2012 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.adapters
{
	import flash.system.ApplicationDomain;

	import org.robotlegs.core.IReflector;
	import org.swiftsuspenders.DescribeTypeReflector;

	/**
	 * SwiftSuspender <code>IReflector</code> adpater - See:
	 * <a href="http://github.com/tschneidereit/SwiftSuspenders">SwiftSuspenders</a>
	 * 
	 * @author tschneidereit
	 */
	public class SwiftSuspendersReflector extends DescribeTypeReflector implements IReflector
	{
		public function classExtendsOrImplements(
			classOrClassName : Object, superclass : Class,
			applicationDomain : ApplicationDomain = null) : Boolean
		{
			var type : Class = classOrClassName is Class 
				? Class(classOrClassName) 
				: classOrClassName['constructor'];
			return typeImplements(type, superclass);
		}
	}
}