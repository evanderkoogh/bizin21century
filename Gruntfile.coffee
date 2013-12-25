module.exports = (grunt) ->

	cfg =
		pkg: grunt.file.readJSON 'package.json'
		clean:
			build: ['build']
		cssmin:
			combine:
				files:
					'contents/css/style.css': ['theme/css/bootstrap.css', 'theme/css/fonts/font-awesome/css/font-awesome.css', 'theme/css/theme.css', 'theme/css/theme-elements.css', 'theme/css/theme-animate.css', 'theme/css/theme-blog.css', 'theme/css/skins/blue.css', 'theme/css/custom.css', 'theme/css/theme-responsive.css']
		uncss:
			dist:
				files:
					'build/css/style.css': ['build/**/*.html']
				options:
					compress: true
					stylesheets: ['build/css/style.css']
		s3:
			options:
				key: process.env.AWS_ACCESS_KEY_ID,
				secret: process.env.AWS_SECRET_ACCESS_KEY,
				access: 'public-read',
				bucket: 'businessin21stcentury.com'
				region: 'eu-west-1'
				maxOperations: 5
			uncached:
				sync: [
    				src: 'build/**/*',
    				dest: '/',
    				rel: 'build'
    				options:
    					verify: true
    				]

	grunt.initConfig cfg

	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-cssmin'
	grunt.loadNpmTasks 'grunt-uncss'
	grunt.loadNpmTasks 'grunt-s3'