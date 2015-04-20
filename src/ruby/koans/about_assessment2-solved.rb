require File.expand_path(File.dirname(__FILE__) + '/neo')

class Array
  
  def apply_operation(operation)
  	if(operation == :avg)
  		self.inject(:+)/self.count
  	else
  		self.inject(operation)
  	end
  end
 
end
 
class Hash
  def sort_by_value_inverse(kind = :key)
  	if kind == :key
  		Hash[self.sort.reverse]
  	else
  		Hash[self.sort_by {|k,v| v}.reverse]
  	end
  end
end
 
class Counter
	
	# year range 2010-2014
	def count_place_by_year(place)
		events = File.read("events_by_year.txt")
		years = Hash.new(0)
		events.split("\n").select{|row|
			row.include? place
		}.each{|row|
			years[row.split(", ")[1].to_i] += 1
		}
		if years.keys.size < 5
			(2010..2014).each{|year|
				unless years.keys.include? year
					years[year] = 0
				end
			}
		end
		Hash[years.sort]
  end

  def count_degree_by_order(person, degree_stop)
  	degrees = File.read("degrees_by_person.txt")
  	degree_order = ['ensino-fundamental', 'ensino-medio', 'graduacao', 'aperfeicoamento', 'especializacao', 'mestrado', 'doutorado', 'pos-doutorado']

  	degree_count = {}
  	degree_order.each{|degree|
  		degree_count[degree] = 0
  	}

  	degrees.split("\n").select{|row|
			row.include? person
		}.each{|row|
			degree_count[row.split(", ")[1]] += 1
		}

		count = 0
		degree_order.each{|degree|
			count += degree_count[degree]
			break if degree == degree_stop
		}
		count
  end
  
end
 
class AboutMixProject < Neo::Koan

  def test_array_apply_operation
    ar = [1, 2, 1]
    assert_equal(4, ar.apply_operation(:+))
    assert_equal(2, ar.apply_operation(:*))
    assert_equal(1, ar.apply_operation(:avg))
 		ar += [4, 5]
 		assert_equal(13, ar.apply_operation(:+))
    assert_equal(40, ar.apply_operation(:*))
    assert_equal(2, ar.apply_operation(:avg))
  end
 
  def test_inverse_sort_hash
    hash = {"10"=>5, "05"=>3, "01"=>4}
    assert_equal({"10"=>5, "05"=>3, "01"=>4}, hash.sort_by_value_inverse)
    assert_equal({"10"=>5, "01"=>4, "05"=>3}, hash.sort_by_value_inverse(:value))
  end

  def test_process_count_place_by_year
  	place = Counter.new
  	assert_equal({2010=>2, 2011=>2, 2012=>0, 2013=>4, 2014=>4},place.count_place_by_year('joao pessoa'))
  	assert_equal({2010=>4, 2011=>2, 2012=>1, 2013=>1, 2014=>1},place.count_place_by_year('sao paulo'))
  end

  def test_process_count_degree_by_order
  	place = Counter.new
  	assert_equal(3, place.count_degree_by_order('10101010', 'graduacao'))
  	assert_equal(6, place.count_degree_by_order('10101010', 'doutorado'))
  	assert_equal(2, place.count_degree_by_order('40404040', 'doutorado'))
  	assert_equal(4, place.count_degree_by_order('30303030', 'especializacao'))
  	assert_equal(4, place.count_degree_by_order('20202020', 'aperfeicoamento'))
  end
  
end