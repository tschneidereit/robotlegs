/*
 * Copyright (c) 2012 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.adapters
{
	import avmplus.DescribeTypeJSON;

	import flash.system.ApplicationDomain;

	import org.robotlegs.core.IReflector;
	import org.swiftsuspenders.DescribeTypeJSONReflector;
	import org.swiftsuspenders.DescribeTypeReflector;
	import org.swiftsuspenders.Reflector;

	/**
	 * SwiftSuspender <code>IReflector</code> adpater - See:
	 * <a href="http://github.com/tschneidereit/SwiftSuspenders">SwiftSuspenders</a>
	 * 
	 * @author tschneidereit
	 */
	public class SwiftSuspendersReflector implements IReflector
	{
		private var _reflector : Reflector;

		public function SwiftSuspendersReflector()
		{
			try
			{
				_reflector = DescribeTypeJSON.available
					? new DescribeTypeJSONReflector()
					: new DescribeTypeReflector();
			}
			catch (e:Error)
			{
				_reflector = new DescribeTypeReflector();
			}
		}

		public function classExtendsOrImplements(
			classOrClassName : Object, superclass : Class,
			applicationDomain : ApplicationDomain = null) : Boolean
		{
			var type : Class = classOrClassName is Class
				? Class(classOrClassName) 
				: classOrClassName['constructor'];
			return _reflector.typeImplements(type, superclass);
		}

		public function getClass(value : *, applicationDomain : ApplicationDomain = null) : Class
		{
			return _reflector.getClass(value);
		}

		public function getFQCN(value : *, replaceColons : Boolean = false) : String
		{
			return _reflector.getFQCN(value, replaceColons);
		}
	}
}