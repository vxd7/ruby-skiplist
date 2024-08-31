class SkipList
  class Node
    attr_reader :key, :forward
    attr_accessor :value

    def initialize(key, value, default: nil)
      @key = key
      @value = value
      @forward = []

      @default_ptr = default
    end

    def forward_ptr_at(lvl)
      forward.fetch(lvl, default_ptr)
    end

    def level
      forward.size
    end

    def traverse_level(lvl)
      return to_enum(:traverse_level, lvl) unless block_given?

      current_node = self
      loop do
        yield(current_node)
        break unless current_node.forward_ptr_at(lvl)

        current_node = current_node.forward[lvl]
      end
    end

    def inspect
      "#<SkipList::Node of level #{level} " \
        "with @key = #{key}, @value = #{value}>"
    end

    private

    attr_reader :default_ptr
  end
end
