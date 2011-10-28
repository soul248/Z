<?php
function create_as_file()
{
    pake_echo('Creating AS file for assets');
	if(file_exists('assets/Assets.as')) unlink('assets/Assets.as');
	if(file_exists('assets/Assets.swf')) unlink('assets/Assets.swf');
	$asFile = fopen('assets/Assets.as', 'w');
	fwrite($asFile, 'package');
	fwrite($asFile, '{');
	fwrite($asFile, '  import flash.display.MovieClip;');
	fwrite($asFile, '  public class Assets extends MovieClip');
	fwrite($asFile, '  {');
	fwrite($asFile, '  ');
	
	foreach (new DirectoryIterator('assets') as $fileInfo) 
	{			
		if($fileInfo->isFile())
		{
			if(substr_count($fileInfo->getFilename(),'.swf')>0)
			{
				fwrite($asFile, '    [Embed(source = "'.$fileInfo->getFileName().'")]');
				fwrite($asFile, '    private static var '.$fileInfo->getBasename('.swf').':Class;');						
			}
			if(substr_count($fileInfo->getFilename(),'.png')>0)
			{
				fwrite($asFile, '    [Embed(source = "'.$fileInfo->getFileName().'")]');
				fwrite($asFile, '    private static var '.$fileInfo->getBasename('.png').':Class;');						
			}
			if(substr_count($fileInfo->getFilename(),'.mp3')>0)
			{
				fwrite($asFile, '    [Embed(source = "'.$fileInfo->getFileName().'")]');
				fwrite($asFile, '    private static var '.$fileInfo->getBasename('.mp3').':Class;');						
			}
		}
	}
	
	fwrite($asFile, '  }');
	fwrite($asFile, '}');
	fclose($asFile);
	
	return 'assets/Assets.as';
}

pake_desc('Run a debug version');
pake_task('default');
function run_default()
{
    create_as_file();
    pake_echo('Compiling new Assets file');
	$shell_command = 'mxmlc -optimize=true -debug=true -default-background-color=#FFFFFF -static-link-runtime-shared-libraries=true -default-frame-rate=60 -compatibility-version=3.0.0 -output=assets/Assets.swf assets/Assets.as';
	$output = shell_exec($shell_command);
	pake_echo($output);
    
	pake_echo('Compiling new Main file');
	$shell_command = 'mxmlc -optimize=true -debug=true -default-background-color=#FFFFFF -static-link-runtime-shared-libraries=true -default-frame-rate=60 -compatibility-version=3.0.0 -output=Z.swf -library-path+=lib/alcon -default-size 1024 768 src/Main.as';
	$output = shell_exec($shell_command);
	pake_echo($output);
}
