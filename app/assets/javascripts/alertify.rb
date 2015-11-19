class Alertify

  def self.method_missing method, *args
    return super unless %w{log error success alert confirm prompt}.include?(method)
    `alertify[#{method}](#{args})`
  end

end
