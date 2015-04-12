require File.expand_path(File.dirname(__FILE__) + '/neo')
 
class String
  def cipher(rot=13)
    result  = ""
    chars.each{|char|
      if char.ord >= 65 && char.ord <= 90
        result += (char.ord+rot+(char.ord > (90-rot) ?-26:0)).chr
      else
        result += (char.ord+rot+(char.ord > (122-rot) ?-26:0)).chr
      end
    }
    result
  end
end
 
class Array
  def count_elements
    values = {}
    self.each{|value|
      values[value.to_s] = 0 if values[value.to_s].nil?
      values[value.to_s] += 1
    }
    values
  end
 
  def duplicates(times=2)
    uniq.sort.select{|value|
      count(value) >= times
    }
  end
end
 
class Hash
  def sort_by_key 
    Hash[self.sort]
  end
 
  def sort_by_value
    Hash[self.sort_by {|k,v| v}]
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