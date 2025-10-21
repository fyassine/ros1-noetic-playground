
"use strict";

let SetSpeedOverride = require('./SetSpeedOverride.js')
let SetEndpointFrame = require('./SetEndpointFrame.js')
let SetSmartServoJointSpeedLimits = require('./SetSmartServoJointSpeedLimits.js')
let SetWorkpiece = require('./SetWorkpiece.js')
let SetSmartServoLinSpeedLimits = require('./SetSmartServoLinSpeedLimits.js')
let ConfigureControlMode = require('./ConfigureControlMode.js')
let SetPTPJointSpeedLimits = require('./SetPTPJointSpeedLimits.js')
let SetPTPCartesianSpeedLimits = require('./SetPTPCartesianSpeedLimits.js')
let TimeToDestination = require('./TimeToDestination.js')

module.exports = {
  SetSpeedOverride: SetSpeedOverride,
  SetEndpointFrame: SetEndpointFrame,
  SetSmartServoJointSpeedLimits: SetSmartServoJointSpeedLimits,
  SetWorkpiece: SetWorkpiece,
  SetSmartServoLinSpeedLimits: SetSmartServoLinSpeedLimits,
  ConfigureControlMode: ConfigureControlMode,
  SetPTPJointSpeedLimits: SetPTPJointSpeedLimits,
  SetPTPCartesianSpeedLimits: SetPTPCartesianSpeedLimits,
  TimeToDestination: TimeToDestination,
};
