class Cell
  def initialize(json)
    @json = json
  end
  def [](key)
    @json[key]
  end
  def []=(key,value)
    @json[key]=value
  end

  def Cell.arr(jsons)
    cells = []
    jsons.each do |json|
      cells.push Cell.new(json)
    end
    return cells
  end

  def to_partial_path
    "cells/cell"
  end

  def to_s
    @json.to_s
  end
end