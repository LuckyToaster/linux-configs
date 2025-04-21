#!/usr/bin/env node

const currentWorkspaceQuery = "i3-msg -t get_workspaces | jq -r '.[] | select(.focused == true) .name'"
const windowsQuery = (workspaceNum) => `i3-msg -t get_tree | jq '.. | select(.type? == "workspace" and .name == "${workspaceNum}")'`

module.exports = { currentWorkspaceQuery, windowsQuery }
