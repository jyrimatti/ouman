#!/bin/sh

case $1 in
  # airflowAdjustment
  commissioningMode)
    export OBJECTID=398
    ;;
  awaySupplyFanSpeed)
    export OBJECTID=141
    ;;
  homeSupplyFanSpeed)
    export OBJECTID=142
    ;;
  boostSupplyFanSpeed)
    export OBJECTID=143
    ;;
  awayExhaustFanSpeed)
    export OBJECTID=399
    ;;
  homeExhaustFanSpeed)
    export OBJECTID=400
    ;;
  boostExhaustFanSpeed)
    export OBJECTID=401
    ;;
  
  # autoAirQuality
  VOC)
    export OBJECTID=25
    ;;
  AutoAirQualityControlM)
    export OBJECTID=35
    ;;
  AQControl)
    export OBJECTID=160
    ;;
  boostLimit)
    export OBJECTID=126
    ;;
  fullBoostLimit)
    export OBJECTID=127
    ;;
  deviceFWMajor)
    export OBJECTID=81
    ;;
  deviceFWMinor)
    export OBJECTID=82
    ;;

  # autoHomeAwayBoost
  CO2Measurement)
    export OBJECTID=21
    ;;
  travelFunction)
    export OBJECTID=30
    ;;
  AControl)
    export OBJECTID=33
    ;;
  HomeLimit)
    export OBJECTID=122
    ;;
  AwayLimit)
    export OBJECTID=123
    ;;
  smartFunctionVisibilitySummerCoolingBoost)
    export OBJECTID=138
    ;;
  AutoHomeAwayBoostControl)
    export OBJECTID=115
    ;;

  # autoRhControl
  RH)
    export OBJECTID=22
    ;;
  AH)
    export OBJECTID=23
    ;;
  AHSetPoint)
    export OBJECTID=24
    ;;
  autoRHControlM)
    export OBJECTID=34
    ;;
  autoRHControlSP)
    export OBJECTID=159
    ;;
  smartVisibility)
    export OBJECTID=138
    ;;
  rhControlBoostLimit)
    export OBJECTID=124
    ;;
  rhControlFullBoostLimit)
    export OBJECTID=125
    ;;

  # boostSettings
  ventilationSpeedState)
    export OBJECTID=25
    ;;
  travellingFunction)
    export OBJECTID=28
    ;;
  boostTime)
    export OBJECTID=89
    ;;
  travellingMode)
    export OBJECTID=83
    ;;
  fanSpeedMode)
    export OBJECTID=82
    ;;
  maxSmartBoost)
    export OBJECTID=118
    ;;
  
  # fireplaceMode
  fireplaceFunctionRunTime)
    export OBJECTID=91
    ;;
  fireplaceFunctionOverpressure)
    export OBJECTID=92
    ;;
  fireplaceMode)
    export OBJECTID=38
    ;;
  fireplaceOff)
    export OBJECTID=79
    ;;
  fireplaceOn)
    export OBJECTID=78
    ;;
  smartMenuVisibility)
    export OBJECTID=107
    ;;

  # logView
  outsideTemp)
    export OBJECTID=19
    ;;
  supplyTemperature)
    export OBJECTID=17
    ;;
  indoorTemperature)
    export OBJECTID=18
    ;;
  co2)
    export OBJECTID=21
    ;;
  rh)
    export OBJECTID=22
    ;;
  ah)
    export OBJECTID=23
    ;;
  voc)
    export OBJECTID=25
    ;;
  supplyFan)
    export OBJECTID=28
    ;;
  exhaustFan)
    export OBJECTID=29
    ;;

  # serviceReminder
  hoursToNextService)
    export OBJECTID=43
    ;;
  serviceReminder)
    export OBJECTID=132
    ;;
  serviceReminderInterval)
    export OBJECTID=168
    ;;
  
  # automaticFunctions
  co2Visibility)
    export OBJECTID=19
    ;;
  rhVisibility)
    export OBJECTID=20
    ;;
  vocVisibility)
    export OBJECTID=23
    ;;
  
  # commissioning
  travellingModeSpeedDrop)
    export OBJECTID=120
    ;;
  smartModeMaxSupplyFanSpeed)
    export OBJECTID=144
    ;;
  smartVisibilityHood)
    export OBJECTID=135
    ;;
  cookerHomeStateCompensation)
    export OBJECTID=402
    ;;
  cookerBoostCompensation)
    export OBJECTID=403
    ;;
  cookerHoodBoost)
    export OBJECTID=404
    ;;
  roofFanUse)
    export OBJECTID=405
    ;;
  mirrorSupplyExhaust)
    export OBJECTID=439
    ;;
  
  # temperatureControl
  supplyTemp)
    export OBJECTID=17
    ;;
  roomTemp)
    export OBJECTID=18
    ;;
  tempControllerType)
    export OBJECTID=131
    ;;
  tempSetPoint)
    export OBJECTID=163
    ;;
  travellingModeTempDrop)
    export OBJECTID=121
    ;;
  awayModeTempDrop)
    export OBJECTID=165
    ;;
  heatingMode)
    export OBJECTID=164
    ;;
  summerCoolingFunctionMode)
    export OBJECTID=162
    ;;
  
  # temperatureBoost
  outsideTempExt)
    export OBJECTID=17
    ;;
  tempBoostControl)
    export OBJECTID=34
    ;;
  temperatureSetPoint)
    export OBJECTID=127
    ;;
  summerCoolingRoomLimit)
    export OBJECTID=103
    ;;
  supplyControlPowerOutput)
    export OBJECTID=36
    ;;
  temperatureBoostHeatingGain)
    export OBJECTID=101
    ;;
  temperatureBoostCoolingGain)
    export OBJECTID=102
    ;;
  
  # variables
  ServiceInfo)
    export OBJECTID=75
    ;;
  FilterGuardInfo)
    export OBJECTID=76
    ;;
  ActiveAlarms)
    export OBJECTID=44
    ;;
  UnconfirmedInfo)
    export OBJECTID=60
    ;;
  CO2MeasurementUnfiltered)
    export OBJECTID=20
    ;;
  #CO2Measurement)
  #  export OBJECTID=21
  #  ;;
  autoRHControl)
    export OBJECTID=22
    ;;
  rhMeasure)
    export OBJECTID=22
    ;;
  #AH)
  #  export OBJECTID=23
  #  ;;
  AHSetpoint)
    export OBJECTID=24
    ;;
  #VOC)
  #  export OBJECTID=25
  #  ;;
  unitState)
    export OBJECTID=26
    ;;
  ventilationSpeedState_)
    export OBJECTID=27
    ;;
  #travelFunction)
  #  export OBJECTID=30
  #  ;;
  fireplaceTimer)
    export OBJECTID=31
    ;;
  weekTimerActive)
    export OBJECTID=32
    ;;
  #AControl)
  #  export OBJECTID=33
  #  ;;
  AutoRHControl)
    export OBJECTID=34
    ;;
  #AutoRHControlM)
  #  export OBJECTID=34
  #  ;;
  AutoAirQualityControl)
    export OBJECTID=35
    ;;
  #AutoAirQualityControlM)
  #  export OBJECTID=35
  #  ;;
  AutoTemperatureBoostControl)
    export OBJECTID=36
    ;;
  smartControl)
    export OBJECTID=37
    ;;
  DDCFanSpeedControl)
    export OBJECTID=39
    ;;
  fireplaceFunctionActive)
    export OBJECTID=40
    ;;
  centralVacuumCleaner)
    export OBJECTID=41
    ;;
  hoodCompensationActive)
    export OBJECTID=42
    ;;
  fireplaceFunctionOn)
    export OBJECTID=153
    ;;
  fireplaceFunctionOff)
    export OBJECTID=154
    ;;
  shutDownCommand)
    export OBJECTID=155
    ;;
  startUpCommand)
    export OBJECTID=156
    ;;
  fanSpeedMode_)
    export OBJECTID=111
    ;;
  travelMode)
    export OBJECTID=112
    ;;
  cookerHoodFunction)
    export OBJECTID=113
    ;;
  centralVacuumCleanerControl)
    export OBJECTID=114
    ;;
  #AutoHomeAwayBoostControl)
  #  export OBJECTID=115
  #  ;;
  #RH)
  #  export OBJECTID=159
  #  ;;
  #autoRHControlSP)
  #  export OBJECTID=159
  #  ;;
  autoAirQualityControl)
    export OBJECTID=160
    ;;
  autoAirQualityControlSP)
    export OBJECTID=160
    ;;
  boostTime_)
    export OBJECTID=116
    ;;
  temperatureBoostControl)
    export OBJECTID=117
    ;;
  #HomeLimit)
  #  export OBJECTID=122
  #  ;;
  #AwayLimit)
  #  export OBJECTID=123
  #  ;;
  autoAirQualityControlBoostLimit)
    export OBJECTID=126
    ;;
  autoAirQualityControlFullBoostLimit)
    export OBJECTID=127
    ;;
  SmartFunctionVisibilityFireplace)
    export OBJECTID=133
    ;;
  SmartFunctionVisibilityTravelling)
    export OBJECTID=134
    ;;
  smartFunctionVisibilityHood)
    export OBJECTID=135
    ;;
  smartFunctionVisibilityCentralVacuum)
    export OBJECTID=136
    ;;
  smartFunctionSmartBoost)
    export OBJECTID=137
    ;;
  #smartFunctionVisibilitySummerCoolingBoost)
  #  export OBJECTID=138
  #  ;;
  smartFunctionHeatingBoost)
    export OBJECTID=139
    ;;
  SmartFunctionVisibilityShutdown)
    export OBJECTID=140
    ;;
  supplyAway)
    export OBJECTID=141
    ;;
  supplyHome)
    export OBJECTID=142
    ;;
  supplyBoost)
    export OBJECTID=143
    ;;
  supplySmart)
    export OBJECTID=144
    ;;
  #rhControlBoostLimit)
  #  export OBJECTID=124
  #  ;;
  #rhControlFullBoostLimit)
  #  export OBJECTID=125
  #  ;;
  supplyAirTemperature)
    export OBJECTID=17
    ;;
  #indoorTemperature)
  #  export OBJECTID=18
  #  ;;
  temperatureSetPoint_)
    export OBJECTID=157
    ;;
  summerCoolingRoomTempLimit)
    export OBJECTID=130
    ;;
  #tempControllerType)
  #  export OBJECTID=131
  #  ;;
  supplyControlPowerOutput_)
    export OBJECTID=38
    ;;
  summerCoolingBoostRoomTempLimit)
    export OBJECTID=158
    ;;
  summerCoolingActive)
    export OBJECTID=80
    ;;
  summerCoolingBoostMode)
    export OBJECTID=161
    ;;
  #deviceFWMajor)
  #  export OBJECTID=81
  #  ;;
  #deviceFWMinor)
  #  export OBJECTID=82
  #  ;;
  vocLinePos)
    export OBJECTID=83
    ;;
esac
