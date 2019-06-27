function Get-CustomFunctions {
	Get-ChildItem $PSScriptRoot | Where-Object {$_.Name -like "*.ps1"} | ForEach-Object {$_.Name.split('.')[0]}
}