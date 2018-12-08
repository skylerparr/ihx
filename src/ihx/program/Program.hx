/* ************************************************************************ */
/*                                                                          */
/*  Copyright (c) 2009-2013 Ian Martins (ianxm@jhu.edu)                     */
/*                                                                          */
/* This library is free software; you can redistribute it and/or            */
/* modify it under the terms of the GNU Lesser General Public               */
/* License as published by the Free Software Foundation; either             */
/* version 3.0 of the License, or (at your option) any later version.       */
/*                                                                          */
/* This library is distributed in the hope that it will be useful,          */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of           */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU        */
/* Lesser General Public License or the LICENSE file for more details.      */
/*                                                                          */
/* ************************************************************************ */

package ihx.program;

import haxe.ds.StringMap;

using StringTools;
using Lambda;

interface Program
{
    function addStatement(stmt :String): Void;

    function clearStatements(): Void;

    /**
       no error when the last command was evaluated.  include it in the program.
     */
    function acceptLastCmd(val :Bool): Void;

    /**
       get list of declared variables
     */
    function getVars() :List<String>;

    /**
       get the program as a string
     */
    function getProgram( includeHelpers: Bool = true ): String;
}
