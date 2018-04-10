cls;
$rgname = 'fbgguggenheimrg';
$autoacct = 'fbgautomation';
$destacct = 'fbgjapan';
$path = 'C:\automation\Runbooks';
$runbooks = @();
$runbookinfo = @();

$runbooks = Get-AzureRmAutomationRunbook -ResourceGroupName $rgname -AutomationAccountName $autoacct -Verbose;

foreach($runbook in $runbooks)
{
    $export = Export-AzureRmAutomationRunbook -ResourceGroupName $rgname -AutomationAccountName $autoacct -Name $runbook.Name -OutputFolder $path -Force;
    $runbook.RunbookType;
    $runbookinfo += @{Name=$runbook.Name; Type=$runbook.RunbookType; File=$export.Name};
}

foreach($info in $runbookinfo)
{
    $info.Name, $info.Type, $info.File;

    switch($info.Type)
    {
        'Script' {'PowerShellWorkflow'}
    }
    #Import-AzureRMAutomationRunbook -Name $info.Name -Path $info.File `
    #-ResourceGroupName $rgname -AutomationAccountName $autoacct `
    #-Type $info.Type; 

}
#$files = (Get-ChildItem -Path $path).Name;

#$files;

