require 'erb'

When /\A\(erb\) (.*)\z/ do |*matches|
  s = ERB.new(matches[0]).result(binding)
  if matches.size > 1
    s = <<-MULTI
    #{s}
    """
    #{ERB.new(matches[1]).result(binding)}
    """
MULTI
  end
  steps "And #{s}"
end
