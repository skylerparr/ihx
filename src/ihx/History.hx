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

package ihx;

/**
   remember the past commands.
**/
import sys.io.FileOutput;
import sys.FileSystem;
import sys.io.File;
class History
{
    private static inline var HISTORY_FILE: String = '.ihx_history';

    private var commands :Array<String>;
    private var pos :Int;
    private var historyFile: String;
    private var historyOutput: FileOutput;

    public function new()
    {
        commands = [""];
        pos = 0;
        loadHistory();
    }

    private inline function loadHistory(): Void {
        var cwd = Sys.getCwd();
        historyFile = '${cwd}${HISTORY_FILE}';
        if(FileSystem.exists(historyFile)) {
            var historyStr: String = File.getContent(historyFile);
            var history: Array<String> = historyStr.split('\n');
            for(h in history) {
                if(h.length > 0) {
                    commands.unshift(h);
                }
            }
        }
        File.saveContent(historyFile, '');
        historyOutput = File.append(historyFile, false);

        commands.reverse();
        for(i in 0...20) {
            if(i > commands.length) {
                break;
            }
            if(commands[i] == null || commands[i] == '') {
                continue;
            }
            historyOutput.writeString(commands[i] + '\n');
        }
        commands.reverse();
        historyOutput.flush();
    }

    public function add(cmd)
    {
        if(cmd == '') {
            return;
        }
        if(commands[commands.length - 1] == cmd) {
            pos = commands.length;
            return;
        }
        commands.push(cmd);
        pos = commands.length;
        historyOutput.writeString(cmd + '\n');
        historyOutput.flush();
    }

    public function next()
    {
        return commands[++pos % commands.length];
    }

    public function prev()
    {
        pos--;
        if( pos < 0 ) {
            pos = commands.length;
        }
        if(commands.length == 0) {
            return '';
        } else {
            return commands[pos % commands.length];
        }
    }
}
