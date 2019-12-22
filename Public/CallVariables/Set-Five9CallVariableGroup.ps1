<#
.SYNOPSIS
    
    Function used to modify an existing agent group

.PARAMETER Name
 
    Name of existing call variable group. Case sensitive. (Not possible to change Name using API. Must use GUI)

  
.PARAMETER Description
 
    New description value for existing agent group

.NOTES

    This function can ONLY update the description value on an existing call variable group. Cannot change name.
   
.EXAMPLE
    
    Set-Five9CallVariableGroup -Name "Salesforce" -Description "New description here"
    
    # Updates description on call variable group "Salesforce"
    

#>

function Set-Five9CallVariableGroup
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$true)][string]$Name,
        [Parameter(Mandatory=$true)][string]$Description
    )

    $callVariableGroupToModify = $null
    try
    {
        $callVariableGroupToModify = $global:DefaultFive9AdminClient.getCallVariableGroups($Name)
    }
    catch
    {
        
    }

    if ($callVariableGroupToModify.Count -gt 1)
    {
        throw "Multiple Call Variable Groups were found using query: ""$Name"". Please try using the exact username of the user you're trying to modify."
        return
    }

    if ($callVariableGroupToModify -eq $null)
    {
        throw "Cannot find a Call Variable Groups with name: ""$Name"". Remember that Name is case sensitive."
        return
    }


    
    $response =  $global:DefaultFive9AdminClient.modifyCallVariablesGroup($Name, $Description)

    return $response

}



