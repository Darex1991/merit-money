# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :backend do
  guard 'rspec' do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb') { "spec" }

    # Rails example
    watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml)$}) { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$}) { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
    watch(%r{^spec/support/(.+)\.rb$}) { "spec" }
    watch('app/controllers/application_controller.rb') { "spec/controllers" }

    # Capybara features specs
    watch(%r{^app/views/(.+)/.*\.(erb|haml)$}) { |m| "spec/features/#{m[1]}_spec.rb" }
  end
end

group :frontend do
  guard :jasmine do
    watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$}) { 'spec/javascripts' }
    watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
    watch(%r{spec/javascripts/fixtures/.+$})
    watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)(?:\.\w+)*$}) { |m| "spec/javascripts/#{ m[1] }_spec.#{ m[2] }" }
  end
end
