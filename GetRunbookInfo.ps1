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

    switch($info.Type)
    {
        'GraphPowerShell' {$info.Type = 'GraphicalPowerShell'}
        'Python2' {$info.Type = 'PowerShellWorkflow'}
        'PowerShell' {$info.Type = 'PowerShell'}
        'Script' {$info.Type = 'PowerShellWorkflow'}
        'GraphPowerShellWorkflow' {$info.Type = 'GraphicalPowerShellWorkflow'}
    }
    $info.Name, $info.Type, $info.File;
    #Import-AzureRMAutomationRunbook -Name $info.Name -Path $info.File `
    #-ResourceGroupName $rgname -AutomationAccountName $autoacct `
    #-Type $info.Type; 

}
#$files = (Get-ChildItem -Path $path).Name;

#$files;

