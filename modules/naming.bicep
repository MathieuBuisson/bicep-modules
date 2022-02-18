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

var regionCodeMap = {
  northeurope: 'ne'
  northcentralus: 'nus'
  centralus: 'cus'
  australiasoutheast: 'ase'
}

var regionCode = regionCodeMap[location]

// 3-character suffix to add some uniqueness for resources which require a globally unique name
var suffix = toLower(take(uniqueString(resourceGroup().id, application, environment, location), 3))

output storageAccountName string = 'st${application}${environment}${regionCode}${suffix}'
output appServicePlanName string = 'plan-${application}-${environment}-${regionCode}'
output functionAppName string = 'func-${application}-${environment}-${regionCode}-${suffix}'
output keyVaultName string = 'kv${application}${environment}${regionCode}${suffix}'
