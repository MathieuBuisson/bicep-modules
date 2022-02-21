az login

az account set --subscription UL_iONCompliance_DEV

bicep build .\modules\function-app.bicep

$LoginServer = 'bicepmodulesshare.azurecr.io'
$Target = "br:$LoginServer/function-app:v1.1.0"
bicep publish .\modules\function-app.bicep --target $Target
