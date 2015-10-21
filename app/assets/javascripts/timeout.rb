class Timeout
  def initialize(time=0, &block)
    @timeout = `setTimeout(function(){#{block.call}}, time)`
  end

  def clear
    `clearTimeout(#{@timeout});`
  end
end