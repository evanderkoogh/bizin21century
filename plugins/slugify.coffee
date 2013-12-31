#slugify = require 'slug'
path = require 'path'

module.exports = (env, callback) ->

	env.registerGenerator 'slugify', (contents, callback) ->
		articles = contents['articles']._.directories.map (item) -> item.index
		for article in articles
			console.log article
			dirname = path.basename(path.dirname(article.filepath.relative))
			article.slug = dirname
		callback null

	# tell the plugin manager we are done
	callback()