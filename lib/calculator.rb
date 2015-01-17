class Calculator
  def calculate(expression)
    evaluate(Parser.new(expression).parse)
  end

  def evaluate(sexp)
    return sexp if Integer === sexp

    op, x1, x2 = *sexp
    case op
    when :*
      evaluate(x1) * evaluate(x2)
    when :+
      evaluate(x1) + evaluate(x2)
    when :&
      evaluate(x1) & evaluate(x2)
    when :|
      evaluate(x1) | evaluate(x2)
    end
  end
end

require 'calculator/parser'
