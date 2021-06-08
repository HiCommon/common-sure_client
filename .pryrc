# frozen_string_literal: true

root_pryrc = File.join(__dir__, '../../.pryrc')

if File.file?(root_pryrc)
  eval File.read(root_pryrc) # rubocop:disable Security/Eval
end
