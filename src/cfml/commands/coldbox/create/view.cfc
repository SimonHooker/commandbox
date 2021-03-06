/**
* Create a new view in an existing ColdBox application.  Run this command in the root
* of your app for it to find the correct folder.  By default, your new view will be created in /views but you can 
* override that with the directory param.
* .
* {code:bash}
* coldbox create view myView
* {code}
*  
**/
component extends="commandbox.system.BaseCommand" aliases="" excludeFromHelp=false {
	
	/**
	* @name.hint Name of the view to create without the .cfm.
	* @helper.hint Generate a helper file for this view
	* @directory.hint The base directory to create your view in and creates the directory if it does not exist.
	 **/
	function run( 	
		required name,
		boolean helper=false,
		directory='views' 
	){
		// This will make each directory canonical and absolute		
		arguments.directory = fileSystemUtil.resolvePath( arguments.directory );
						
		// Validate directory
		if( !directoryExists( arguments.directory ) ) {
			directoryCreate( arguments.directory );			
		}
		
		// This help readability so the success messages aren't up against the previous command line
		print.line();
		
		var viewContent = '<h1>#arguments.name# view</h1>';
		var viewHelperContent = '<!--- #arguments.name# view Helper --->';
		
		// Write out view
		var viewPath = '#arguments.directory#/#arguments.name#.cfm'; 
		file action='write' file='#viewPath#' mode ='777' output='#viewContent#';
		print.greenLine( 'Created #viewPath#' );				
		
		if( arguments.helper ) {
			// Write out view helper
			var viewHelperPath = '#arguments.directory#/#arguments.name#Helper.cfm'; 
			file action='write' file='#viewHelperPath#' mode ='777' output='#viewHelperContent#';
			print.greenLine( 'Created #viewHelperPath#' );
			
		}
	
	}

}