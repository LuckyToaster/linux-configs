#!/usr/bin/env node

const { execSync } = require('child_process')
const { currentWorkspaceQuery, windowsQuery } = require('./i3')

const curws = JSON.parse(execSync(currentWorkspaceQuery))
const windows = JSON.parse(execSync(windowsQuery(curws)))

console.log(windows.nodes.length)
