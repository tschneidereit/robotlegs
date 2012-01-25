/*
 * Copyright (c) 2012 the original author or authors
 *
 * Permission is hereby granted to use, modify, and distribute this file
 * in accordance with the terms of the license agreement accompanying it.
 */

package org.robotlegs.adapters
{
	import flash.system.ApplicationDomain;

	import org.robotlegs.core.IInjector;
	import org.swiftsuspenders.Injector;
	import org.swiftsuspenders.dependencyproviders.OtherMappingProvider;

	/**
	 * SwiftSuspender <code>IInjector</code> adpater -
	 * See: <a href="http://github.com/tschneidereit/SwiftSuspenders">SwiftSuspenders</a>
	 *
	 * @author tschneidereit
	 */
	public class SwiftSuspendersInjector implements IInjector
	{
		private var _injector : Injector;

		public function SwiftSuspendersInjector(xmlConfig:XML = null)
		{
			_injector = new Injector();
		}
		
		/**
		 * @inheritDoc
		 */
		public function createChild(applicationDomain:ApplicationDomain = null):IInjector
		{
			var injector:SwiftSuspendersInjector = new SwiftSuspendersInjector();
			injector._injector = _injector.createChildInjector(applicationDomain);
			return injector;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get applicationDomain():ApplicationDomain
		{
			return _injector.applicationDomain;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set applicationDomain(domain:ApplicationDomain):void
		{
			_injector.applicationDomain = domain;
		}

		public function mapValue(whenAskedFor : Class, useValue : Object, named : String = "") : *
		{
			return _injector.map(whenAskedFor, named).toValue(useValue);
		}

		public function mapClass(
			whenAskedFor : Class, instantiateClass : Class, named : String = "") : *
		{
			return _injector.map(whenAskedFor, named).toType(instantiateClass);
		}

		public function mapSingleton(whenAskedFor : Class, named : String = "") : *
		{
			return _injector.map(whenAskedFor, named).asSingleton();
		}

		public function mapSingletonOf(
			whenAskedFor : Class, useSingletonOf : Class, named : String = "") : *
		{
			return _injector.map(whenAskedFor, named).toSingleton(useSingletonOf);
		}

		public function mapRule(whenAskedFor : Class, useRule : *, named : String = "") : *
		{
			return _injector.map(whenAskedFor, named).toProvider(new OtherMappingProvider(useRule));
		}

		public function injectInto(target : Object) : void
		{
			_injector.injectInto(target);
		}

		public function instantiate(clazz : Class) : *
		{
			return _injector.getInstance(clazz);
		}

		public function getInstance(clazz : Class, named : String = "") : *
		{
			return _injector.getInstance(clazz, named);
		}

		public function unmap(clazz : Class, named : String = "") : void
		{
			_injector.unmap(clazz, named);
		}

		public function hasMapping(clazz : Class, named : String = "") : Boolean
		{
			return _injector.satisfies(clazz, named);
		}

		public function get newInjector() : Injector
		{
			return _injector;
		}
	}
}