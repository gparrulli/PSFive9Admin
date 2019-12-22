<#
.SYNOPSIS
    
    Function used to get User Profile object(s) from Five9


.PARAMETER NamePattern
 
    Returns only user profiles matching a given regex string
   
.EXAMPLE
    
    Get-Five9UserProfile -AdminClient $proxy
    
    # Returns all User Profiles
    
.EXAMPLE
    
    Get-Five9UserProfile -NamePattern "Call_Center_Agent"
    
    # Returns all profiles matching the string "Call_Center_Agent"
    

 
#>

function Get-Five9UserProfile
{
    [CmdletBinding(PositionalBinding=$false)]
    param
    ( 
        [Parameter(Mandatory=$false)][string]$NamePattern = '.*'
    )
    
    return $global:DefaultFive9AdminClient.getUserProfiles($NamePattern)

}



