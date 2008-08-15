require 'test/unit'

class TechDebtTest < Test::Unit::TestCase
  # Replace this with your real tests.
  def test_this_plugin
    td_pattern = /^[ ]*(## td)[ ]*(?:\((\d+)\))?([\w ]*)?:?([\w !&%#,:;+\-\?\.=]*)(?:\/\/)?([\w ]*)/i

    test_data = [
      {:text => "Should not match this.", :expected => []},
      {:text => "Only match ## td at beginning of line", :expected => []},
      {:text => "  ## td", :expected => [["## td", nil, "", "", ""]]},
      {:text => "  ## TD", :expected => [["## TD", nil, "", "", ""]]},
      {:text => "  ## td (4)", :expected => [["## td", "4", "", "", ""]]},
      {:text => "## td (3)  test: Prioritized test at level 3 // David",
       :expected => [["## td", "3", "  test", " Prioritized test at level 3 ", " David"]]},
      {:text => "## td   test: Missing test for invalid parameters // Erik",
       :expected => [["## td", nil, "test", " Missing test for invalid parameters ", " Erik"]]},
      {:text => "## td test func: Missing test for unauthorized user //",
       :expected => [["## td", nil, "test func", " Missing test for unauthorized user ", ""]]},
      {:text => "## td (5) note: This is a note // John",
       :expected => [["## td", "5", " note", " This is a note ", " John"]]},
      {:text => "## td (5) note: Special &%#?!,.:;+-= chars // John",
       :expected => [["## td", "5", " note", " Special &%#?!,.:;+-= chars ", " John"]]},
    ]
    
    test_data.each do |data|
#      print "Expected: "
#      p data[:expected]
#      print "Result:   "
#      p data[:text].scan(td_pattern)
#      puts
      assert_equal data[:expected], data[:text].scan(td_pattern)
    end
  end
end
