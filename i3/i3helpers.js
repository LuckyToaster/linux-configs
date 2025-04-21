const { execSync } = require('child_process');

const currentWorkspaceQuery = "i3-msg -t get_workspaces | jq -r '.[] | select(.focused == true) .name'"
const windowsQuery = (workspaceNum) => `i3-msg -t get_tree | jq '.. | select(.type? == "workspace" and .name == "${workspaceNum}")'`


function demonstration() {
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
}


function getNumNonFloatingWindows() {
    const curws = JSON.parse(execSync(currentWorkspaceQuery))
    const windows = JSON.parse(execSync(windowsQuery(curws)))
    return windows.nodes.length
}

module.exports = getNumNonFloatingWindows
