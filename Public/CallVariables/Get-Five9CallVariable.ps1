<#
.SYNOPSIS
    
    Function used to get call variable(s) from Five9

.PARAMETER Name
 
    Name of existing call variable

.PARAMETER Group
 
    Group Name of existing call variable
   
.EXAMPLE
    
    Get-Five9CallVariable -Name "ANI" -Group "Call"
    
    # Returns call variable "ANI" within group "Call"
    
#>

function Get-Five9CallVariable
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$false)][string]$Name,
        [Parameter(Mandatory=$false)][string]$Group
    )
    
    try
    {
        Test-Five9Connection -ErrorAction: Stop

        try
        {
            $response = $global:DefaultFive9AdminClient.getCallVariables($Name, $Group)
        }
        catch
        {

        }

        if ($response -eq $null)
        {
            throw "Cannot find a Call Variable with name: ""$Name"" within the Group ""$Group"". Remember that Name and Group are case sensitive."
            return
        }

        Write-Verbose "$($MyInvocation.MyCommand.Name): Returning Five9 call variable '$Name' within group '$Group'." 
        return $response

    }
    catch
    {
        Write-Error $_
    }
}



