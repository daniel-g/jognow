# Thanks to jnicklass
# https://gist.github.com/jnicklas/4129937

require "timeout"

module BecomeTrueMatcher
  extend RSpec::Matchers::DSL

  matcher :become_true do
    match do |block|
      begin
        Timeout.timeout(Capybara.default_wait_time) do
          sleep(0.1) until value = block.call
          value
        end
      rescue TimeoutError
        false
      end
    end
  end
end
