<# 
To allow scripts to be ran on Windows:
Run powershell as admin, and run this command:
set-executionpolicy remotesigned
#>

$file_types = @{
  Videos = @(".mkv", ".mp4", ".wmv", ".avi", ".mpg");
  Documents = @(".doc", ".docx", ".pdf", ".ppt", ".txt", ".odt",
              ".xls", ".xlsx", ".ots", ".rtf");
  Music = @(".mp3", ".m4a", ".mid", ".wav", ".wma");
  Pictures = @(".jpg", ".bmp", ".gif", ".png");
  Applications = @(".exe")
}

$user_name = [Environment]::UserName

$base_dir = "C:\Users\" + $user_name

cd $base_dir\Downloads

if(!( Test-Path -Path $base_dir\Downloads\Downloaded_Applications )) { 
    New-Item -ItemType directory -Path $base_dir\Downloads\Downloaded_Applications
}

$downloads = Get-ChildItem

$file_types.GetEnumerator() | % { 
    $key = $_.key;

    if ($key -eq "Applications") {
        $destination = "$base_dir\Downloads\Downloaded_Applications\"
    } else {
        $destination = ([Environment]::GetFolderPath("My$key"))
    }

    $_.value | ForEach {
        $extension = $_;
        $downloads | 
        where { $_.extension -eq "$extension"} | ForEach-Object {
            echo "MOVING $_ TO $destination";
            Move-Item $_ -Destination $destination
        }
    }
}
