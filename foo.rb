module Q
  def foo
    self.bar = "qux"
  end
end


class G
  def bar=(s)
    @bar = s
  end
  def bar
    @bar
  end
end

g = G.new
g.foo
puts g.bar
