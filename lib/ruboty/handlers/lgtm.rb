require 'ruboty/lgtm/actions/lgtm'

module Ruboty
  module Handlers
    class Llgt < Ruboty::Handlers::Base
      on(/lgtm/i, name: 'lgtm', description: 'Get a LGTM image from lgtm.in')

      def lgtm(message)
        Ruboty::LGTM::Actions::LGTM.new(message).call
      end
    end
  end
end
