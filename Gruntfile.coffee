module.exports = (grunt) ->

	cfg =
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
		imagemin:
			dist:
				options:
					optimizationLevel: 3
				files: [
					expand: true
					cwd: 'build/'
					src: '**/*.{jpg,png}'
					dest: 'build/'
				]
		htmlmin:
			dist:
				options:
					removeComments: true
					collapseWhitespace: true
				files: [
					expand: true
					cwd: 'build/'
					src: '**/*.html'
					dest: 'build/'		
				]
		hashres: 
			options:
				fileNameFormat: '${name}.${hash}.cache.${ext}'
			jscss:
				src: ['build/css/style.css', 'build/js/*.js']
				dest: ['build/**/*.html']
			images:
				src: ['build/**/*.jpg', 'build/**/*.png', '!build/img/icons/*']
				dest: ['build/**/*.html']
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
					src: ['build/**/*', '!build/**/*.cache.*']
					dest: '/'
					rel: 'build'
					options:
						verify: true
					]
			cached:
				sync: [
					src: ['build/**/*.cache.*']
					dest: '/'
					rel: 'build'
					options:
						verify: true
						headers:
							'Cache-Control': 'public,max-age=7776000'
    				]
		wintersmith:
			build: {}

	grunt.initConfig cfg

	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-cssmin'
	grunt.loadNpmTasks 'grunt-contrib-htmlmin'
	grunt.loadNpmTasks 'grunt-contrib-imagemin'
	grunt.loadNpmTasks 'grunt-hashres'
	grunt.loadNpmTasks 'grunt-uncss'
	grunt.loadNpmTasks 'grunt-s3'
	grunt.loadNpmTasks 'grunt-wintersmith'

	grunt.registerTask 'release', [
		'clean'
		'wintersmith:build'
		'hashres'
		'imagemin'
		'htmlmin'
		's3'
	]