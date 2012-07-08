fs = require 'fs'
handlebars = require 'handlebars'
path = require 'path'

exports.compile = (directory) ->
  output = []
  output.push('(function() {\n  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};\n')
  fs.readdirSync(directory).forEach (template) ->
    fullPath = path.join directory, template
    if path.extname(fullPath) == '.html'
      data = fs.readFileSync fullPath, 'utf8'
      template = path.basename template, '.html'

      output.push "templates['#{template}'] = template(#{handlebars.precompile(data)});\n"

  output.push '})();'
  output.join ''
