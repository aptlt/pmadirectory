# SCRIPT MENU #

###############################################

# Chargement des classes
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
. .\hide_console.ps1

###############################################

############# CREATION DE LA FENETRE ###############

$objFormPanel = New-Object System.Windows.Forms.Form 
$objFormPanel.Text = "Menu"
$objFormPanel.Size = New-Object System.Drawing.Size(300,400) 
$objFormPanel.StartPosition = "CenterScreen"
$objFormPanel.BackColor = "#02ACE5"


###############################################

############# Texte : "Choisir l'action a effectuer" ###############

# Texte affiché #

$objLabel = New-Object System.Windows.Forms.Label
$objLabel.Location = New-Object System.Drawing.Size(40,70) 
$objLabel.Size = New-Object System.Drawing.Size(280,20) 
$objLabel.ForeColor = "White"
$objLabel.Text = "Choisissez l'action à effectuer"
$objLabel.Font = New-Object System.Drawing.Font ("Tahoma", 10, [System.Drawing.FontStyle]::Bold)
$objFormPanel.Controls.Add($objLabel) 

# Bouton gestion des utilisateurs #

$UserButton = New-Object System.Windows.Forms.Button
$UserButton.Location = New-Object System.Drawing.Size(10,120)
$UserButton.Size = New-Object System.Drawing.Size(260,40)
$UserButton.Text = "Gestion des utilisateurs"
$UserButton.Font = New-Object System.Drawing.Font ("Tahoma", 10, [System.Drawing.FontStyle]::Bold)
$UserButton.ForeColor = "White"
$UserButton.Add_Click({.\gestion_users\choix_action_users.ps1;$objFormPanel.Close()})
$objFormPanel.Controls.Add($UserButton)
 
# Bouton gestion des ordinateurs #

$ComputersButton = New-Object System.Windows.Forms.Button
$ComputersButton.Location = New-Object System.Drawing.Size(10,180)
$ComputersButton.Size = New-Object System.Drawing.Size(260,40)
$ComputersButton.Text = "Gestion des ordinateurs"
$ComputersButton.Font = New-Object System.Drawing.Font ("Tahoma", 10, [System.Drawing.FontStyle]::Bold)
$ComputersButton.ForeColor = "White"
$ComputersButton.Add_Click({})
$objFormPanel.Controls.Add($ComputersButton)

# Bouton quitter #

$QuitButton = New-Object System.Windows.Forms.Button
$QuitButton.Location = New-Object System.Drawing.Size(105,320)
$QuitButton.Size = New-Object System.Drawing.Size(75,23)
$QuitButton.Text = "Quitter"
$QuitButton.ForeColor = "White"
$QuitButton.Add_Click({$objFormPanel.Close()})
$objFormPanel.Controls.Add($QuitButton)

###############################################


###############################################

# Affichage des éléments

$objFormPanel.Topmost = $True

$objFormPanel.Add_Shown({
    $objFormPanel.Activate()
    Hide-Console
})
[void] $objFormPanel.ShowDialog()


###############################################



