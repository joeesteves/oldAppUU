# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
ActiveSupport::Inflector.inflections(:en) do |inflect|
  # inflect.uncountable %w( fish sheep )

  my_inflections = {
    'plural': [
      [/([a-z]+n)$/i, '\1es'],
      [/([a-z]+l)$/i, '\1es'],
      [/([a-z]+r)$/i, '\1es'],
      [/([a-z]+d)$/i, '\1es'],
      [/([a-z]+a)$/i, '\1s']
    ],
    'singular': [
      [/([a-z]+n)es$/i, '\1'],
      [/([a-z]+l)es$/i, '\1'],
      [/([a-z]+r)es$/i, '\1'],
      [/([a-z]+d)es$/i, '\1'],
    ]
  }

  my_inflections.each do |k,v|
    v.each { |t| inflect.send(k, t[0], t[1]) }
  end
end



# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
