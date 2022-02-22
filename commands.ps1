az login

az account set --subscription UL_iONCompliance_DEV

bicep build .\modules\function-app.bicep
bicep build .\modules\naming.bicep

$LoginServer = az acr show -n bicepmodulesshare --query "loginServer" -o tsv
$FunctionAppTarget = "br:$LoginServer/function-app:v1.1.0"
$NamingTarget = "br:$LoginServer/naming:v1.1.0"

bicep publish .\modules\function-app.bicep --target $FunctionAppTarget
bicep publish .\modules\naming.bicep --target $NamingTarget
