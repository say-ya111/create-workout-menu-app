require 'test_helper'

class TypeTest < ActiveSupport::TestCase
  
  test "validates name, part_id presence" do
    nonname_type = Type.new(name: " ", part_id: Part.first.id)
    assert_not nonname_type.save
    nonpart_type = Type.new(name: "sample", part_id: " ")
    assert_not nonpart_type.save
  end
end
