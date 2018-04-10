cls;
$rgname = 'fbgguggenheimrg';
$autoacct = 'fbgautomation';
$destacct = 'fbgjapan';
$path = 'C:\automation\Runbooks';
$runbook = @();


$runbooks = Get-AzureRmAutomationRunbook -ResourceGroupName $rgname -AutomationAccountName $autoacct;

foreach($runbook in $runbooks)
{
    #$runbook;

    $export = Export-AzureRmAutomationRunbook -ResourceGroupName $rgname -AutomationAccountName $autoacct -Name $runbook.Name -OutputFolder $path -Force;
    $export;
    $runbookinfo += @{Name=$runbook.Name; Type=$runbook.RunbookType; File=$export.name};
}

#$runbookinfo;

foreach($info in $runbookinfo)
{
    #$info.Name, $info.Type, $info.File;
    Import-AzureRMAutomationRunbook -Name $info.Name -Path $info.File `
    -ResourceGroupName $rgname -AutomationAccountName $autoacct `
    -Type $info.Type; 

}
#$files = (Get-ChildItem -Path $path).Name;

#$files;

