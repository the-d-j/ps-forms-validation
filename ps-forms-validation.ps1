# Status: 22 Aug 2023 1457hrs
# Forms and buttons are working and can call script

# TODO:
# need to pass given filenames to merge script
# How? Assign filename inputs to vars and pass the vars to merge.ps1?
# Just merge the called script into this script? Not as versatile then...

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'File Verification'
$form.Size = New-Object System.Drawing.Size(400, 300)
$form.StartPosition = 'CenterScreen'

$filename1Label = New-Object System.Windows.Forms.Label
$filename1Label.Location = New-Object System.Drawing.Point(10,20)
$filename1Label.Size = New-Object System.Drawing.Size(280,20)
$filename1Label.Text = 'Enter the first filename:'
$form.Controls.Add($filename1Label)

$filename1Textbox = New-Object System.Windows.Forms.TextBox
$filename1Textbox.Location = New-Object System.Drawing.Point(10,40)
$filename1Textbox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($filename1Textbox)

$filename2Label = New-Object System.Windows.Forms.Label
$filename2Label.Location = New-Object System.Drawing.Point(10,70)
$filename2Label.Size = New-Object System.Drawing.Size(280,20)
$filename2Label.Text = 'Enter the second filename:'
$form.Controls.Add($filename2Label)

$filename2Textbox = New-Object System.Windows.Forms.TextBox
$filename2Textbox.Location = New-Object System.Drawing.Point(10,90)
$filename2Textbox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($filename2Textbox)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(100, 160)
$okButton.Size = New-Object System.Drawing.Size(100, 30)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(210,160)
$cancelButton.Size = New-Object System.Drawing.Size(100, 30)
$cancelButton.Text = 'Cancel'
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $file1Exists = Test-Path $filename1Textbox.Text
    $file2Exists = Test-Path $filename2Textbox.Text
    
    if ($file1Exists -and $file2Exists) {
        [System.Windows.Forms.MessageBox]::Show("Both files exist. Running script...")
        $outputBox = New-Object Windows.Forms.TextBox 
        $outputBox.Multiline = $true 
        $outputBox.ScrollBars = "Vertical" 
        $outputBox.Width = 350 
        $outputBox.Height = 100 
        $form.Controls.Add($outputBox) 
        $outputBox.Location = New-Object Drawing.Point(20, 200) 

        #### Change path and script name below.... ####
        & "c:\path\to\your\script\scriptName.ps1" | Out-String | ForEach-Object { $outputBox.AppendText($_ + "`r`n") }

    } else {
        if (!$file1Exists) {
            [System.Windows.Forms.MessageBox]::Show("$($filename1Textbox.Text) does not exist.")
        }
        if (!$file2Exists) {
            [System.Windows.Forms.MessageBox]::Show("$($filename2Textbox.Text) does not exist.")
        }
    }
}