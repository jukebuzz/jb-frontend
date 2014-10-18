guard 'annotate', show_indexes: true do
  watch('db/schema.rb')
end

guard :bundler do
  watch('Gemfile')
end

guard :rubocop do
  watch(/.+\.rb$/)
  watch(/(?:.+\/)?\.rubocop\.yml$/) { |m| File.dirname(m[0]) }
end
