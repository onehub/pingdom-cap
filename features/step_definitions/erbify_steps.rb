require 'erb'

When /\A\(erb\) (.*)\z/ do |*matches|
  erbes = matches.map { |match| ERB.new(match).result(binding) }
  step *erbes
end
