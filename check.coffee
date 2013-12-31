#!/usr/bin/env coffee

teacher = require 'teacher'
fs = require 'fs'

fs.readFile process.argv[2], {encoding: "UTF8"}, (err, contents) ->
	unless err
		console.log contents
		teacher.check contents, (err, checks) ->
			unless err
				console.log 'results:'
				console.log checks
			else
				console.log "ERROR: #{JSON.stringify(err)}"
	else
		console.log "ERROR: #{JSON.stringify(err)}"