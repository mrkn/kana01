class Calculator
  class Parser
    class ParseError < StandardError
    end

    def initialize(src)
      @src = src
      @cursor = 0
    end

    attr_reader :src

    def tokens
      @tokens ||= scan
    end

    def parse
      expression
    end

    def get_token
      token = tokens[@cursor]
      @cursor += 1
      token
    end

    def unget_token
      @cursor -= 1 if @cursor > 0
    end

    def expression
      multiplication
    end

    def multiplication
      x1 = addition
      begin
        operator '*'
        x2 = multiplication
        [:*, x1, x2]
      rescue
        x1
      end
    end

    def addition
      x1 = bit_and
      begin
        operator '+'
        x2 = addition
        [:+, x1, x2]
      rescue
        x1
      end
    end

    def bit_and
      x1 = bit_or
      begin
        operator '&'
        x2 = bit_and
        [:&, x1, x2]
      rescue
        x1
      end
    end

    def bit_or
      x1 = number
      begin
        operator '|'
        x2 = bit_or
        [:|, x1, x2]
      rescue
        x1
      end
    end

    def operator(token)
      if get_token != token
        unget_token
        raise ParseError
      end
    end

    def number
      case token = get_token
      when Integer
        token
      else
        raise ParseError
      end
    end

    private

    def scan
      src.scan(/\d+|[*+&|]/).map do |token|
        case token
        when /\d+/
          token.to_i
        else
          token
        end
      end
    end
  end
end
