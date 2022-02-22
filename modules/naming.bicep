@description('Name of the application or workload')
@maxLength(10)
param application string

@description('Type of environment')
@allowed([
  'dev'
  'test'
  'qa'
  'stage'
  'prod'
])
param environment string

@description('Azure region where resources are located')
@allowed([
  'northeurope'
  'northcentralus'
  'centralus'
  'australiasoutheast'
])
param location string

var regionAbbreviations = {
  northeurope: 'ne'
  northcentralus: 'nus'
  centralus: 'cus'
  australiasoutheast: 'ase'
}

var regionAbbreviation = regionAbbreviations[location]

// 3-character suffix to add some uniqueness for resources which require a globally unique name
var suffix = toLower(take(uniqueString(resourceGroup().id, application, environment, location), 3))

output storageAccountName string = 'st${application}${environment}${regionAbbreviation}${suffix}'
output appServicePlanName string = 'plan-${application}-${environment}-${regionAbbreviation}'
output functionAppName string = 'func-${application}-${environment}-${regionAbbreviation}-${suffix}'
output appInsightsName string = 'appi-${application}-${environment}-${regionAbbreviation}'
