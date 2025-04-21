#!/usr/bin/env node

const { execSync } = require('child_process')

const id = new String(execSync('xinput list'))
    .split('\n')
    .filter(l => l.includes('Touchpad'))[0]
    .match(/id="?(\d+)"?/)[1]

execSync(`xinput set-prop ${id} "libinput Tapping Enabled" 1`)
execSync(`xinput set-prop ${id} "libinput Natural Scrolling Enabled" 1`)
