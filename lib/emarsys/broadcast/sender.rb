module Emarsys
  module Broadcast
    class Sender
      attr_reader :id, :name, :address

      def initialize(id, name, address)
        @id, @name, @address = id, name, address
      end
    end
  end
end