#!/usr/bin/env node

const { execSync } = require('child_process')
const { currentWorkspaceQuery, windowsQuery } = require('./i3')

const curws = JSON.parse(execSync(currentWorkspaceQuery))
const windows = JSON.parse(execSync(windowsQuery(curws)))

console.log(`Number of non-floating nodes: ${windows.nodes.length}`)
console.log(`Number of floating nodes: ${windows.floating_nodes.length}`)

// See how floating_nodes JSON is different and more deeply nested than nodes JSON ?
windows.nodes.forEach(n => console.log(n.window_properties))
windows.floating_nodes.forEach(n => {
    if (n.nodes.length > 0) 
        n.nodes.forEach(node => console.log(node.window_properties))
})
