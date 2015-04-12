require File.expand_path(File.dirname(__FILE__) + '/neo')
 
class String
  def cipher(rot)
  end
end
 
class Array
  def count_elements
  end
 
  def duplicates(times)
  end
end
 
class Hash
  def sort_by_key 
  end
 
  def sort_by_value
  end
end
 
class AboutMixProject < Neo::Koan
  def test_array_count_elements
    ar = [1, 2, 1]
    assert_equal({"1"=>2, "2"=>1}, ar.count_elements)
 
    ar = [1, 2, 1, 3, 1]
    assert_equal({"1"=>3, "2"=>1, "3"=>1}, ar.count_elements)
  end
 
  def test_sort_hash_by_key_or_value
    hash = {"10"=>5, "05"=>3, "01"=>4}
 
    assert_equal({"01"=>4, "05"=>3, "10"=>5}, hash.sort_by_key)
    assert_equal({"05"=>3, "01"=>4, "10"=>5}, hash.sort_by_value)
  end
 
  def test_extract_duplicates_values
    ar = [1, 2, 1, 3, 3, 3]
 
    assert_equal [1, 3], ar.duplicates
    assert_equal [1, 3], ar.duplicates(2)
    assert_equal [3], ar.duplicates(3)
    assert_equal [], ar.duplicates(4)
  end
 
  def test_cesar_cipher
    assert_equal "VQREQFGT", "TOPCODER".cipher(2)
    assert_equal "QRSTUVWXYZABCDEFGHIJKLMNOP", "ABCDEFGHIJKLMNOPQRSTUVWXYZ".cipher(16)
    assert_equal "NOP", "ABC".cipher
  end
 
end